defmodule SimpleRouter.Openflow.FlowTables do
  @moduledoc """
  Flow Table Definitions
  """

  use Tres.Controller

  alias SimpleRouter.IPv4Address

  @classifier_table_id       0
  @arp_handler_table_id      1
  @routing_table_id          2
  @interface_lookup_table_id 3
  @arp_lookup_table_id       4
  @egress_table_id           5

  def classifier(datapath_id) do
    # ARP
    send_flow_mod_add(
      datapath_id,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      table_id: @classifier_table_id,
      priority: 1,
      match: Match.new(eth_type: 0x0806),
      instructions: [GotoTable.new(@arp_handler_table_id)]
    )

    # IPv4
    send_flow_mod_add(
      datapath_id,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      table_id: @classifier_table_id,
      priority: 1,
      match: Match.new(eth_type: 0x0800),
      instructions: [GotoTable.new(@routing_table_id)]
    )
  end

  def connected_route(iface, datapath_id) do
    send_flow_mod_add(
      datapath_id,
      table_id: @routing_table_id,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      priority: 100 + iface.prefix_length,
      match: Match.new(
        eth_type: 0x0800,
        ipv4_dst: {iface.network_address, iface.subnet_mask}
      ),
      instructions: [
        ApplyActions.new(NxRegMove.new(src_field: :ipv4_dst, dst_field: :reg0)),
        GotoTable.new(@interface_lookup_table_id)
      ]
    )
  end

  def static_route(route, datapath_id) do
    send_flow_mod_add(
      datapath_id,
      table_id: @routing_table_id,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      priority: route.prefix_length,
      match: Match.new(
        eth_type: 0x0800,
        ipv4_dst: {route.dst, route.mask}
      ),
      instructions: [
        ApplyActions.new(SetField.new(reg0: IPv4Address.to_int(route.nexthop))),
        GotoTable.new(@interface_lookup_table_id)
      ]
    )
  end

  def arp_handlers(iface, datapath_id) do
    :ok = arp_request_handler(iface, datapath_id)
    :ok = arp_reply_handler(iface, datapath_id)
    :ok = arp_entry_is_missing(iface, datapath_id)
  end

  def arp_entry_is_missing(iface, datapath_id) do
    send_flow_mod_add(
      datapath_id,
      priority: 0,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      table_id: @arp_lookup_table_id,
      match: Match.new(reg1: iface.number),
      instructions: [
        ApplyActions.new(
          NxController2.new(userdata: arp_packet(iface), pause: true)
        )
      ]
    )
  end

  def lookup_iface(iface, datapath_id) do
    match =
      Match.new(
        reg0: {
          IPv4Address.to_int(iface.network_address),
          IPv4Address.to_int(iface.subnet_mask)
        }
      )

    send_flow_mod_add(
      datapath_id,
      table_id: @interface_lookup_table_id,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      priority: iface.prefix_length,
      match: match,
      instructions: [
        ApplyActions.new([
          SetField.new(reg1: iface.number),
          NxResubmitTable.new(@arp_lookup_table_id),
          NxResubmitTable.new(@egress_table_id)
        ])
      ]
    )
  end

  def egress(iface, datapath_id) do
    send_flow_mod_add(
      datapath_id,
      table_id: @egress_table_id,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      priority: 1,
      match: Match.new(reg1: iface.number),
      instructions: ApplyActions.new(Group.new(iface.number))
    )
  end

  # private functions

  defp arp_request_handler(iface, datapath_id) do
    send_flow_mod_add(
      datapath_id,
      table_id: @arp_handler_table_id,
      priority: 0,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      match: Match.new(
        in_port: iface.number,
        eth_type: 0x0806,
        # Request
        arp_op: 0x1,
        arp_tpa: iface.ip_address
      ),
      instructions: ApplyActions.new(arp_respond_and_learn_actions(iface.mac_address))
    )
  end

  defp arp_reply_handler(iface, datapath_id) do
    send_flow_mod_add(
      datapath_id,
      table_id: @arp_handler_table_id,
      priority: 0,
      bundle_id: 1,
      bundle_flags: [:atomic, :ordered],
      match: Match.new(
        in_port: iface.number,
        eth_type: 0x0806,
        # Reply
        arp_op: 0x2,
        arp_tpa: iface.ip_address
      ),
      instructions: ApplyActions.new(learn_arp_reply_actions())
    )
  end

  defp arp_respond_and_learn_actions(mac) do
    [
      NxLearn.new(
        priority: 1,
        table_id: @arp_lookup_table_id,
        idle_timeout: 300,
        flow_specs: [
          NxFlowSpecMatch.new(src: :arp_spa, dst: :reg0),
          NxFlowSpecLoad.new(src: :eth_src, dst: :eth_dst)
        ]
      ),
      NxStackPush.new(field: :arp_tpa),
      NxStackPush.new(field: :arp_sha),
      NxStackPush.new(field: :arp_spa),
      NxStackPush.new(field: :eth_src),
      NxStackPop.new(field: :eth_dst),
      NxStackPop.new(field: :arp_tpa),
      NxStackPop.new(field: :arp_tha),
      NxStackPop.new(field: :arp_spa),
      SetField.new(arp_op: 0x2),
      SetField.new(arp_sha: mac),
      SetField.new(eth_src: mac),
      Output.new(:in_port)
    ]
  end

  defp learn_arp_reply_actions do
    [
      NxLearn.new(
        priority: 1,
        table_id: @arp_lookup_table_id,
        idle_timeout: 300,
        flow_specs: [
          NxFlowSpecMatch.new(src: :arp_spa, dst: :reg0),
          NxFlowSpecLoad.new(src: :eth_src, dst: :eth_dst)
        ]
      )
    ]
  end

  @arphrd_ether 1
  @eth_p_ip 0x0800

  defp arp_packet(iface) do
    ether_header = <<
      0xffffffffffff::48, # destination ethernet address
      iface.mac_address::48-bits, # source ethernet address
      0x0806::16 # ethernet type
    >>

    # Target Protocol Address will append in NX_PACKET_IN2
    arp_header = <<
      @arphrd_ether::16, # hardware type
      @eth_p_ip::16, # protocol type
      6::8, # hardware address length
      4::8, # protocol address length
      1::16, # ARPOP_REQUEST
      iface.mac_address::48-bits, # Source Hardware Address
      (IPv4Address.to_int(iface.ip_address))::32, # Source Protocol Address
      0x000000000000::48 # Target Hardware Address
    >>

    <<"ARP_missing", ether_header::bytes, arp_header::bytes>>
  end
end
