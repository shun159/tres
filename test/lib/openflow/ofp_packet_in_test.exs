defmodule OfpPacketInTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_PACKET_IN packet(with simple matches)" do
      {:ok, pktin, ""} =
        "test/packet_data/4-4-ofp_packet_in.packet"
        |> File.read!()
        |> Openflow.read()

      assert pktin.version == 4
      assert pktin.xid == 0
      assert pktin.total_len == 42
      assert pktin.table_id == 1
      assert pktin.reason == :action
      assert pktin.in_port == 6

      assert pktin.match == [
               eth_type: 2054,
               eth_dst: <<0xFFFFFFFFFFFF::48>>,
               eth_src: <<0xF20BA47DF8EA::48>>,
               arp_op: 1,
               arp_spa: {10, 0, 0, 1},
               arp_tpa: {10, 0, 0, 3},
               arp_sha: <<0xF20BA47DF8EA::48>>,
               arp_tha: <<0x000000000000::48>>
             ]
    end
  end
end
