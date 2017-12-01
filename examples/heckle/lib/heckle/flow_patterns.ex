defmodule Heckle.FlowPatterns do
  use Bitwise
  use Tres.Controller

  @mcast {"010000000000", "010000000000"}

  def flows(%Heckle.Controller.State{flow_pattern: :nat} = state) do
    [[table_id: 1,
      priority: 30,
      cookie: 0x3000000000000001,
      match: Match.new(
        eth_dst:  state.receiver_mac,
        eth_src:  state.sender_mac,
        eth_type: 0x0800,
        ipv4_src: state.inside_local,
        ipv4_dst: state.receiver_ip
      ),
      instructions: [
        ApplyActions.new([
          SetField.new({:eth_dst,  state.receiver_mac}),
          SetField.new({:ipv4_src, state.outside_local}),
          Output.new(state.trunk_port.number)
        ])]
     ],
     [table_id: 1,
      priority: 30,
      cookie: 0x3000000000000001,
      match: Match.new(
        eth_dst:  state.sender_mac,
        eth_src:  state.receiver_mac,
        eth_type: 0x0800,
        ipv4_src: state.receiver_ip,
        ipv4_dst: state.outside_local
      ),
      instructions: [
        ApplyActions.new([
          SetField.new({:eth_src,  state.receiver_mac}),
          SetField.new({:ipv4_dst, state.inside_local}),
          Output.new(state.access_port1.number)
        ])]
     ],
    ] ++ classifier(state)
  end
  def flows(%Heckle.Controller.State{flow_pattern: :bum} = state) do
    [[table_id: 1,
      priority: 30,
      cookie: 0x3000000000000001,
      match: Match.new(
        vlan_vid: state.vlan_id,
        eth_dst:  @mcast
      ),
      instructions: [
        ApplyActions.new([
          Openflow.Action.Output.new(state.trunk_port.number),
          Openflow.Action.PopVlan.new,
          Openflow.Action.Output.new(state.access_port1.number),
          Openflow.Action.Output.new(state.access_port2.number)
        ])]
     ]] ++ classifier(state)
  end

  # private functions

  defp classifier(state) do
    [
      [table_id: 0,
       priority: 50,
       cookie: 0x1000000000000001,
       match: Match.new(
         in_port:  state.trunk_port.number,
         vlan_vid: state.vlan_id
       ),
       instructions: [
         ApplyActions.new([
           PushVlan.new,
           SetField.new({:vlan_vid, state.vlan_id})
         ]),
         GotoTable.new(1)
       ]
      ],
      [table_id: 0,
       priority: 20,
       cookie: 0x1000000000000001,
       match: Match.new(
         in_port:  state.access_port1.number,
         eth_src:  state.sender_mac
       ),
       instructions: [
         ApplyActions.new([
           PushVlan.new,
           SetField.new({:vlan_vid, state.vlan_id})
         ]),
         GotoTable.new(1)
       ]
      ],
      [table_id: 0,
       priority: 20,
       cookie: 0x1000000000000001,
       match: Match.new(
         in_port:  state.access_port2.number,
         eth_src:  state.sender_mac
       ),
       instructions: [
         ApplyActions.new([
           PushVlan.new,
           SetField.new({:vlan_vid, state.vlan_id})
         ]),
         GotoTable.new(1)
       ]
      ],
    ]
  end
end
