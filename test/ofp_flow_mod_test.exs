defmodule OfpFlowModTest do
  use ExUnit.Case
  doctest Openflow

  @flow_mod1 "test/packet_data/4-2-ofp_flow_mod.packet"
  @flow_mod2 "test/packet_data/4-3-ofp_flow_mod.packet"
  @flow_mod3 "test/packet_data/4-46-ofp_flow_mod.packet"
  @flow_mod4 "test/packet_data/4-60-ofp_flow_mod.packet"
  @flow_mod5 "test/packet_data/libofproto-OFP13-flow_mod.packet"
  @flow_mod6 "test/packet_data/libofproto-OFP13-flow_mod.truncated64"
  @flow_mod7 "test/packet_data/libofproto-OFP13-flow_mod_conjunction.packet"
  @flow_mod8 "test/packet_data/libofproto-OFP13-flow_mod_match_conj.packet"

  describe "Openflow.read/1" do
    test "with OFP_FLOW_MOD packet(1)" do
      binary = File.read!(@flow_mod1)

      fm =
        binary
        |> Openflow.read()
        |> elem(1)
        |> Map.to_list()
        |> Openflow.FlowMod.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> elem(1)

      assert fm.cookie == 0
      assert fm.cookie_mask == 0
      assert fm.table_id == 1
      assert fm.command == :add
      assert fm.idle_timeout == 0
      assert fm.hard_timeout == 0
      assert fm.priority == 123
      assert fm.buffer_id == 0xFFFF
      assert fm.out_port == :any
      assert fm.out_group == :any
      assert fm.flags == []
      assert fm.match == Openflow.Match.new(eth_dst: "f20ba47df8ea")

      assert fm.instructions == [
               Openflow.Instruction.WriteActions.new([
                 Openflow.Action.SetField.new(vlan_vid: 258),
                 Openflow.Action.CopyTtlOut.new(),
                 Openflow.Action.CopyTtlIn.new(),
                 Openflow.Action.CopyTtlIn.new(),
                 Openflow.Action.PopPbb.new(),
                 Openflow.Action.PushPbb.new(4660),
                 Openflow.Action.PopMpls.new(39030),
                 Openflow.Action.PushMpls.new(34887),
                 Openflow.Action.PopVlan.new(),
                 Openflow.Action.PushVlan.new(33024),
                 Openflow.Action.DecMplsTtl.new(),
                 Openflow.Action.SetMplsTtl.new(10),
                 Openflow.Action.DecNwTtl.new(),
                 Openflow.Action.SetNwTtl.new(10),
                 Openflow.Action.Experimenter.new(101, <<0, 1, 2, 3, 4, 5, 6, 7>>),
                 Openflow.Action.SetQueue.new(3),
                 Openflow.Action.Group.new(99),
                 Openflow.Action.Output.new(6)
               ]),
               Openflow.Instruction.ApplyActions.new([
                 Openflow.Action.SetField.new(eth_src: "010203040506"),
                 Openflow.Action.SetField.new(onf_pbb_uca: 1)
               ])
             ]

      assert Openflow.to_binary(fm) == binary
    end

    test "with OFP_FLOW_MOD packet(2)" do
      binary = File.read!(@flow_mod2)
      {:ok, fm, ""} = Openflow.read(binary)

      assert fm.cookie == 0
      assert fm.cookie_mask == 0
      assert fm.table_id == 0
      assert fm.cookie == 0
      assert fm.command == :add
      assert fm.idle_timeout == 0
      assert fm.hard_timeout == 0
      assert fm.priority == 123
      assert fm.buffer_id == 0xFFFF
      assert fm.out_port == :any
      assert fm.out_group == :any
      assert fm.flags == []
      assert fm.match == Openflow.Match.new(in_port: 6, eth_src: "f20ba47df8ea")
      assert fm.instructions == [Openflow.Instruction.GotoTable.new(1)]
      assert Openflow.to_binary(fm) == binary
    end

    test "with OFP_FLOW_MOD packet(3)" do
      binary = File.read!(@flow_mod3)
      {:ok, fm, ""} = Openflow.read(binary)

      assert fm.cookie == 0
      assert fm.cookie_mask == 0
      assert fm.table_id == 1
      assert fm.command == :add
      assert fm.idle_timeout == 0
      assert fm.hard_timeout == 0
      assert fm.priority == 123
      assert fm.buffer_id == 0xFFFF
      assert fm.out_port == :any
      assert fm.out_group == :any
      assert fm.flags == []
      assert fm.match == Openflow.Match.new(eth_dst: "f20ba47df8ea")

      assert fm.instructions == [
               Openflow.Instruction.Meter.new(1),
               Openflow.Instruction.WriteActions.new([Openflow.Action.Output.new(6)])
             ]

      assert Openflow.to_binary(fm) == binary
    end

    test "with OFP_FLOW_MOD packet(4)" do
      binary = File.read!(@flow_mod4)
      {:ok, fm, ""} = Openflow.read(binary)

      assert fm.cookie == 0
      assert fm.cookie_mask == 0
      assert fm.table_id == 1
      assert fm.command == :add
      assert fm.idle_timeout == 0
      assert fm.hard_timeout == 0
      assert fm.priority == 123
      assert fm.buffer_id == 0xFFFF
      assert fm.out_port == :any
      assert fm.out_group == :any
      assert fm.flags == []

      assert fm.match ==
               Openflow.Match.new(
                 in_port: 84_281_096,
                 in_phy_port: 16_909_060,
                 metadata: 283_686_952_306_183,
                 eth_type: 2054,
                 eth_dst: "ffffffffffff",
                 eth_src: "f20ba47df8ea",
                 vlan_vid: 999,
                 ip_dscp: 9,
                 ip_ecn: 3,
                 ip_proto: 99,
                 ipv4_src: {1, 2, 3, 4},
                 ipv4_dst: {1, 2, 3, 4},
                 tcp_src: 8080,
                 tcp_dst: 18_080,
                 udp_src: 28_080,
                 udp_dst: 55_936,
                 sctp_src: 48_080,
                 sctp_dst: 59_328,
                 icmpv4_type: 100,
                 icmpv4_code: 101,
                 arp_op: 1,
                 arp_spa: {10, 0, 0, 1},
                 arp_tpa: {10, 0, 0, 3},
                 arp_sha: "f20ba47df8ea",
                 arp_tha: "000000000000",
                 ipv6_src: {65152, 0, 0, 0, 61451, 42239, 65096, 10405},
                 ipv6_dst: {65152, 0, 0, 0, 61451, 42239, 65029, 47068},
                 ipv6_flabel: 541_473,
                 icmpv6_type: 200,
                 icmpv6_code: 201,
                 ipv6_nd_target: {65152, 0, 0, 0, 2656, 28415, 65151, 29927},
                 ipv6_nd_sll: "00000000029a",
                 ipv6_nd_tll: "00000000022b",
                 mpls_label: 624_485,
                 mpls_tc: 5,
                 mpls_bos: 1,
                 pbb_isid: 11_259_375,
                 tunnel_id: 651_061_555_542_690_057,
                 ipv6_exthdr: [:auth, :frag, :router, :hop, :unrep, :unseq],
                 onf_pbb_uca: 1,
                 tun_src: {1, 2, 3, 4},
                 tun_dst: {1, 2, 3, 4}
               )

      assert fm.instructions == []
      assert Openflow.to_binary(fm) == binary
    end

    test "with OFP_FLOW_MOD packet(5)" do
      binary = File.read!(@flow_mod5)
      {:ok, fm, ""} = Openflow.read(binary)

      assert fm.cookie == 0x123456789ABCDEF0
      assert fm.cookie_mask == 0xFFFFFFFFFFFFFFFF
      assert fm.table_id == 2
      assert fm.command == :add
      assert fm.idle_timeout == 0
      assert fm.hard_timeout == 0
      assert fm.priority == 0
      assert fm.buffer_id == 0
      assert fm.out_port == 0
      assert fm.out_group == 0
      assert fm.flags == []

      assert fm.match ==
               Openflow.Match.new(
                 in_port: 43981,
                 eth_dst: "aabbcc998877",
                 eth_type: 2048,
                 vlan_vid: 5095,
                 ipv4_dst: {192, 168, 2, 1},
                 tunnel_id: 50_000,
                 tun_src: {192, 168, 2, 3},
                 tun_dst: {192, 168, 2, 4}
               )

      assert fm.instructions == [
               Openflow.Instruction.ApplyActions.new([
                 Openflow.Action.PopVlan.new(),
                 Openflow.Action.SetField.new(ipv4_dst: {192, 168, 2, 9}),
                 Openflow.Action.NxLearn.new(
                   hard_timeout: 300,
                   priority: 1,
                   table_id: 99,
                   flow_specs: [
                     Openflow.Action.NxFlowSpecMatch.new(
                       src: :vlan_vid,
                       dst: :vlan_vid,
                       n_bits: 12
                     ),
                     Openflow.Action.NxFlowSpecMatch.new(src: :nx_eth_src, dst: :nx_eth_dst),
                     Openflow.Action.NxFlowSpecLoad.new(src: 0, dst: :vlan_vid, n_bits: 12),
                     Openflow.Action.NxFlowSpecLoad.new(src: :tun_id, dst: :tun_id),
                     Openflow.Action.NxFlowSpecOutput.new(src: :in_port)
                   ]
                 )
               ]),
               Openflow.Instruction.GotoTable.new(100)
             ]

      assert Openflow.to_binary(fm) == binary
    end

    test "with OFP_FLOW_MOD packet(6)" do
      {:error, :binary_too_small} =
        @flow_mod6
        |> File.read!()
        |> Openflow.read()
    end

    test "with OFP_FLOW_MOD packet(7)" do
      binary = File.read!(@flow_mod7)
      {:ok, fm, ""} = Openflow.read(binary)

      assert fm.cookie == 0x123456789ABCDEF0
      assert fm.cookie_mask == 0xFFFFFFFFFFFFFFFF
      assert fm.table_id == 4
      assert fm.command == :add
      assert fm.idle_timeout == 0
      assert fm.hard_timeout == 0
      assert fm.priority == 0
      assert fm.buffer_id == 0
      assert fm.out_port == 0
      assert fm.out_group == 0
      assert fm.flags == []

      assert fm.match ==
               Openflow.Match.new(
                 in_port: 43981,
                 eth_dst: "aabbcc998877",
                 eth_type: 2048,
                 vlan_vid: 5095,
                 ipv4_dst: {192, 168, 2, 1},
                 tunnel_id: 50_000,
                 tun_src: {192, 168, 2, 3},
                 tun_dst: {192, 168, 2, 4}
               )

      assert fm.instructions == [
               Openflow.Instruction.ApplyActions.new([
                 Openflow.Action.NxConjunction.new(clause: 0, id: 0xABCDEF, n_clauses: 2)
               ])
             ]

      assert Openflow.to_binary(fm) == binary
    end

    test "with OFP_FLOW_MOD packet(8)" do
      binary = File.read!(@flow_mod8)
      {:ok, fm, ""} = Openflow.read(binary)

      assert fm.cookie == 0x123456789ABCDEF0
      assert fm.cookie_mask == 0xFFFFFFFFFFFFFFFF
      assert fm.table_id == 3
      assert fm.command == :add
      assert fm.idle_timeout == 0
      assert fm.hard_timeout == 0
      assert fm.priority == 0
      assert fm.buffer_id == 0
      assert fm.out_port == 0
      assert fm.out_group == 0
      assert fm.flags == []
      assert fm.match == Openflow.Match.new(conj_id: 0xABCDEF)

      assert fm.instructions == [
               Openflow.Instruction.ApplyActions.new([
                 Openflow.Action.PopVlan.new(),
                 Openflow.Action.SetField.new(ipv4_dst: {192, 168, 2, 9})
               ]),
               Openflow.Instruction.GotoTable.new(100)
             ]

      assert Openflow.to_binary(fm) == binary
    end
  end
end
