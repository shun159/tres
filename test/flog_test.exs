defmodule FlogTest do
  use ExUnit.Case, async: false
  use Bitwise

  @vlan_trunk_port      "veth0" # FIXME:
  @access_port          "veth3" # FIXME:
  @vxlan_port           "veth4" # FIXME:
  @bootnet_vid     0x1000 ||| 5
  @user_vid        0x1000 ||| 123
  @vlan_present    {0x1000, 0x1000}
  @mcast           {"010000000000", "010000000000"}
  @sdl_vmac        "000000000001"
  @bcast           "ffffffffffff"
  @mac             "010203040506"
  @auth_ipv4_address {192,168,5,4}
  @captive_ipv4_address {192,168,5,5}
  @trusted_macs    [
    "0800274d3297",
    "0800274d3298",
    "0800274d3299"
  ]

  import Record
  # Extract Erlang record for msantos/pkt
  for {name, schema} <- extract_all(from_lib: "pkt/include/pkt.hrl") do
    defrecord(name, schema)
  end

  Code.load_file("test/flay.ex")
  Code.load_file("test/pf.ex")

  # GIVEN
  setup_all do
    setup_applications()
    wait_for_connected()
    ports = get_ports_desc()
    vlan_trunk = Enum.find(ports, fn(port) -> port.name == @vlan_trunk_port end)
    vxlan_port = Enum.find(ports, fn(port) -> port.name == @vxlan_port end)
    port = Enum.find(ports, fn(port) -> port.name == @access_port end)
    cookie = 0x1000000000000001
    timeout = 32678
    options = [
      vlan_trunk: vlan_trunk,
      vxlan_port: vxlan_port,
      port: port,
      cookie: cookie,
      timeout: timeout
    ]
    {:ok, options}
  end

  describe("switch:merged_handler:table=0,priority=0,cookie=0x8000000000000000,actions=drop") do
    test "Install Flow" do
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

  describe("associate:register_bootstrap_rule:" <>
    "send_flow_rem," <>
    "dl_src={mac},in_port={port_no}," <>
    "actions=push_vlan:0x8100,set_field:{vlan}->vlan_vid,output:{vlan_trunk_port}") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        in_port: state.port.number,
        eth_src: @mac
      )
      actions = [
        Openflow.Action.PushVlan.new,
        Openflow.Action.SetField.new({:vlan_vid, @bootnet_vid}),
        Openflow.Action.Output.new(state.vlan_trunk.number),
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [cookie:   state.cookie,
         table_id: 0,
         priority: 20,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_bootstrap_rule:" <>
    "send_flow_rem," <>
    "in_port={vlan_trunk_port},dl_vlan={vlan},dl_dst={mcast}," <>
    "actions=strip_vlan,{outputs}") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        in_port: state.vlan_trunk.number,
        vlan_vid: @bootnet_vid,
        eth_dst: @mcast
      )
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(state.port.number),
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [cookie:   state.cookie,
         table_id: 0,
         priority: 50,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_bootstrap_rule:" <>
    "send_flow_rem," <>
    "in_port={vlan_trunk_port},dl_vlan={vlan},dl_dst={mac}," <>
    "actions=strip_vlan,output:{port_no}") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        in_port: state.vlan_trunk.number,
        vlan_vid: @bootnet_vid,
        eth_dst: @mac
      )
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(state.port.number),
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [cookie:   state.cookie,
         table_id: 0,
         priority: 50,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_bootstrap_rule:" <>
    "send_flow_rem," <>
    "dl_src={mac},in_port={vlan_trunk_port}," <>
    "actions=drop") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        in_port: state.vlan_trunk.number,
        eth_src: @mac
      )
      options =
        [cookie:   state.cookie,
         table_id: 0,
         priority: 19,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_bootstrap_rule:" <>
    "send_flow_rem," <>
    "in_port={vlan_trunk_port},dl_vlan={vlan},dl_src={trusted},dl_dst={mac}," <>
    "actions=strip_vlan,output:{port_no}") do
    test "Install Flow", state do
      for trusted <- @trusted_macs do
        match = Openflow.Match.new(
          in_port: state.vlan_trunk.number,
          vlan_vid: @bootnet_vid,
          eth_src: trusted,
          eth_dst: @mac
        )
        actions = [
          Openflow.Action.PopVlan.new,
          Openflow.Action.Output.new(state.port.number),
        ]
        ins = Openflow.Instruction.ApplyActions.new(actions)
        options =
          [cookie:   state.cookie,
           table_id: 0,
           priority: 50,
           flags: [:send_flow_rem],
           idle_timeout: state.timeout,
           hard_timeout: state.timeout,
           match: match,
           instructions: [ins]]
        :ok = GenServer.cast(Flay, {:flow_install, options, self()})
        refute_received %Openflow.ErrorMsg{}, 1000
      end
    end
  end

  describe("associate:register_bootstrap_rule:" <>
    "send_flow_rem," <>
    "dl_src={trusted}," <>
    "actions=drop") do
    test "Install Flow", state do
      for trusted <- @trusted_macs do
        match = Openflow.Match.new(eth_src: trusted)
        options =
          [cookie:   state.cookie,
           table_id: 0,
           priority: 29,
           flags: [:send_flow_rem],
           idle_timeout: state.timeout,
           hard_timeout: state.timeout,
           match: match]
        :ok = GenServer.cast(Flay, {:flow_install, options, self()})
        refute_received %Openflow.ErrorMsg{}, 1000
      end
    end
  end

  describe("associate:register_usernet_rule:" <>
    "table=0, priority=40,cookie={cookie},hard_timeout={htimeout},in_port={vxlan_port},dl_dst={mac}," <>
    "actions=output:{port_no}") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        in_port: state.vxlan_port.number,
        eth_dst: @mac
      )
      actions = [
        Openflow.Action.Output.new(state.port.number),
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [cookie:   state.cookie,
         table_id: 0,
         priority: 40,
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "vlan_vid=0x1000/0x1000,tcp,tcp_dst=443,nw_dst={auth_ipv4_address}," <>
    "strip_vlan,set_field:{sdl_vmac}->eth_dst,output:{vxlan_port}") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        vlan_vid: @vlan_present,
        eth_type: 0x0800,
        ip_proto: 6,
        ipv4_dst: @auth_ipv4_address,
        tcp_dst: 443
      )
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.SetField.new({:eth_dst, @sdl_vmac}),
        Openflow.Action.Output.new(state.port.number),
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [cookie:   0x2000000000000001,
         table_id: 1,
         priority: 30,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "vlan_vid=0x1000/0x1000,tcp,tcp_dst=80,nw_dst={captive_ipv4_address}," <>
    "strip_vlan,set_field:{sdl_vmac}->eth_dst,output:{vxlan_port}") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        vlan_vid: @vlan_present,
        eth_type: 0x0800,
        ip_proto: 6,
        ipv4_dst: @captive_ipv4_address,
        tcp_dst: 80
      )
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.SetField.new({:eth_dst, @sdl_vmac}),
        Openflow.Action.Output.new(state.port.number),
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [cookie:   0x2000000000000001,
         table_id: 1,
         priority: 30,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "idle_timeout={itimeout},hard_timeout={htimeout},send_flow_rem,  dl_src={mac},in_port={port_no}," <>
    "actions=push_vlan:0x8100,set_field:{vlan}->vlan_vid,goto_table:1") do
    test "Install Flow", state do
      match = Openflow.Match.new(in_port: state.port.number, eth_src: @mac)
      actions = [
        Openflow.Action.PushVlan.new,
        Openflow.Action.SetField.new({:vlan_vid, @user_vid})
      ]
      ins = [
        Openflow.Instruction.ApplyActions.new(actions),
        Openflow.Instruction.GotoTable.new(1)
      ]
      options =
        [cookie:   state.cookie,
         table_id: 0,
         priority: 20,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "idle_timeout={itimeout},hard_timeout={htimeout},send_flow_rem,dl_src={mac},in_port={vlan_trunk_port}," <>
    "actions=drop") do
    test "Install Flow", state do
      match = Openflow.Match.new(in_port: state.vlan_trunk.number, eth_src: @mac)
      options =
        [cookie:   state.cookie,
         table_id: 0,
         priority: 19,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "idle_timeout={itimeout},hard_timeout={htimeout},send_flow_rem,dl_src={mac}," <>
    "actions=controller") do
    test "Install Flow", state do
      match = Openflow.Match.new(eth_src: @mac)
      actions = [Openflow.Action.Output.new(:controller)]
      ins = [Openflow.Instruction.ApplyActions.new(actions)]
      options =
        [cookie:   state.cookie,
         table_id: 0,
         priority: 18,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "idle_timeout={itimeout},hard_timeout={htimeout},send_flow_rem,vlan_vid=0x1000/0x1000,dl_dst={mac}," <>
    "actions=strip_vlan,output:{port_no}") do
    test "Install Flow", state do
      match = Openflow.Match.new(vlan_vid: @vlan_present, eth_src: @mac)
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(state.port.number)]
      ins = [Openflow.Instruction.ApplyActions.new(actions)]
      options =
        [cookie:   state.cookie,
         table_id: 1,
         priority: 50,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "dl_vlan={vlan},dl_dst={mcast}," <>
    "actions=output:{vlan_trunk_port},strip_vlan,{outputs}") do
    test "Install Flow", state do
      match = Openflow.Match.new(vlan_vid: @user_vid, eth_dst: @mcast)
      actions = [
        Openflow.Action.Output.new(state.vlan_trunk.number),
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(state.port.number)]
      ins = [Openflow.Instruction.ApplyActions.new(actions)]
      options =
        [cookie:   0x2000000000000001,
         table_id: 1,
         priority: 60,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "dl_vlan={vlan}," <>
    "actions=output:{vlan_trunk_port},strip_vlan,{outputs}") do
    test "Install Flow", state do
      match = Openflow.Match.new(vlan_vid: @user_vid)
      actions = [
        Openflow.Action.Output.new(state.vlan_trunk.number),
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(state.port.number)]
      ins = [Openflow.Instruction.ApplyActions.new(actions)]
      options =
        [cookie:   0x2000000000000001,
         table_id: 1,
         priority: 20,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      refute_received %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "in_port={vlan_trunk_port},dl_vlan={vlan}," <>
    "actions=goto_table:1") do
    test "Install Flow", state do
      match = Openflow.Match.new(in_port: state.vlan_trunk.number, vlan_vid: @user_vid)
      ins = [Openflow.Instruction.GotoTable.new(1)]
      options =
        [cookie:   0x2000000000000001,
         table_id: 0,
         priority: 50,
         match: match,
         instructions: ins]
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
