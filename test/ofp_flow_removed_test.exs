defmodule OfpFlowRemovedTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_FLOW_REMOVED packet(with a match field)" do
      {:ok, flow_removed, ""} =
        "test/packet_data/4-40-ofp_flow_removed.packet"
        |> File.read!()
        |> Openflow.read()

      assert flow_removed.version == 4
      assert flow_removed.xid == 0
      assert flow_removed.cookie == 0
      assert flow_removed.priority == 0xFFFF
      assert flow_removed.reason == :idle_timeout
      assert flow_removed.table_id == 0
      assert flow_removed.duration_sec == 3
      assert flow_removed.duration_nsec == 48_825_000
      assert flow_removed.idle_timeout == 3
      assert flow_removed.hard_timeout == 0
      assert flow_removed.packet_count == 1
      assert flow_removed.byte_count == 86
      assert flow_removed.match == [eth_dst: "f20ba47df8ea"]
    end

    test "with OFP_FLOW_REMOVED packet(with match fields)" do
      {:ok, flow_removed, ""} =
        "test/packet_data/libofproto-OFP13-flow_removed.packet"
        |> File.read!()
        |> Openflow.read()

      assert flow_removed.version == 4
      assert flow_removed.xid == 0
      assert flow_removed.cookie == 0x123456789ABCDEF0
      assert flow_removed.priority == 100
      assert flow_removed.reason == :idle_timeout
      assert flow_removed.table_id == 1
      assert flow_removed.duration_sec == 600
      assert flow_removed.duration_nsec == 500
      assert flow_removed.idle_timeout == 400
      assert flow_removed.hard_timeout == 300
      assert flow_removed.packet_count == 200
      assert flow_removed.byte_count == 100

      assert flow_removed.match == [
               in_port: 43_981,
               eth_dst: "aabbcc998877",
               eth_type: 2048,
               vlan_vid: 5095,
               ipv4_dst: {192, 168, 2, 1},
               tunnel_id: 50_000,
               tun_src: {192, 168, 2, 3},
               tun_dst: {192, 168, 2, 4}
             ]
    end
  end
end
