defmodule OfpPacketIn2Test do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with NX_PACKET_IN2 packet(without continuations)" do
      {:ok, pktin, ""} =
        "test/packet_data/nx_packet_in2.raw"
        |> File.read!()
        |> Openflow.read()

      assert pktin.version == 1
      assert pktin.xid == 0
      assert pktin.full_len == 64
      assert pktin.table_id == 7
      assert pktin.buffer_id == 0x114
      assert pktin.cookie == 0xFEDCBA9876543210
      assert pktin.reason == :action
      assert pktin.metadata == [metadata: 0x5A5A5A5A5A5A5A5A]
      assert pktin.userdata == <<1, 2, 3, 4, 5>>
    end

    test "with NX_PACKET_IN2 packet(with continuations)" do
      pktin =
        "test/packet_data/4-64-ofp_nx_packet_in2.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert pktin.continuation_action_set == nil

      assert pktin.continuation_actions == [
               %Openflow.Action.NxResubmitTable{in_port: :in_port, table_id: 5}
             ]

      assert pktin.continuation_bridge ==
               <<8, 137, 105, 58, 5, 77, 183, 237, 163, 58, 25, 166, 212, 167, 209, 11>>

      assert pktin.continuation_conntracked == nil
      assert pktin.continuation_cookie == nil
      assert pktin.continuation_mirrors == nil
      assert pktin.continuation_stack == nil
      assert pktin.continuation_table_id == nil
      assert pktin.cookie == 0
      assert pktin.full_len == nil
      assert pktin.metadata == [in_port: 2, reg0: 3_232_235_778, reg1: 1]
      assert byte_size(pktin.packet) == 98
      assert pktin.reason == :action
      assert pktin.table_id == 0
      assert byte_size(pktin.userdata) == 49
    end
  end
end
