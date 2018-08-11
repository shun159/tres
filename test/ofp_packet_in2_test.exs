defmodule OfpPacketIn2Test do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with NX_PACKET_IN2 packet(with properties)" do
      {:ok, pktin, ""} =
        "test/packet_data/nx_packet_in2.raw"
        |> File.read!()
        |> Openflow.read()

      assert pktin.version == 1
      assert pktin.xid == 0
      assert pktin.full_len == 64
      assert pktin.table_id == 7
      assert pktin.buffer_id == 0x114
      assert pktin.cookie == 0xfedcba9876543210
      assert pktin.reason == :action
      assert pktin.metadata == [metadata: 0x5a5a5a5a5a5a5a5a]
      assert pktin.userdata == <<1, 2, 3, 4, 5>>
    end
  end
end
