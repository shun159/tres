defmodule OfpResumeTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with NX_RESUME packet(with continuations)" do
      pktin =
        "test/packet_data/4-65-ofp_nx_resume.packet"
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
      assert pktin.metadata == [in_port: :controller, reg0: 3_232_235_778, reg1: 1]
      assert byte_size(pktin.packet) == 42
      assert pktin.reason == nil
      assert pktin.table_id == 0
      assert byte_size(pktin.userdata) == 49
    end
  end
end
