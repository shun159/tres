defmodule PacketInfo do
  @moduledoc """
  Packet parser based on supported match fields in OXM and NXM
  """

  alias Tres.MacAddress

  @eth_p_ip         0x0800
  @eth_p_arp        0x0806
  @eth_p_rarp       0x8035
  @eth_p_ipv6       0x86DD
  @eth_p_802_1q     0x8100
  @eth_p_802_1qinq  0x88a8
  @eth_p_mpls_uni   0x8847
  @eth_p_mpls_multi 0x8848

  @ipproto_icmp    1
  @ipproto_tcp     6
  @ipproto_udp    17
  @ipproto_icmpv6 58
  @ipproto_sctp  132

  @arpop_request   1
  @arpop_reply     2
  @arpop_inrequest 8
  @arpop_inreply   9
  @arpop_nak      10

  defstruct [
    # L2
    :eth_dst, :eth_src, :eth_type,
    # VLAN
    :vlan_tci,
    # L2.5(MPLS)
    :mpls_label, :mpls_tc, :mpls_bos, :mpls_ttl,
    # L2.5(PBB)
    :pbb_isid,
    # L3(IP)
    :ip_tos, :ip_ttl, :ip_proto, :ipv4_src, :ipv4_dst,
    :ipv6_src, :ipv6_dst, :ipv6_flabel, :ipv6_exthdr,
    # L3(ARP)
    :arp_op, :arp_sha, :arp_spa, :arp_tha, :arp_tpa,
    # L3(ipv6 ND)
    :ipv6_nd_target, :ipv6_nd_sll, :ipv6_nd_tll,
    # L4(TCP)
    :tcp_src, :tcp_dst, :tcp_flags,
    # L4(UDP)
    :udp_src, :udp_dst,
    # L4(SCTP)
    :sctp_src, :sctp_dst,
    # L4(ICMPv4)
    :icmpv4_type, :icmpv4_code,
    # L4(ICMPv6)
    :icmpv6_type, :icmpv6_code
  ]

  @type t :: %PacketInfo{
    eth_dst: String.t() | nil,
    eth_src: String.t() | nil,
    eth_type: :ipv4 | :ipv6 | :arp | :rarp | :"802.1q" | :"802.1qinq" | :lldp | :mpls | 0..65535 | nil,
    mpls_label: 0..0xfffff | nil,
    mpls_tc: 0..7,
    mpls_bos: boolean() | nil,
    mpls_ttl: 0..255 | nil,
    pbb_isid: 0..0xffffff | nil,
    ip_tos: 0..255 | nil,
    ip_ttl: 0..255 | nil,
    ip_proto: 0..255 | :tcp | :udp | :icmp | :sctp | nil,
    ipv4_src: :inet.ip4_address() | nil,
    ipv4_dst: :inet.ip4_address() | nil,
    ipv6_src: :inet.ip6_address() | nil,
    ipv6_dst: :inet.ip6_address() | nil,
    ipv6_flabel: 0..0xfffff,
    ipv6_exthdr: [:nonext | :esp | :auth | :dest | :frag | :router | :hop | :unrep | :unseq] | nil,
    arp_op: :request | :reply | :inrequest | :inreply | nil,
    arp_sha: String.t() | nil,
    arp_spa: :inet.ip4_address() | nil,
    arp_tha: String.t() | nil,
    arp_tpa: :inet.ip4_address() | nil,
    ipv6_nd_target: :inet.ip6_address() | nil,
    ipv6_nd_sll: String.t() | nil,
    ipv6_nd_tll: String.t() | nil,
    tcp_src: 0..0xffff | nil,
    tcp_dst: 0..0xffff | nil,
    tcp_flags: [:fin | :syn | :rst | :psh | :ack | :urg | :ece | :cwr | :ns] | nil,
    udp_src: 0..0xffff | nil,
    udp_dst: 0..0xffff | nil,
    sctp_src: 0..0xffff | nil,
    sctp_dst: 0..0xffff | nil,
    icmpv4_type: 0..0xff | nil,
    icmpv4_code: 0..0xff | nil,
    icmpv6_type: 0..0xff | nil,
    icmpv6_code: 0..0xff | nil
  }

  @spec decapsulate(packet :: binary()) :: PacketInfo.t()
  def decapsulate(<<daddr::6-bytes, saddr::6-bytes, eth_type::16, rest::bytes>>) do
    packet_info =
      %PacketInfo{
        eth_dst: MacAddress.bin_to_str(daddr),
        eth_src: MacAddress.bin_to_str(saddr),
        eth_type: eth_type(eth_type)
      }

    decapsulate_next({eth_type(eth_type), rest}, packet_info)
  end

  # private functions

  defp decapsulate_next({:ipv4, <<_::4, hl::4, _::bytes>> = packet}, pi)
      when byte_size(packet) >= 20 do
    opt_len = (hl - 5) * 4
    <<4::4, _hl::4, tos::8, _len::16, _id::16, _frag::3,
      _offset::13, ttl::8, proto::8, _sum::16,
      sa1, sa2, sa3, sa4,
      da1, da2, da3, da4,
      _opt::size(opt_len)-bytes,
      rest::bytes>> = packet

    decapsulate_next(
      {ip_proto(proto), rest},
      %{pi
        | ip_tos:   tos,
          ip_proto: ip_proto(proto),
          ip_ttl:   ttl,
          ipv4_src: {sa1, sa2, sa3, sa4},
          ipv4_dst: {da1, da2, da3, da4}
      }
    )
  end

  defp decapsulate_next({arp, packet}, pi)
      when (arp == :arp or arp == :rarp) and byte_size(packet) >= 28 do
    <<_::6-bytes, op::16,
      sha::6-bytes, sa1, sa2, sa3, sa4,
      tha::6-bytes, da1, da2, da3, da4,
      _::bytes>> = packet

    %{pi
      | arp_op: arp_op(op),
        arp_sha: MacAddress.bin_to_str(sha),
        arp_spa: {sa1, sa2, sa3, sa4},
        arp_tha: MacAddress.bin_to_str(tha),
        arp_tpa: {da1, da2, da3, da4}
    }
  end

  defp decapsulate_next({:ipv6, packet}, pi) when byte_size(packet) >= 40 do
    <<6::4, class::8, flow::20,
      _len::16, next::8, hop::8,
      sa1::16, sa2::16, sa3::16, sa4::16, sa5::16, sa6::16, sa7::16, sa8::16,
      da1::16, da2::16, da3::16, da4::16, da5::16, da6::16, da7::16, da8::16,
      rest::binary>> = packet

    decapsulate_next(
      {ip_proto(next), rest},
      %{pi
        | ipv6_src: {sa1, sa2, sa3, sa4, sa5, sa6, sa7, sa8},
          ipv6_dst: {da1, da2, da3, da4, da5, da6, da7, da8},
          ipv6_flabel: flow,
          ip_tos: class,
          ip_proto: ip_proto(next),
          ip_ttl: hop,
      })
  end

  defp decapsulate_next({vlan, <<tci::12, type::16, rest::bytes>>}, pi)
  when vlan == :"802.1q" or vlan == :"802.1qinq",
    do: decapsulate_next(
          {eth_type(type), rest},
          %{pi | vlan_tci: tci, eth_type: eth_type(type)}
        )

  defp decapsulate_next({:mpls, packet}, pi) do
    <<label::20, tc::3, bos::1, ttl::8, rest::bytes>> = packet
    <<next_int::4, _::bytes>> = rest

    next =
      case next_int do
        4 -> :ipv4
        6 -> :ipv6
      end

    decapsulate_next(
      {next, rest},
      %{pi | mpls_label: label, mpls_tc: tc, mpls_ttl: ttl, mpls_bos: bos}
    )
  end

  defp decapsulate_next({:icmpv4, <<type::8, code::8, _::bytes>>}, pi) do
    %{pi | icmpv4_type: type, icmpv4_code: code}
  end

  defp decapsulate_next({:tcp, packet}, pi) do
    <<sport::16, dport::16, _seq::32,
      _ack::32, _off::4, 0::3, flags_int::9, _::bytes>> = packet

    tcp_flags = Openflow.Enums.tcp_flags_to_atom(flags_int)
    %{pi | tcp_src: sport, tcp_dst: dport, tcp_flags: tcp_flags}
  end

  defp decapsulate_next({:udp, <<sport::16, dport::16, _::bytes>>}, pi) do
    %{pi | udp_src: sport, udp_dst: dport}
  end

  defp decapsulate_next({:sctp, <<sport::16, dport::16, _::bytes>>}, pi) do
    %{pi | sctp_src: sport, sctp_dst: dport}
  end

  @spec eth_type(non_neg_integer()) :: atom() | 0..0xffff
  defp eth_type(@eth_p_ip), do: :ipv4

  defp eth_type(@eth_p_arp), do: :arp

  defp eth_type(@eth_p_rarp), do: :rarp

  defp eth_type(@eth_p_ipv6), do: :ipv6

  defp eth_type(@eth_p_802_1q), do: :"802.1q"

  defp eth_type(@eth_p_802_1qinq),  do: :"802.1qinq"

  defp eth_type(type) when type == @eth_p_mpls_uni or type == @eth_p_mpls_multi, do: :mpls

  defp eth_type(type), do: type

  @spec arp_op(non_neg_integer()) :: atom() | 0..0xffff
  defp arp_op(@arpop_request), do: :request

  defp arp_op(@arpop_reply), do: :reply

  defp arp_op(@arpop_inrequest), do: :inrequest

  defp arp_op(@arpop_inreply), do: :inreply

  defp arp_op(@arpop_nak), do: :nak

  @spec ip_proto(non_neg_integer()) :: atom() :: 0..0xff
  defp ip_proto(@ipproto_icmp), do: :icmpv4

  defp ip_proto(@ipproto_tcp), do: :tcp

  defp ip_proto(@ipproto_udp), do: :udp

  defp ip_proto(@ipproto_icmpv6), do: :icmpv6

  defp ip_proto(@ipproto_sctp), do: :sctp

  defp ip_proto(ipproto), do: ipproto
end
