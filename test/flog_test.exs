defmodule FlogTest do
  use ExUnit.Case, async: false
  use Bitwise

  @listen_port 6653

  @vlan_trunk_port      "veth0" # FIXME:
  @access_port1         "veth3" # FIXME:
  @access_port2         "veth4" # FIXME:

  @vlan_trunk_port_sniffer "veth1" # FIXME:
  @access_port1_sniffer    "veth2" # FIXME:
  @access_port2_sniffer    "veth5" # FIXME:

  @bootnet_vid     0x1000 ||| 5
  @user_vid        0x1000 ||| 123
  @vlan_present    {0x1000, 0x1000}
  @mcast           {"010000000000", "010000000000"}
  @sdl_vmac        "000000000001"
  @bcast           "ffffffffffff"
  @mac             "000102030405"
  @auth_ipv4_address {192,168,5,4}
  @captive_ipv4_address {192,168,5,5}
  @quad_0_ip {0,0,0,0}
  @bcast_ip  {255,255,255,255}
  @client_ip {192,168,5,10}
  @client_farm_ip {192,168,255,1}
  @gateway_ip {192,168,5,4}
  @farm_gw_ip {192,168,255,254}
  @farm_gw_mac "00000000000f"
  @internet {8,8,8,8}
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
    port = Enum.find(ports, fn(port) -> port.name == @access_port1 end)
    port2 = Enum.find(ports, fn(port) -> port.name == @access_port2 end)
    cookie =  0x1000000000000001
    cookie2 = 0x2000000000000001
    timeout = 32_678
    options = [
      vlan_trunk: vlan_trunk,
      port: port,
      port2: port2,
      cookie: cookie,
      cookie2: cookie2,
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
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(ARP)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      payload = <<0::size(16)-unit(8)>>
      packet = [
        ether(dhost: dhost, shost: shost, type: 0x0806),
        arp(op: 1, sha: shost, sip: @client_ip, tip: @gateway_ip)
      ]
      Pf.inject!(pid1, packet, payload)
      refute_receive {@vlan_trunk_port_sniffer, ^packet}, 1000
      Pf.stop(pid1)
      Pf.stop(pid2)
    end
  end

  describe("switch:merged_handler:" <>
    "table=0,priority=200,cookie=0x4000000000000000,in_port=%d,dl_dst=%s,dl_vlan=0x0000/0x1fff,dl_type=%s," <>
    "actions=controller") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        in_port:  state.vlan_trunk.number,
        eth_dst:  @bcast,
        vlan_vid: 0x0000,
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
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000

      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(state.vlan_trunk.hw_addr, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      packet = [
        ether(dhost: dhost, shost: shost, type: 0x88cc),
        lldp(pdus: [chassis_id(value: "hogehoge"),
                    port_id(subtype: :mac_address, value: shost),
                    ttl(value: 128)])
      ]
      Pf.inject!(pid2, packet)
      in_port = state.vlan_trunk.number
      assert_receive %Openflow.PacketIn{in_port: ^in_port}, 1000
      refute_receive {@vlan_trunk_port_sniffer, [^packet, ""]}, 1000
      refute_receive {@access_port1_sniffer, [^packet, ""]}, 1000
      Pf.stop(pid1)
      Pf.stop(pid2)
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
        :timer.sleep 1000
        refute_receive %Openflow.ErrorMsg{}, 1000
      end
    end
  end

  describe("switch:uplink_escalation_flow:" <>
    "table=0,priority=10,cookie=0x1000000000000000,arp,actions=controller") do
    test "Install Flow", state do
      match = Openflow.Match.new(eth_type: 0x0806)
      action = Openflow.Action.Output.new(:controller)
      ins = Openflow.Instruction.ApplyActions.new(action)
      options =
        [cookie: 0x1000000000000000,
         table_id: 0,
         priority: 10,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000

      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      payload = <<0::size(16)-unit(8)>>
      packet = [
        ether(dhost: dhost, shost: shost, type: 0x0806),
        arp(op: 1, sha: shost, sip: @client_ip, tip: @gateway_ip)
      ]
      Pf.inject!(pid1, packet, payload)
      in_port = state.port.number
      assert_receive %Openflow.PacketIn{in_port: ^in_port}, 1000
      refute_receive {@vlan_trunk_port_sniffer, ^packet}, 1000
      Pf.stop(pid1)
      Pf.stop(pid2)
    end
  end

  describe("switch:uplink_escalation_flow:" <>
    "table=0,priority=10,cookie=0x1000000000000000,udp,udp_dst=67,actions=controller") do
    test "Install Flow", state do
      match = Openflow.Match.new(eth_type: 0x0800, ip_proto: 17, udp_dst: 67)
      action = Openflow.Action.Output.new(:controller) 
      ins = Openflow.Instruction.ApplyActions.new(action)
      options =
        [cookie: 0x1000000000000000,
         table_id: 0,
         priority: 10,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000

      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)

      payload = File.read!("test/packet_data/dhcp_discover.raw")
      length = 8 + byte_size(payload)
      udp_header = udp(sport: 68, dport: 67, ulen: length)
      ipv4_header = ipv4(saddr: @quad_0_ip, daddr: @bcast_ip, p: 17, len: 20 + length)
      udp_sum = :pkt.makesum([ipv4_header, udp_header, payload])
      packet = [
        ether(dhost: dhost, shost: shost, type: 0x0800),
        ipv4_header,
        udp(udp_header, sum: udp_sum)
      ]
      Pf.inject!(pid1, packet, <<payload::bytes>>)
      in_port = state.port.number
      assert_receive %Openflow.PacketIn{in_port: ^in_port}, 1000
      refute_receive {@vlan_trunk_port_sniffer, ^packet}, 1000
      Pf.stop(pid1)
      Pf.stop(pid2)
    end
  end

  describe("switch:uplink_escalation_flow:" <>
    "table=0,priority=11,cookie=0x1000000000000000,in_port={trunk_port},actions=drop") do
    test "Install Flow", state do
      match = Openflow.Match.new(in_port: state.vlan_trunk.number)
      options =
        [cookie: 0x1000000000000000,
         table_id: 0,
         priority: 11,
         match: match]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(ARP)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      payload = <<0::size(16)-unit(8)>>
      packet = [
        ether(dhost: dhost, shost: shost, type: 0x0806),
        arp(op: 1, sha: shost, sip: @client_ip, tip: @gateway_ip)
      ]
      Pf.inject!(pid2, packet, payload)
      refute_receive {@access_port1_sniffer, ^packet}, 1000
      Pf.stop(pid1)
      Pf.stop(pid2)
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
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(ARP)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      packet = [ether(dhost: dhost, shost: shost, type: 0x0806),
                arp(op: 1, sha: shost, sip: @client_ip, tip: @gateway_ip)]
      expect = [
        ether(dhost: dhost, shost: shost, type: 0x8100),
        {:"802.1q", 0, 0, 5, 0x0806},
        arp(op: 1, sha: shost, sip: @client_ip, tip: @gateway_ip),
      ]
      Pf.inject!(pid1, packet)
      assert_receive {@vlan_trunk_port_sniffer, ^expect}, 3000
      Pf.stop(pid1)
      Pf.stop(pid2)
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
        Openflow.Action.Output.new(state.port2.number),
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
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(ARP)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)
      {:ok, pid3} = Pf.start_link(@access_port2_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      packet = [
        ether(dhost: dhost, shost: shost, type: 0x8100),
        {:"802.1q", 0, 0, 5, 0x0806},
        arp(op: 1, sha: shost, sip: @client_ip, tip: @gateway_ip),
      ]
      expect = [
        ether(dhost: dhost, shost: shost, type: 0x0806),
        arp(op: 1, sha: shost, sip: @client_ip, tip: @gateway_ip),
      ]
      Pf.inject!(pid2, packet)
      assert_receive {@access_port1_sniffer, ^expect}, 3000
      assert_receive {@access_port2_sniffer, ^expect}, 3000
      Pf.stop(pid1)
      Pf.stop(pid2)
      Pf.stop(pid3)
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
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(ARP)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@sdl_vmac, :eth_src)
      dhost = Openflow.Match.Field.codec(@mac, :eth_dst)
      packet = [
        ether(dhost: dhost, shost: shost, type: 0x8100),
        {:"802.1q", 0, 0, 5, 0x0806},
        arp(op: 2, sha: shost, tip: @client_ip, sip: @gateway_ip),
      ]
      expect = [
        ether(dhost: dhost, shost: shost, type: 0x0806),
        arp(op: 2, sha: shost, tip: @client_ip, sip: @gateway_ip),
      ]
      Pf.inject!(pid2, packet)
      assert_receive {@access_port1_sniffer, ^expect}, 3000
      Pf.stop(pid1)
      Pf.stop(pid2)
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
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(ARP)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      payload = <<0::size(16)-unit(8)>>
      packet = [
        ether(dhost: dhost, shost: shost, type: 0x0806),
        arp(op: 2, sha: shost, sip: @client_ip, tip: @gateway_ip)
      ]
      Pf.inject!(pid2, packet, payload)
      refute_receive {@access_port1_sniffer, ^packet}, 3000
      Pf.stop(pid1)
      Pf.stop(pid2)
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
        :timer.sleep 1000
        refute_receive %Openflow.ErrorMsg{}, 1000
      end
    end

    test "Inject Packet(ARP)" do
      for trusted <- @trusted_macs do
        {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
        {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

        shost = Openflow.Match.Field.codec(trusted, :eth_src)
        dhost = Openflow.Match.Field.codec(@mac, :eth_dst)
        payload = <<0::size(16)-unit(8)>>
        packet = [
          ether(dhost: dhost, shost: shost, type: 0x8100),
          {:"802.1q", 0, 0, 5, 0x0806},
          arp(op: 2, sha: shost, tha: dhost, tip: @client_ip, sip: @gateway_ip)
        ]
        expect = [
          ether(dhost: dhost, shost: shost, type: 0x0806),
          arp(op: 2, sha: shost, tha: dhost, tip: @client_ip, sip: @gateway_ip),
        ]
        Pf.inject!(pid2, packet, payload)
        assert_receive {@access_port1_sniffer, ^expect}, 3000
        Pf.stop(pid1)
        Pf.stop(pid2)
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
        :timer.sleep 1000
        refute_receive %Openflow.ErrorMsg{}, 1000
      end
    end
  end

  describe("associate:register_usernet_rule:" <>
    "in_port={vlan_trunk_port},dl_vlan={vlan}," <>
    "actions=goto_table:1") do
    setup [:flow_del_by_cookie]

    test "Install Flow", state do
      match = Openflow.Match.new(in_port: state.vlan_trunk.number, vlan_vid: @user_vid)
      ins = [Openflow.Instruction.GotoTable.new(1)]
      options =
        [cookie:   state.cookie2,
         table_id: 0,
         priority: 50,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
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
        [cookie:   state.cookie2,
         table_id: 0,
         priority: 20,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "vlan_vid=0x1000/0x1000,tcp,tcp_dst=443,nw_dst={auth_ipv4_address}," <>
    "strip_vlan,set_field:{sdl_vmac}->eth_dst,output:{vlan_trunk_port}") do
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
        Openflow.Action.Output.new(state.vlan_trunk.number),
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [cookie:   state.cookie2,
         table_id: 1,
         priority: 30,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(TCP:443)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@sdl_vmac, :eth_dst)

      payload = ""
      tcp_header = tcp(
        sport: 53_688,
        dport: 443,
        seqno: 1_488_352_223,
        off:   10,
        syn:   1,
        win:   29_200,
        opt:   <<2, 4, 5, 180, 4, 2, 8, 10, 156, 30, 232, 154, 0, 0, 0, 0, 1, 3, 3, 7>>
      )
      ipv4_header = ipv4(saddr: @client_ip, daddr: @auth_ipv4_address, p: 6, len: 60)
      tcp_sum = :pkt.makesum([ipv4_header, tcp_header, payload])
      ether_header = ether(dhost: dhost, shost: shost, type: 0x0800)
      packet = [ether_header, ipv4_header, tcp(tcp_header, sum: tcp_sum)]
      expect = [ether_header, ipv4_header, tcp(tcp_header, sum: tcp_sum)]
      Pf.inject!(pid1, packet, <<payload::bytes>>)
      assert_receive {@vlan_trunk_port_sniffer, ^expect}, 3000
      Pf.stop(pid1)
      Pf.stop(pid2)
    end
  end

  describe("associate:register_usernet_rule:" <>
    "vlan_vid=0x1000/0x1000,tcp,tcp_dst=80,nw_dst={captive_ipv4_address}," <>
    "strip_vlan,set_field:{sdl_vmac}->eth_dst,output:{vlan_trunk_port}") do
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
        Openflow.Action.Output.new(state.vlan_trunk.number),
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [cookie:   state.cookie2,
         table_id: 1,
         priority: 30,
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(TCP:80)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@sdl_vmac, :eth_dst)

      payload = ""
      tcp_header = tcp(
        sport: 53_688,
        dport: 80,
        seqno: 1_488_352_223,
        off:   10,
        syn:   1,
        win:   29_200,
        opt:   <<2, 4, 5, 180, 4, 2, 8, 10, 156, 30, 232, 154, 0, 0, 0, 0, 1, 3, 3, 7>>
      )
      ipv4_header = ipv4(saddr: @client_ip, daddr: @captive_ipv4_address, p: 6, len: 60)
      tcp_sum = :pkt.makesum([ipv4_header, tcp_header, payload])
      ether_header = ether(dhost: dhost, shost: shost, type: 0x0800)
      packet = [ether_header, ipv4_header, tcp(tcp_header, sum: tcp_sum)]
      expect = [ether_header, ipv4_header, tcp(tcp_header, sum: tcp_sum)]
      Pf.inject!(pid1, packet, <<payload::bytes>>)
      assert_receive {@vlan_trunk_port_sniffer, ^expect}, 3000
      Pf.stop(pid1)
      Pf.stop(pid2)
    end
  end

  describe("associate:register_usernet_rule:" <>
    "idle_timeout={itimeout},hard_timeout={htimeout},send_flow_rem,dl_src={mac},in_port={vlan_trunk_port}," <>
    "actions=drop") do
    test "Install Flow", state do
      match = Openflow.Match.new(in_port: state.vlan_trunk.number, eth_src: @mac)
      options =
        [cookie:   state.cookie2,
         table_id: 0,
         priority: 19,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
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
        [cookie:   state.cookie2,
         table_id: 0,
         priority: 18,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("associate:register_usernet_rule:" <>
    "idle_timeout={itimeout},hard_timeout={htimeout},send_flow_rem,vlan_vid=0x1000/0x1000,dl_dst={mac}," <>
    "actions=strip_vlan,output:{port_no}") do
    test "Install Flow", state do
      match = Openflow.Match.new(vlan_vid: @vlan_present, eth_dst: @mac)
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(state.port.number)]
      ins = [Openflow.Instruction.ApplyActions.new(actions)]
      options =
        [cookie:   state.cookie2,
         table_id: 1,
         priority: 50,
         flags: [:send_flow_rem],
         idle_timeout: state.timeout,
         hard_timeout: state.timeout,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(ARP)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@sdl_vmac, :eth_src)
      dhost = Openflow.Match.Field.codec(@mac, :eth_dst)
      vlan_ether_header = ether(dhost: dhost, shost: shost, type: 0x8100)
      ether_header = ether(dhost: dhost, shost: shost, type: 0x0806)
      vlan_header = {:"802.1q", 0, 1, 123, 0x0806}
      arp_header = arp(op: 2, sha: shost, tha: dhost, tip: @client_ip, sip: @gateway_ip)
      packet = [vlan_ether_header, vlan_header, arp_header]
      expect = [ether_header, arp_header]
      Pf.inject!(pid2, packet)
      assert_receive {@access_port1_sniffer, ^expect}, 1000
      Pf.stop(pid1)
      Pf.stop(pid2)
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
        Openflow.Action.Output.new(state.port.number),
        Openflow.Action.Output.new(state.port2.number)
      ]
      ins = [Openflow.Instruction.ApplyActions.new(actions)]
      options =
        [cookie:   state.cookie2,
         table_id: 1,
         priority: 60,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(ARP) from VLAN TRUNK" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)
      {:ok, pid3} = Pf.start_link(@access_port2_sniffer)

      shost = Openflow.Match.Field.codec(@sdl_vmac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      vlan_ether_header = ether(dhost: dhost, shost: shost, type: 0x8100)
      ether_header = ether(dhost: dhost, shost: shost, type: 0x0806)
      vlan_header = {:"802.1q", 0, 1, 123, 0x0806}
      arp_header = arp(op: 1, sha: shost, tip: @client_ip, sip: @gateway_ip)
      packet = [vlan_ether_header, vlan_header, arp_header]
      Pf.inject!(pid2, packet)
      expect = [ether_header, arp_header]
      assert_receive {@access_port1_sniffer, ^expect}, 3000
      assert_receive {@access_port2_sniffer, ^expect}, 3000
      Pf.stop(pid1)
      Pf.stop(pid2)
      Pf.stop(pid3)
    end

    test "Inject Packet(ARP) from ACCESS" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)
      {:ok, pid3} = Pf.start_link(@access_port2_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@bcast, :eth_dst)
      vlan_ether_header = ether(dhost: dhost, shost: shost, type: 0x8100)
      ether_header = ether(dhost: dhost, shost: shost, type: 0x0806)
      vlan_header = {:"802.1q", 0, 0, 123, 0x0806}
      arp_header = arp(op: 1, sha: shost, tip: @client_ip, sip: @gateway_ip)
      packet = [ether_header, arp_header]
      Pf.inject!(pid1, packet)
      expects = [
        {@vlan_trunk_port_sniffer, [vlan_ether_header, vlan_header, arp_header]},
        {@access_port2_sniffer, [ether_header, arp_header]}
      ]
      :ok = assert_receives(expects)
      Pf.stop(pid1)
      Pf.stop(pid2)
      Pf.stop(pid3)
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
        [cookie:   state.cookie2,
         table_id: 1,
         priority: 20,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("switch:register_farm_nat_rule:" <>
    "dl_src={src_mac},arp,arp_spa={src_ip},arp_tpa={dst_ip}," <>
    "actions=set_field:{farm_vmac}->eth_dst,set_field:{src_fip}->arp_spa," <>
    "set_field:{dst_fip}->arp_tpa,output:{vlan_trunk_port}") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        eth_src: @mac,
        eth_type: 0x0806,
        arp_spa:  @client_ip,
        arp_tpa:  @gateway_ip
      )
      actions = [
        Openflow.Action.SetField.new({:eth_dst, @farm_gw_mac}),
        Openflow.Action.SetField.new({:arp_spa, @client_farm_ip}),
        Openflow.Action.SetField.new({:arp_tpa, @farm_gw_ip}),
        # Following is not work properly in "SwitchNode" configuration.
        # Openflow.Action.PushVlan.new,
        # Openflow.Action.SetField.new({:vlan_vid, @user_vid}),
        Openflow.Action.Output.new(state.vlan_trunk.number),
      ]
      ins = [Openflow.Instruction.ApplyActions.new(actions)]
      options =
        [cookie:   0x3000000000000001,
         table_id: 1,
         priority: 30,
         idle_timeout: 60,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end
  end

  describe("switch:register_farm_nat_rule:" <>
    "dl_src={src_mac},ip,nw_src={src_ip},nw_dst={dst_ip}," <>
    "actions=push_vlan:0x8100,set_field:{vlan}->vlan_vid,set_field:{farm_vmac}->eth_dst," <>
    "set_field:{src_fip}->nw_src,output:{vlan_trunk_port}") do
    test "Install Flow", state do
      match = Openflow.Match.new(
        eth_src: @mac,
        eth_type: 0x0800,
        ipv4_src: @client_ip,
        ipv4_dst: @internet
      )
      actions = [
        Openflow.Action.SetField.new({:eth_dst, @farm_gw_mac}),
        # Following is not work properly in "SwitchNode" configuration.
        # Openflow.Action.PushVlan.new,
        # Openflow.Action.SetField.new({:vlan_vid, @user_vid}),
        Openflow.Action.SetField.new({:ipv4_src, @client_farm_ip}),
        Openflow.Action.Output.new(state.vlan_trunk.number),
      ]
      ins = [Openflow.Instruction.ApplyActions.new(actions)]
      options =
        [cookie:   0x3000000000000001,
         table_id: 1,
         priority: 30,
         idle_timeout: 60,
         match: match,
         instructions: ins]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      :timer.sleep 1000
      refute_receive %Openflow.ErrorMsg{}, 1000
    end

    test "Inject Packet(TCP:80)" do
      {:ok, pid1} = Pf.start_link(@access_port1_sniffer)
      {:ok, pid2} = Pf.start_link(@vlan_trunk_port_sniffer)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@sdl_vmac, :eth_dst)

      payload = ""
      tcp_header = tcp(
        sport: 53_688,
        dport: 80,
        seqno: 1_488_352_223,
        off:   10,
        syn:   1,
        win:   29_200,
        opt:   <<2, 4, 5, 180, 4, 2, 8, 10, 156, 30, 232, 154, 0, 0, 0, 0, 1, 3, 3, 7>>
      )
      ipv4_header = ipv4(saddr: @client_ip, daddr: @internet, p: 6, len: 60)
      tcp_sum = :pkt.makesum([ipv4_header, tcp_header, payload])
      ether_header = ether(dhost: dhost, shost: shost, type: 0x0800)
      packet = [ether_header, ipv4_header, tcp(tcp_header, sum: tcp_sum)]
      Pf.inject!(pid1, packet, <<payload::bytes>>)

      shost = Openflow.Match.Field.codec(@mac, :eth_src)
      dhost = Openflow.Match.Field.codec(@farm_gw_mac, :eth_dst)
      ether_header = ether(dhost: dhost, shost: shost, type: 0x8100)
      vlan_header = {:"802.1q", 0, 0, 123, 0x0800}
      ipv4_header = ipv4(saddr: @client_farm_ip, daddr: @internet, p: 6, len: 60)
      tcp_sum = :pkt.makesum([ipv4_header, tcp_header, payload])
      expect = [ether_header, vlan_header, ipv4(ipv4_header, sum: 1544), tcp(tcp_header, sum: tcp_sum)]
      assert_receives([{@vlan_trunk_port_sniffer, expect}], 5000)
      Pf.stop(pid1)
      Pf.stop(pid2)
    end
  end

  # private functions

  defp assert_receives(expects, timeout \\ 1000) do
    assert_receives(expects, length(expects), timeout)
  end

  defp assert_receives(_expects, 0, _timeout), do: :ok
  defp assert_receives(expects, count, timeout) do
    receive do
      message ->
        assert(message in expects)
        assert_receives(expects, count - 1, timeout)
    after timeout ->
        flunk("Timeout")
    end
  end

  defp setup_applications do
    Application.put_env(:tres, :protocol, :tcp, persistent: true)
    Application.put_env(:tres, :port, @listen_port, persistent: true)
    Application.put_env(:tres, :mac_connections, 1, persistent: true)
    Application.put_env(:tres, :mac_acceptors, 1, persistent: true)
    Application.put_env(:tres, :callback_module, Flay, persistent: true)
    Application.put_env(:tres, :callback_args, self(), persistent: true)
    Application.start(:binpp)
    Application.start(:pkt)
    Application.start(:epcap)
    Application.start(:ranch)
    Application.start(:eovsdb)
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

  defp flow_del_by_cookie(context) do
    :ok = GenServer.cast(Flay, {:flow_del, context.cookie})
    :timer.sleep 3000
  end

  defp get_ports_desc do
    port_desc = GenServer.call(Flay, :port_desc_stats, 5000)
    port_desc.ports
  end
end
