defmodule FlayTest do
  use ExUnit.Case
  use Bitwise

  @vlan_trunk_port 1
  @access_port     2
  @vxlan_port      3
  @bootnet_vid     0x1000 ||| 5
  @user_vid        0x1000 ||| 123
  @mcast           {"010000000000", "010000000000"}
  @mac             "010203040506"
  @sdl_vmac        "000000000001"
  @trusted_macs    [
    "0800274d3297",
    "0800274d3298",
    "0800274d3299"
  ]

  import Record
  # Extract Erlang record for klarna/brod
  for {name, schema} <- extract_all(from_lib: "pkt/include/pkt.hrl") do
    defrecord(name, schema)
  end

  setup do
    Code.load_file("test/flay.ex")
    Code.load_file("test/pf.ex")
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
    wait_for_connected()
  end

  describe "switch:merged_handler" do
    test "OFPMP_DESC" do
      %Openflow.Multipart.Desc.Reply{} = GenServer.call(Flay, :desc_stats, 5000)
    end

    test "Flow install" do
      options = [cookie: 0x8000000000000000]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(
        in_port: @vlan_trunk_port,
        eth_dst: "ffffffffffff",
        vlan_vid: {0x0000, 0x1fff},
        eth_type: 0x88cc
      )
      ins = Openflow.Instruction.ApplyActions.new(Openflow.Action.Output.new(:controller))
      options = [
        cookie: 0x4000000000000000,
        table_id: 0,
        priority: 200,
        match: match,
        instructions: [ins]
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      # LLDP Packet to vlan trunk port mac_address
      src = "00000000000a"
      src_mac = <<(String.to_integer(src, 16))::48>>
      dst = "ffffffffffff"
      dst_mac = <<(String.to_integer(dst, 16))::48>>
      lldp = lldp(pdus: [
            {:chassis_id, :mac_address, src_mac},
            {:port_id, :mac_address, src_mac},
            {:ttl, 120}
          ])
      ether = ether(shost: src_mac, dhost: dst_mac, type: 0x88cc)
      _packet = <<(:pkt.ether(ether))::bytes, (:pkt.lldp(lldp))::bytes>>

      %Openflow.Multipart.PortDesc.Reply{ports: ports} = GenServer.call(Flay, :port_desc_stats, 5000)
      for port <- ports do
        match = Openflow.Match.new(in_port: port.number, eth_src: port.hw_addr)
        options = [
          cookie: 0x4000000000000000,
          table_id: 0,
          priority: 201,
          match: match,
          instructions: []
        ]
        :ok = GenServer.cast(Flay, {:flow_install, options, self()})

        # ARP Packet to vlan_trunk port mac address
        arp = arp(arp_sha: src_mac, arp_sha: dst_mac)
        ether = ether(shost: src_mac, dhost: dst_mac, type: 0x0806)
        _packet = <<(:pkt.ether(ether))::bytes, (:pkt.arp(arp))::bytes>>
      end
      refute_receive %Openflow.ErrorMsg{}, 1000
    end
  end

  describe "switch:uplink_escalation_flow" do
    test "Flow install" do
      match = Openflow.Match.new(eth_type: 0x0806)
      action = Openflow.Action.Output.new(:controller)
      ins = Openflow.Instruction.ApplyActions.new(action)
      options = [
        cookie: 0x2000000000000000,
        table_id: 0,
        priority: 10,
        match: match,
        instructions: ins
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(eth_type: 0x0800, ip_proto: 17, udp_dst: 67)
      action = Openflow.Action.Output.new(:controller)
      ins = Openflow.Instruction.ApplyActions.new(action)
      options = [
        cookie: 0x2000000000000000,
        table_id: 0,
        priority: 10,
        match: match,
        instructions: ins
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(in_port: @vlan_trunk_port)
      options = [
        cookie: 0x2000000000000000,
        table_id: 0,
        priority: 11,
        match: match,
        instructions: []
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      refute_receive %Openflow.ErrorMsg{}, 1000
    end
  end

  describe "associate:register_bootstrap_rule" do
    test "Flow install" do
      cookie = :crypto.strong_rand_bytes(8) |> :binary.decode_unsigned(:big)
      match = Openflow.Match.new(in_port: @access_port, eth_src: @mac)
      actions = [
        Openflow.Action.PushVlan.new,
        Openflow.Action.SetField.new({:vlan_vid, @bootnet_vid}),
        Openflow.Action.Output.new(@vlan_trunk_port)
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [table_id: 0,
         priority: 50,
         cookie: cookie,
         idle_timeout: 300,
         hard_timeout: 300,
         flags: [:send_flow_rem],
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      # trusted mac
      match = Openflow.Match.new(in_port: @vlan_trunk_port, vlan_vid: @bootnet_vid, eth_dst: @mcast)
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(@access_port)
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [table_id: 0,
         priority: 50,
         cookie: cookie,
         idle_timeout: 300,
         hard_timeout: 300,
         flags: [:send_flow_rem],
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(in_port: @vlan_trunk_port, vlan_vid: @bootnet_vid, eth_dst: @mac)
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(@access_port)
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options =
        [table_id: 0,
         priority: 50,
         cookie: cookie,
         idle_timeout: 300,
         hard_timeout: 300,
         flags: [:send_flow_rem],
         match: match,
         instructions: [ins]]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(in_port: @vlan_trunk_port, eth_src: @mac)
      options =
        [table_id: 0,
         priority: 29,
         cookie: cookie,
         idle_timeout: 300,
         hard_timeout: 300,
         flags: [:send_flow_rem],
         match: match]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      # Trunk Port, w/Trusted MAC -> Pop VLAN -> Access Port
      for trusted <- @trusted_macs do
        match = Openflow.Match.new(
          in_port: @vlan_trunk_port,
          eth_src: trusted,
          eth_dst: @mac,
          vlan_vid: @bootnet_vid
        )
        actions = [
          Openflow.Action.PopVlan.new,
          Openflow.Action.Output.new(@access_port)
        ]
        ins = Openflow.Instruction.ApplyActions.new(actions)
        options =
          [table_id: 0,
           priority: 50,
           cookie: cookie,
           idle_timeout: 300,
           hard_timeout: 300,
           flags: [:send_flow_rem],
           match: match,
           instructions: ins]
        :ok = GenServer.cast(Flay, {:flow_install, options, self()})

        match = Openflow.Match.new(eth_src: trusted)
        options =
          [table_id: 0,
           priority: 29,
           cookie: cookie,
           idle_timeout: 300,
           hard_timeout: 300,
           flags: [:send_flow_rem],
           match: match]
        :ok = GenServer.cast(Flay, {:flow_install, options, self()})
      end
      refute_receive %Openflow.ErrorMsg{}, 1000
    end
  end

  describe "associate:register_usernet_rule" do
    test "Flow install" do
      # BOOTNET_USE_USER_NETWORK
      #
      # Reply from SDL to the authorized client
      cookie = :crypto.strong_rand_bytes(8) |> :binary.decode_unsigned(:big)
      match = Openflow.Match.new(in_port: @vxlan_port, eth_dst: @mac)
      action = Openflow.Action.Output.new(@access_port)
      ins = Openflow.Instruction.ApplyActions.new(action)
      options = [
        cookie: cookie,
        table_id: 0,
        priority: 40,
        idle_timeout: 32_768,
        hard_timeout: 32_768,
        match: match,
        instructions: [ins]
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      # HTTP request to the `CaptivePortal` via the SDL controller
      match = Openflow.Match.new(
        eth_type: 0x0800,
        vlan_vid: {0x1000, 0x1000},
        ip_proto: 6,
        tcp_dst: 443,
        ipv4_dst: {192,168,5,4}
      )
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.SetField.new({:eth_dst, @sdl_vmac}),
        Openflow.Action.Output.new(@vxlan_port)
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options = [
        cookie: 0x2000000000000001,
        table_id: 1,
        priority: 30,
        match: match,
        instructions: [ins]
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(
        eth_type: 0x0800,
        vlan_vid: {0x1000, 0x1000},
        ip_proto: 6,
        tcp_dst: 80,
        ipv4_dst: {192,168,5,5}
      )
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.SetField.new({:eth_dst, @sdl_vmac}),
        Openflow.Action.Output.new(@vxlan_port)
      ]
      ins = Openflow.Instruction.ApplyActions.new(actions)
      options = [
        cookie: 0x2000000000000001,
        table_id: 1,
        priority: 30,
        match: match,
        instructions: [ins]
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      # Access Port, w/sMAC -> Push VLAN -> Table1
      # Table1, w/dMAC, w/VLAN -> Pop VLAN -> Access Port
      match = Openflow.Match.new(in_port: @access_port, eth_src: @mac)
      actions = [
        Openflow.Action.PushVlan.new,
        Openflow.Action.SetField.new({:vlan_vid, @bootnet_vid})
      ]
      insts = [
        Openflow.Instruction.ApplyActions.new(actions),
        Openflow.Instruction.GotoTable.new(1)
      ]
      options = [
        cookie: cookie,
        table_id: 0,
        priority: 20,
        idle_timeout: 32_768,
        hard_timeout: 32_768,
        flags: [:send_flow_rem],
        match: match,
        instructions: insts
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(in_port: @vlan_trunk_port, eth_src: @mac)
      options = [
        cookie: cookie,
        table_id: 0,
        priority: 19,
        idle_timeout: 32_768,
        hard_timeout: 32_768,
        flags: [:send_flow_rem],
        match: match,
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(eth_src: @mac)
      actions = [Openflow.Action.Output.new(:controller)]
      insts = [Openflow.Instruction.ApplyActions.new(actions)]
      options = [
        cookie: cookie,
        table_id: 0,
        priority: 18,
        idle_timeout: 32_768,
        hard_timeout: 32_768,
        flags: [:send_flow_rem],
        match: match,
        instructions: insts
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(vlan_vid: {0x1000, 0x1000}, eth_dst: @mac)
      actions = [
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(@access_port)
      ]
      insts = [Openflow.Instruction.ApplyActions.new(actions)]
      options = [
        cookie: cookie,
        table_id: 1,
        priority: 50,
        idle_timeout: 32_768,
        hard_timeout: 32_768,
        flags: [:send_flow_rem],
        match: match,
        instructions: insts
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

	    # VLAN 毎に登録する共通ルール
	    # Table1, w/VLAN -+-> Trunk
	    #		  +-> Pop VLAN -> Access Ports
	    # Trunk Port, w/VLAN -> Table1
      match = Openflow.Match.new(vlan_vid: @user_vid, eth_dst: @mcast)
      actions = [
        Openflow.Action.Output.new(@vlan_trunk_port),
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(@access_port)
      ]
      insts = [Openflow.Instruction.ApplyActions.new(actions)]
      options = [
        cookie: 0x200000000000001,
        table_id: 1,
        priority: 60,
        match: match,
        instructions: insts
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(vlan_vid: @user_vid)
      actions = [
        Openflow.Action.Output.new(@vlan_trunk_port),
        Openflow.Action.PopVlan.new,
        Openflow.Action.Output.new(@access_port)
      ]
      insts = [Openflow.Instruction.ApplyActions.new(actions)]
      options = [
        cookie: 0x200000000000001,
        table_id: 1,
        priority: 20,
        match: match,
        instructions: insts
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      match = Openflow.Match.new(in_port: @vlan_trunk_port, vlan_vid: @user_vid)
      insts = [Openflow.Instruction.GotoTable.new(1)]
      options = [
        cookie: 0x200000000000001,
        table_id: 0,
        priority: 50,
        match: match,
        instructions: insts
      ]
      :ok = GenServer.cast(Flay, {:flow_install, options, self()})

      refute_receive %Openflow.ErrorMsg{}, 1000
    end
  end

  defp wait_for_connected do
    case Process.whereis(Flay) do
      nil ->
        wait_for_connected()
      pid when is_pid(pid) ->
        :ok
    end
  end
end
