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

    test "with OFP_PACKET_IN packet(with complex matches)" do
      {:ok, pktin, ""} =
        "test/packet_data/4-59-ofp_packet_in.packet"
        |> File.read!()
        |> Openflow.read()

      assert pktin.version == 4
      assert pktin.xid == 0
      assert pktin.total_len == 0
      assert pktin.table_id == 200
      assert pktin.reason == :no_match
      assert pktin.in_port == 84_281_096

      assert pktin.match == [
               in_phy_port: 16_909_060,
               metadata: 283_686_952_306_183,
               eth_type: 2054,
               eth_dst: <<0xFFFFFFFFFFFF::48>>,
               eth_src: <<0xF20BA47DF8EA::48>>,
               vlan_vid: 999,
               ip_dscp: 9,
               ip_ecn: 3,
               ip_proto: 99,
               ipv4_src: {1, 2, 3, 4},
               ipv4_dst: {1, 2, 3, 4},
               tcp_src: 8080,
               tcp_dst: 18080,
               udp_src: 28080,
               udp_dst: 55936,
               sctp_src: 48080,
               sctp_dst: 59328,
               icmpv4_type: 100,
               icmpv4_code: 101,
               arp_op: 1,
               arp_spa: {10, 0, 0, 1},
               arp_tpa: {10, 0, 0, 3},
               arp_sha: <<0xF20BA47DF8EA::48>>,
               arp_tha: <<0x000000000000::48>>,
               ipv6_src: {65152, 0, 0, 0, 61451, 42239, 65096, 10405},
               ipv6_dst: {65152, 0, 0, 0, 61451, 42239, 65029, 47068},
               ipv6_flabel: 541_473,
               icmpv6_type: 200,
               icmpv6_code: 201,
               ipv6_nd_target: {65152, 0, 0, 0, 2656, 28415, 65151, 29927},
               ipv6_nd_sll: <<0x00000000029A::48>>,
               ipv6_nd_tll: <<0x00000000022B::48>>,
               mpls_label: 624_485,
               mpls_tc: 5,
               mpls_bos: 1,
               pbb_isid: 11_259_375,
               tunnel_id: 651_061_555_542_690_057,
               ipv6_exthdr: [:auth, :frag, :router, :hop, :unrep, :unseq],
               onf_pbb_uca: 1,
               tun_src: {1, 2, 3, 4},
               tun_dst: {1, 2, 3, 4}
             ]
    end
  end
end
