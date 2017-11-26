defmodule LearningSwitch.Ofctl do
  use GenServer
  use Tres.Controller

  import Logger

  alias LearningSwitch.FDB

  @ingress_filtering_table_id 0
  @forwarding_table_id        1

  @aging_time 180

  @mcast      {"010000000000", "110000000000"}
  @bcast       "ffffffffffff"
  @ipv6_mcast {"333300000000", "ffff00000000"}

  defmodule State do
    defstruct [
      datapath_id: nil,
      conn_ref:    nil,
      fdb_pid:     nil
    ]
  end

  def start_link(datapath_id, args) do
    GenServer.start_link(__MODULE__, [datapath_id, args])
  end

  def init([datapath_id, _args]) do
    :ok = debug("Switch Ready: datapath_id: #{inspect(datapath_id)}")
    conn_ref = SwitchRegistry.monitor(datapath_id)
    {:ok, pid} = FDB.start_link
    init_datapath(datapath_id)
    state = %State{
      datapath_id: datapath_id,
      conn_ref:    conn_ref,
      fdb_pid:     pid
    }
    {:ok, state}
  end

  def handle_info(%PacketIn{} = packet_in, state) do
    <<_dhost::6-bytes, shost::6-bytes, _rest::bytes>> = packet_in.data
    eth_src = Openflow.Utils.to_hex_string(shost)
    FDB.learn(state.fdb_pid, eth_src, packet_in.in_port)
    add_forwarding_flow_and_packet_out(packet_in, state)
    :ok = debug("PacketIn: eth_src: #{eth_src} datapath_id: #{inspect(state.datapath_id)}")
    {:noreply, state}
  end
  def handle_info({:'DOWN', ref, :process, _pid, _reason}, %State{conn_ref: ref} = state) do
    :ok = debug("Switch Disconnected: datapath_id: #{inspect(state.datapath_id)}")
    {:stop, :normal, state}
  end
  def handle_info(info, state) do
    :ok = warn("Unhandled message #{inspect(info)}: #{inspect(state.datapath_id)}")
    {:noreply, state}
  end

  # private functions

  defp init_datapath(datapath_id) do
    SetConfig.new(miss_send_len: :no_buffer)
    |> send_message(datapath_id)
    init_flow_tables(datapath_id)
  end

  defp init_flow_tables(datapath_id) do
    for flow_options <- [
          add_default_broadcast_flow_entry(),
          add_default_flooding_flow_entry(),
          add_multicast_mac_drop_flow_entry(),
          add_ipv6_multicast_mac_drop_flow_entry(),
          add_default_forwarding_flow_entry()] do
        send_flow_mod_add(datapath_id, flow_options)
    end
  end

  defp add_forwarding_flow_and_packet_out(packet_in, state) do
    <<dhost::6-bytes, _shost::6-bytes, _rest::bytes>> = packet_in.data
    eth_dst = Openflow.Utils.to_hex_string(dhost)
    port_no = FDB.lookup(state.fdb_pid, eth_dst)
    add_forwarding_flow_entry(packet_in, port_no)
    packet_out(packet_in, port_no || :flood)
  end

  defp packet_out(%PacketIn{datapath_id: datapath_id, data: data}, port_no) do
    send_packet_out(
      datapath_id,
      data: data,
      actions: [Output.new(port_no)]
    )
  end

  defp add_forwarding_flow_entry(_packet_in, nil), do: :noop
  defp add_forwarding_flow_entry(%PacketIn{datapath_id: datapath_id, data: data} = packet_in, port_no) do
    <<dhost::6-bytes, shost::6-bytes, _rest::bytes>> = data
    send_flow_mod_add(
      datapath_id,
      idle_timeout: @aging_time,
      priority: 2,
      match: Match.new(
        in_port: packet_in.in_port,
        eth_dst: Openflow.Utils.to_hex_string(dhost),
        eth_src: Openflow.Utils.to_hex_string(shost)),
      instructions: [ApplyActions.new(Output.new(port_no))]
    )
  end

  defp add_default_broadcast_flow_entry do
    [table_id: @forwarding_table_id,
     priority: 3,
     match: Match.new(eth_dst: @bcast),
     instructions: [ApplyActions.new(Output.new(:flood))]]
  end

  defp add_default_flooding_flow_entry do
    [table_id: @forwarding_table_id,
     priority: 1,
     instructions: [ApplyActions.new(Output.new(:controller))]]
  end

  defp add_multicast_mac_drop_flow_entry do
    [table_id: @ingress_filtering_table_id,
     priority: 2,
     match: Match.new(eth_dst: @mcast)]
  end

  defp add_ipv6_multicast_mac_drop_flow_entry do
    [table_id: @ingress_filtering_table_id,
     priority: 2,
     match: Match.new(eth_dst: @ipv6_mcast)]
  end

  defp add_default_forwarding_flow_entry do
    [table_id: @ingress_filtering_table_id,
     priority: 1,
     instructions: [GotoTable.new(@forwarding_table_id)]]
  end
end
