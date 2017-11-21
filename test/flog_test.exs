defmodule FlogTest do
  use ExUnit.Case, async: true
  use Bitwise

  @vlan_trunk_port      "veth0" # FIXME:
  @access_port          "veth3" # FIXME:
  @vxlan_port           "veth4" # FIXME:
  #@bootnet_vid     0x1000 ||| 5
  #@user_vid        0x1000 ||| 123
  @mcast           {"010000000000", "010000000000"}
  #@bcast           "ffffffffffff"
  #@mac             "010203040506"
  #@sdl_vmac        "000000000001"
  #@trusted_macs    [
  #  "0800274d3297",
  #  "0800274d3298",
  #  "0800274d3299"
  #]

  import Record
  # Extract Erlang record for msantos/pkt
  for {name, schema} <- extract_all(from_lib: "pkt/include/pkt.hrl") do
    defrecord(name, schema)
  end

  Code.load_file("test/flay.ex")
  Code.load_file("test/pf.ex")

  setup_all do
    setup_applications()
    wait_for_connected()
    ports = get_ports_desc()
    vlan_trunk = Enum.find(ports, fn(port) -> port.name == @vlan_trunk_port end)
    vxlan_port = Enum.find(ports, fn(port) -> port.name == @vxlan_port end)
    port = Enum.find(ports, fn(port) -> port.name == @access_port end)
    options = [
      vlan_trunk: vlan_trunk,
      vxlan_port: vxlan_port,
      port: port
    ]
    {:ok, options}
  end

  describe("switch:merged_handler:table=0,priority=0,cookie=0x8000000000000000,actions=drop") do
    test "Install Flow", state do
      options = [
        cookie: 0x8000000000000000,
        table_id: 0,
        priority: 0
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("switch:merged_handler:" <>
    "table=0,priority=200,cookie=0x4000000000000000,in_port=%d,dl_dst=%s,dl_vlan=0x0000/0x1fff,dl_type=%s," <>
    "actions=controller") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        in_port:  state.vlan_trunk.number,
        eth_dst:  @bcast,
        vlan_vid: {0x0000, 0x1fff},
        eth_type: 0x88cc
      )
      action = Openflow.Action.Output.new(:controller)
      ins = Openflow.Instruction.ApplyActions.new(action)
      options =
        [cookie: 0x4000000000000000,
         table_id: 0,
         priority: 200,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("switch:merged_handler:" <>
    "table=0,priority=201,cookie=0x4000000000000000,in_port=%d,dl_src=%s,actions=drop") do
    test "Install Flow", state do
      for port <- [state.vlan_trunk, state.port] do
        match = Openflow.Match.new(in_port: port.number, eth_src: port.hw_addr)
        options =
          [cookie: 0x4000000000000000,
           table_id: 0,
           priority: 201,
           match: match]
        :ok = GenServer.cast(Flay, {:flow_install, options, self()})
        refute_received %Openflow.ErrorMsg{}, 1000
      end
    end
  end

  describe("switch:uplink_escalation_flow:" <>
    "table=0,priority=10,cookie=0x2000000000000000,arp,actions=controller") do
    test "Install Flow" do
      match = Openflow.Match.new(eth_type: 0x0806)
      action = Openflow.Action.Output.new(:controller)
      ins = Openflow.Instruction.ApplyActions.new(action)
      options =
        [cookie: 0x2000000000000000,
         table_id: 0,
         priority: 10,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("switch:uplink_escalation_flow:" <>
    "table=0,priority=10,cookie=0x2000000000000000,udp,udp_dst=67,actions=controller") do
    test "Install Flow" do
      match = Openflow.Match.new(eth_type: 0x0800, ip_proto: 17, udp_dst: 67)
      action = Openflow.Action.Output.new(:controller)
      ins = Openflow.Instruction.ApplyActions.new(action)
      options =
        [cookie: 0x2000000000000000,
         table_id: 0,
         priority: 10,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("switch:uplink_escalation_flow:" <>
    "table=0,priority=11,cookie=0x2000000000000000,in_port={trunk_port},actions=drop") do
    test "Install Flow", state do
      match = Openflow.Match.new(in_port: state.vlan_trunk.number)
      options =
        [cookie: 0x2000000000000000,
         table_id: 0,
         priority: 11,
         match: match]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  # private functions

  defp setup_applications do
    Application.put_env(:tres, :protocol, :tcp, persistent: true)
    Application.put_env(:tres, :port, 6633, persistent: true)
    Application.put_env(:tres, :mac_connections, 1, persistent: true)
    Application.put_env(:tres, :mac_acceptors, 1, persistent: true)
    Application.put_env(:tres, :callback_module, Flay, persistent: true)
    Application.put_env(:tres, :callback_args, self(), persistent: true)
    Application.start(:binpp)
    Application.start(:pkt)
    Application.start(:epcap)
    Application.start(:ranch)
    Application.start(:tres)
  end

  defp wait_for_connected do
    case Process.whereis(Flay) do
      nil ->
        wait_for_connected()
      pid when is_pid(pid) ->
        :ok
    end
  end

  defp get_ports_desc do
    port_desc = GenServer.call(Flay, :port_desc_stats, 5000)
    port_desc.ports
  end
end
