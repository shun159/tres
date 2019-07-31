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
      assert fm.match == Openflow.Match.new(in_port: 6, eth_src: <<0xF20BA47DF8EA::48>>)
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
      assert fm.match == Openflow.Match.new(eth_dst: <<0xF20BA47DF8EA::48>>)

      assert fm.instructions == [
               Openflow.Instruction.Meter.new(1),
               Openflow.Instruction.WriteActions.new([Openflow.Action.Output.new(6)])
             ]

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
                 eth_dst: <<0xAABBCC998877::48>>,
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
                     Openflow.Action.NxFlowSpecLoad.new(
                       src: 0,
                       dst: :vlan_vid,
                       n_bits: 12
                     ),
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
                 eth_dst: <<0xAABBCC998877::48>>,
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
