defmodule Openflow.Match do
  @moduledoc false

  use Bitwise

  defstruct(type: :oxm, fields: [])

  @type t :: %__MODULE__{type: :oxm, fields: Keyword.t()}

  # Match Classes

  @type u8 :: 0..0xFF
  @type u16 :: 0..0xFFFF
  @type u24 :: 0..0xFFFFFF
  @type u32 :: 0..0xFFFFFFFF
  @type u64 :: 0..0xFFFFFFFFFFFFFFFF
  @type u128 :: 0..0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

  @type eth_addr :: <<_::48>>
  @type in_addr :: :inet.ip4_address()
  @type in6_addr :: :inet.ip6_address()

  @spec new(Keyword.t()) :: t()
  def new(fields \\ []) do
    %__MODULE__{type: :oxm, fields: fields}
  end

  @spec to_binary(t()) :: <<_::_*8>>
  def to_binary(%__MODULE__{fields: fields} = match) do
    fields_bin = encode_fields(fields, <<>>)
    length = byte_size(fields_bin) + 4
    type_int = Openflow.Enums.to_int(match.type, :match_type)
    padding = Openflow.Utils.padding(length, 8)
    <<type_int::16, length::16, fields_bin::bytes, 0::size(padding)-unit(8)>>
  end

  def read(<<_::16, no_pad_len::16, tail::bytes>>) do
    pad_len = Openflow.Utils.pad_length(no_pad_len, 8)
    fields_len = no_pad_len - 4
    <<fields_bin::size(fields_len)-bytes, _::size(pad_len)-unit(8), rest::bytes>> = tail
    fields = decode_fields([], fields_bin)
    {fields, rest}
  end

  def codec_header(<<0xFFFF::16, oxm_field::7, has_mask::1, _len::8, exp_int::32>>) do
    oxm_field = match_field({0xFFFF, exp_int}, oxm_field)
    if has_mask == 1, do: :"masked_#{oxm_field}", else: oxm_field
  end

  def codec_header(<<oxm_class::16, oxm_field::7, has_mask::1, _len::8>>) do
    oxm_field = match_field(oxm_class, oxm_field)
    if has_mask == 1, do: :"masked_#{oxm_field}", else: oxm_field
  end

  def codec_header(oxm_field) when is_atom(oxm_field) do
    field_str = "#{oxm_field}"
    has_mask = if String.match?(field_str, ~r/^masked_/), do: 1, else: 0

    oxm_field =
      if has_mask == 1, do: :"#{String.replace(field_str, ~r/^masked_/, "")}", else: oxm_field

    case match_class(oxm_field) do
      {oxm_class_int, vendor_int} ->
        oxm_class = Openflow.Enums.oxm_class_to_atom(oxm_class_int)
        oxm_field_int = Openflow.Enums.to_int(oxm_field, oxm_class)
        oxm_length = div(n_bits_of(oxm_field) + 6, 8)
        <<oxm_class_int::16, 0::7, has_mask::1, oxm_length::8, vendor_int::32, oxm_field_int::16>>

      oxm_class_int ->
        oxm_class = Openflow.Enums.oxm_class_to_atom(oxm_class_int)
        oxm_field_int = Openflow.Enums.to_int(oxm_field, oxm_class)
        oxm_length = div(n_bits_of(oxm_field), 8)
        <<oxm_class_int::16, oxm_field_int::7, has_mask::1, oxm_length::8>>
    end
  end

  def n_bits_of(f) do
    f
    |> format_type()
    |> bit_len()
  end

  @spec decode_value(binary(), atom()) :: term()
  def decode_value(v0, f) do
    v = trim_heading_pad(v0, f)

    f
    |> format_type()
    |> _decode_value(v)
  end

  @spec encode_value(term(), atom()) :: binary()
  def encode_value(v, f) do
    f
    |> format_type()
    |> _encode_value(v)
  end

  def header_size(<<oxm_header::4-bytes, _::bytes>>) do
    case oxm_header do
      <<0xFFFF::16, _::16>> -> 8
      <<_oxm_class::16, _::16>> -> 4
    end
  end

  # private functions

  ## Encode

  defp encode_fields([field | rest], <<acc::bytes>>),
    do: encode_fields(rest, <<acc::bytes, encode_field(field)::bytes>>)

  defp encode_fields([], <<acc::bytes>>),
    do: acc

  defp encode_field({f, {v, m}}) do
    t = format_type(f)
    class = match_class(f)
    field = match_field(class, f)
    value = _encode_value(t, v)
    mask = _encode_value(t, m)
    oxm_header = oxm_header_w(class, field, byte_size(value))
    <<oxm_header::bytes, value::bytes, mask::bytes>>
  end

  defp encode_field({f, v}) do
    t = format_type(f)
    class = match_class(f)
    field = match_field(class, f)
    value = _encode_value(t, v)
    oxm_header = oxm_header(class, field, byte_size(value))
    <<oxm_header::bytes, value::bytes>>
  end

  ## Decode

  defp decode_fields(acc, <<>>),
    do: Enum.reverse(acc)

  defp decode_fields(
         acc,
         <<
           0xFFFF::16,
           _::7,
           has_mask::1,
           length::8,
           body_bin::size(length)-bytes,
           rest::bytes
         >>
       ) do
    value_len = length - 6
    <<exp_int::32, field_int::16, value_bin::size(value_len)-bytes>> = body_bin
    oxm_field = match_field({0xFFFF, exp_int}, field_int)
    field = decode_field(has_mask, oxm_field, value_bin)
    decode_fields([field | acc], rest)
  end

  defp decode_fields(acc, <<oxm_header::4-bytes, tail::bytes>>) do
    <<oxm_class::16, oxm_field::7, has_mask::1, length::8>> = oxm_header
    <<body_bin::size(length)-bytes, rest::bytes>> = tail
    oxm_field = match_field(oxm_class, oxm_field)
    field = decode_field(has_mask, oxm_field, body_bin)
    decode_fields([field | acc], rest)
  end

  defp decode_field(1, oxm_field, binary) do
    type = format_type(oxm_field)
    length = div(byte_size(binary), 2)
    <<value_bin::size(length)-bytes, mask_bin::size(length)-bytes>> = binary
    value = _decode_value(type, value_bin)
    mask = _decode_value(type, mask_bin)
    {oxm_field, {value, mask}}
  end

  defp decode_field(0, oxm_field, binary) do
    type = format_type(oxm_field)
    value = _decode_value(type, binary)
    {oxm_field, value}
  end

  ## Encode Types

  defp _encode_value(:ofp13_port_no, v),
    do: <<Openflow.Utils.get_enum(v, :openflow13_port_no)::32>>

  defp _encode_value(:ofp10_port_no, v),
    do: <<Openflow.Utils.get_enum(v, :openflow10_port_no)::32>>

  defp _encode_value(:tcp_flags, v),
    do: <<Openflow.Enums.flags_to_int(v, :tcp_flags)::16>>

  defp _encode_value(:ipv6exthdr_flags, v),
    do: <<Openflow.Enums.flags_to_int(v, :ipv6exthdr_flags)::16>>

  defp _encode_value(:tun_gbp_flags, v),
    do: <<Openflow.Enums.flags_to_int(v, :tun_gbp_flags)::8>>

  defp _encode_value(:ct_state_flags, v),
    do: <<Openflow.Enums.flags_to_int(v, :ct_state_flags)::32>>

  defp _encode_value(:mac, <<mac::6-bytes>>), do: mac

  defp _encode_value(:in_addr, {a1, a2, a3, a4}), do: <<a1, a2, a3, a4>>

  defp _encode_value(:in6_addr, {a1, a2, a3, a4, a5, a6, a7, a8}),
    do: <<
      a1::16,
      a2::16,
      a3::16,
      a4::16,
      a5::16,
      a6::16,
      a7::16,
      a8::16
    >>

  defp _encode_value(:u8, v), do: <<v::8>>

  defp _encode_value(:u16, v), do: <<v::16>>

  defp _encode_value(:u24, v), do: <<v::24>>

  defp _encode_value(:u32, v), do: <<v::32>>

  defp _encode_value(:u64, v), do: <<v::64>>

  defp _encode_value(:u128, v), do: <<v::128>>

  defp _encode_value(:arbitrary, v), do: <<v::bytes>>

  ## Decode types

  defp _decode_value(:ofp13_port_no, <<v::32>>),
    do: Openflow.Utils.get_enum(v, :openflow13_port_no)

  defp _decode_value(:ofp10_port_no, <<v::16>>),
    do: Openflow.Utils.get_enum(v, :openflow10_port_no)

  defp _decode_value(:tcp_flags, <<v::16>>),
    do: Openflow.Enums.int_to_flags(v, :tcp_flags)

  defp _decode_value(:ipv6exthdr_flags, <<v::16>>),
    do: Openflow.Enums.int_to_flags(v, :ipv6exthdr_flags)

  defp _decode_value(:tun_gbp_flags, <<v::8>>),
    do: Openflow.Enums.int_to_flags(v, :tun_gbp_flags)

  defp _decode_value(:ct_state_flags, <<v::32>>),
    do: Openflow.Enums.int_to_flags(v, :ct_state_flags)

  defp _decode_value(:mac, <<v::6-bytes>>),
    do: v

  defp _decode_value(:in_addr, <<a1, a2, a3, a4>>),
    do: {a1, a2, a3, a4}

  defp _decode_value(:in6_addr, <<
         a1::16,
         a2::16,
         a3::16,
         a4::16,
         a5::16,
         a6::16,
         a7::16,
         a8::16
       >>),
       do: {a1, a2, a3, a4, a5, a6, a7, a8}

  defp _decode_value(:u8, <<v::8>>), do: v

  defp _decode_value(:u16, <<v::16>>), do: v

  defp _decode_value(:u24, <<v::24>>), do: v

  defp _decode_value(:u32, <<v::32>>), do: v

  defp _decode_value(:u64, <<v::64>>), do: v

  defp _decode_value(:u128, <<v::128>>), do: v

  defp _decode_value(:arbitrary, <<v::bytes>>), do: v

  ## Bit size

  defp bit_len(:ofp13_port_no), do: 32

  defp bit_len(:ofp10_port_no), do: 16

  defp bit_len(:tcp_flags), do: 16

  defp bit_len(:ipv6exthdr_flags), do: 16

  defp bit_len(:tun_gbp_flags), do: 8

  defp bit_len(:ct_state_flags), do: 32

  defp bit_len(:mac), do: 48

  defp bit_len(:in_addr), do: 32

  defp bit_len(:in6_addr), do: 128

  defp bit_len(:u8), do: 8

  defp bit_len(:u16), do: 16

  defp bit_len(:u24), do: 24

  defp bit_len(:u32), do: 32

  defp bit_len(:u64), do: 64

  defp bit_len(:u128), do: 128

  defp bit_len(:arbitrary), do: 0

  ## OXM Match classes

  @spec match_field(integer() | {integer(), integer()}, atom()) :: integer()
  defp match_field({0xFFFF, exp}, f) do
    class = Openflow.Utils.get_enum(exp, :experimenter_oxm_vendors)
    Openflow.Utils.get_enum(f, class)
  end

  defp match_field(c, f) do
    class = Openflow.Utils.get_enum(c, :oxm_class)
    Openflow.Utils.get_enum(f, class)
  end

  # OpenFlow Basic
  defp match_class(f)
       when f in [
              :in_port,
              :in_phy_port,
              :metadata,
              :eth_dst,
              :eth_src,
              :eth_type,
              :vlan_vid,
              :vlan_pcp,
              :ip_dscp,
              :ip_ecn,
              :ip_proto,
              :ipv4_src,
              :ipv4_dst,
              :tcp_src,
              :tcp_dst,
              :udp_src,
              :udp_dst,
              :sctp_src,
              :sctp_dst,
              :icmpv4_type,
              :icmpv4_code,
              :arp_op,
              :arp_spa,
              :arp_tpa,
              :arp_sha,
              :arp_tha,
              :ipv6_src,
              :ipv6_dst,
              :ipv6_flabel,
              :icmpv6_type,
              :icmpv6_code,
              :ipv6_nd_target,
              :ipv6_nd_sll,
              :ipv6_nd_tll,
              :mpls_label,
              :mpls_tc,
              :mpls_bos,
              :pbb_isid,
              :tunnel_id,
              :ipv6_exthdr,
              :pbb_uca,
              :packet_type
            ],
       do: 0x8000

  # PacketRegisters
  defp match_class(f)
       when f in [
              :xreg0,
              :xreg1,
              :xreg2,
              :xreg3,
              :xreg4,
              :xreg5,
              :xreg6,
              :xreg7
            ],
       do: 0x8001

  # NXM_0
  defp match_class(f)
       when f in [
              :nx_in_port,
              :nx_eth_dst,
              :nx_eth_src,
              :nx_eth_type,
              :nx_vlan_tci,
              :nx_ip_tos,
              :nx_ip_proto,
              :nx_ipv4_src,
              :nx_ipv4_dst,
              :nx_tcp_src,
              :nx_tcp_dst,
              :nx_udp_src,
              :nx_udp_dst,
              :nx_icmpv4_type,
              :nx_icmpv4_code,
              :nx_arp_op,
              :nx_arp_spa,
              :nx_arp_tpa,
              :nx_tcp_flags
            ],
       do: 0x0000

  # NXM_1
  defp match_class(f)
       when f in [
              :reg0,
              :reg1,
              :reg2,
              :reg3,
              :reg4,
              :reg5,
              :reg6,
              :reg7,
              :reg8,
              :reg9,
              :reg10,
              :reg11,
              :reg12,
              :reg13,
              :reg14,
              :reg15,
              :tun_id,
              :nx_arp_sha,
              :nx_arp_tha,
              :nx_ipv6_src,
              :nx_ipv6_dst,
              :nx_icmpv6_type,
              :nx_icmpv6_code,
              :nx_ipv6_nd_target,
              :nx_ipv6_nd_sll,
              :nx_ipv6_nd_tll,
              :nx_ip_frag,
              :nx_ipv6_label,
              :nx_ip_ecn,
              :nx_ip_ttl,
              :nx_mpls_ttl,
              :tun_src,
              :tun_dst,
              :pkt_mark,
              :dp_hash,
              :recirc_id,
              :conj_id,
              :tun_gbp_id,
              :tun_gbp_flags,
              :tun_metadata0,
              :tun_metadata1,
              :tun_metadata2,
              :tun_metadata3,
              :tun_metadata4,
              :tun_metadata5,
              :tun_metadata6,
              :tun_metadata7,
              :tun_metadata8,
              :tun_metadata9,
              :tun_metadata10,
              :tun_metadata11,
              :tun_metadata12,
              :tun_metadata13,
              :tun_metadata14,
              :tun_metadata15,
              :tun_metadata16,
              :tun_metadata17,
              :tun_metadata18,
              :tun_metadata19,
              :tun_metadata20,
              :tun_metadata21,
              :tun_metadata22,
              :tun_metadata23,
              :tun_metadata24,
              :tun_metadata25,
              :tun_metadata26,
              :tun_metadata27,
              :tun_metadata28,
              :tun_metadata29,
              :tun_metadata30,
              :tun_metadata31,
              :tun_metadata32,
              :tun_metadata33,
              :tun_metadata34,
              :tun_metadata35,
              :tun_metadata36,
              :tun_metadata37,
              :tun_metadata38,
              :tun_metadata39,
              :tun_metadata40,
              :tun_metadata41,
              :tun_metadata42,
              :tun_metadata43,
              :tun_metadata44,
              :tun_metadata45,
              :tun_metadata46,
              :tun_metadata47,
              :tun_metadata48,
              :tun_metadata49,
              :tun_metadata50,
              :tun_metadata51,
              :tun_metadata52,
              :tun_metadata53,
              :tun_metadata54,
              :tun_metadata55,
              :tun_metadata56,
              :tun_metadata57,
              :tun_metadata58,
              :tun_metadata59,
              :tun_metadata60,
              :tun_metadata61,
              :tun_metadata62,
              :tun_metadata63,
              :tun_flags,
              :ct_state,
              :ct_zone,
              :ct_mark,
              :ct_label,
              :tun_ipv6_src,
              :tun_ipv6_dst,
              :xxreg0,
              :xxreg1,
              :xxreg2,
              :xxreg3,
              :xxreg4,
              :xxreg5,
              :xxreg6,
              :xxreg7,
              :ct_nw_proto,
              :ct_nw_src,
              :ct_nw_dst,
              :ct_ipv6_src,
              :ct_ipv6_dst,
              :ct_tp_src,
              :ct_tp_dst
            ],
       do: 0x0001

  # Nicira Ext
  defp match_class(f)
       when f in [
              :nsh_flags,
              :nsh_mdtype,
              :nsh_np,
              :nsh_spi,
              :nsh_si,
              :nsh_c1,
              :nsh_c2,
              :nsh_c3,
              :nsh_c4,
              :nsh_ttl
            ],
       do: {0xFFFF, 0x00002320}

  # ONF Ext
  defp match_class(f)
       when f in [
              :onf_tcp_flags,
              :onf_actset_output,
              :onf_pbb_uca
            ],
       do: {0xFFFF, 0x4F4E4600}

  # Special types

  defp format_type(t)
       when t in [
              :in_port,
              :in_phy_port,
              :onf_actset_output
            ],
       do: :ofp13_port_no

  defp format_type(t)
       when t in [
              :nx_in_port
            ],
       do: :ofp10_port_no

  # Composite types

  defp format_type(t)
       when t in [
              :nx_tcp_flags,
              :onf_tcp_flags
            ],
       do: :tcp_flags

  defp format_type(t)
       when t in [
              :ipv6_exthdr
            ],
       do: :ipv6exthdr_flags

  defp format_type(t)
       when t in [
              :tun_gbp_flags
            ],
       do: :tun_gbp_flags

  defp format_type(t)
       when t in [
              :ct_state
            ],
       do: :ct_state_flags

  defp format_type(t)
       when t in [
              :eth_dst,
              :eth_src,
              :arp_sha,
              :arp_tha,
              :ipv6_nd_sll,
              :ipv6_nd_tll,
              :nx_eth_dst,
              :nx_eth_src,
              :nx_arp_sha,
              :nx_arp_tha,
              :nx_ipv6_nd_sll,
              :nx_ipv6_nd_tll
            ],
       do: :mac

  defp format_type(t)
       when t in [
              :ipv4_src,
              :ipv4_dst,
              :arp_spa,
              :arp_tpa,
              :nx_ipv4_src,
              :nx_ipv4_dst,
              :nx_arp_spa,
              :nx_arp_tpa,
              :tun_src,
              :tun_dst,
              :ct_nw_src,
              :ct_nw_dst
            ],
       do: :in_addr

  defp format_type(t)
       when t in [
              :ipv6_src,
              :ipv6_dst,
              :ipv6_nd_target,
              :nx_ipv6_src,
              :nx_ipv6_dst,
              :nx_ipv6_nd_target,
              :tun_ipv6_src,
              :tun_ipv6_dst,
              :ct_ipv6_src,
              :ct_ipv6_dst
            ],
       do: :in6_addr

  # Scalar types

  defp format_type(t)
       when t in [
              :vlan_pcp,
              :ip_dscp,
              :ip_ecn,
              :ip_proto,
              :icmpv4_code,
              :icmpv4_type,
              :icmpv6_code,
              :icmpv6_type,
              :mpls_tc,
              :mpls_bos,
              :nx_ip_tos,
              :nx_ip_proto,
              :nx_icmpv4_code,
              :nx_icmpv4_type,
              :nx_icmpv6_code,
              :nx_icmpv6_type,
              :nx_ip_frag,
              :nx_ip_ecn,
              :nx_ip_ttl,
              :nx_mpls_ttl,
              :ct_nw_proto,
              :nsh_flags,
              :nsh_mdtype,
              :nsh_np,
              :nsh_si,
              :nsh_ttl,
              :pbb_uca,
              :onf_pbb_uca
            ],
       do: :u8

  defp format_type(t)
       when t in [
              :eth_type,
              :vlan_vid,
              :nx_vlan_tci,
              :tcp_src,
              :tcp_dst,
              :udp_src,
              :udp_dst,
              :sctp_src,
              :sctp_dst,
              :arp_op,
              :nx_eth_type,
              :nx_tcp_src,
              :nx_tcp_dst,
              :nx_udp_src,
              :nx_udp_dst,
              :nx_arp_op,
              :tun_gbp_id,
              :tun_flags,
              :ct_zone,
              :ct_tp_src,
              :ct_tp_dst
            ],
       do: :u16

  defp format_type(t)
       when t in [
              :pbb_isid
            ],
       do: :u24

  defp format_type(t)
       when t in [
              :ipv6_flabel,
              :mpls_label,
              :reg0,
              :reg1,
              :reg2,
              :reg3,
              :reg4,
              :reg5,
              :reg6,
              :reg7,
              :reg8,
              :reg9,
              :reg10,
              :reg11,
              :reg12,
              :reg13,
              :reg14,
              :reg15,
              :nx_ipv6_flabel,
              :pkt_mark,
              :dp_hash,
              :recirc_id,
              :conj_id,
              :ct_mark,
              :nsh_spi,
              :nsh_c1,
              :nsh_c2,
              :nsh_c3,
              :nsh_c4,
              :packet_type
            ],
       do: :u32

  defp format_type(t)
       when t in [
              :metadata,
              :tunnel_id,
              :tun_id,
              :xreg0,
              :xreg1,
              :xreg2,
              :xreg3,
              :xreg4,
              :xreg5,
              :xreg6,
              :xreg7
            ],
       do: :u64

  defp format_type(t)
       when t in [
              :ct_label,
              :xxreg0,
              :xxreg1,
              :xxreg2,
              :xxreg3,
              :xxreg4,
              :xxreg5,
              :xxreg6,
              :xxreg7
            ],
       do: :u128

  defp format_type(t)
       when t in [
              :tun_metadata0,
              :tun_metadata1,
              :tun_metadata2,
              :tun_metadata3,
              :tun_metadata4,
              :tun_metadata5,
              :tun_metadata6,
              :tun_metadata7,
              :tun_metadata8,
              :tun_metadata9,
              :tun_metadata10,
              :tun_metadata11,
              :tun_metadata12,
              :tun_metadata13,
              :tun_metadata14,
              :tun_metadata15,
              :tun_metadata16,
              :tun_metadata17,
              :tun_metadata18,
              :tun_metadata19,
              :tun_metadata20,
              :tun_metadata21,
              :tun_metadata22,
              :tun_metadata23,
              :tun_metadata24,
              :tun_metadata25,
              :tun_metadata26,
              :tun_metadata27,
              :tun_metadata28,
              :tun_metadata29,
              :tun_metadata30,
              :tun_metadata31,
              :tun_metadata32,
              :tun_metadata33,
              :tun_metadata34,
              :tun_metadata35,
              :tun_metadata36,
              :tun_metadata37,
              :tun_metadata38,
              :tun_metadata39,
              :tun_metadata40,
              :tun_metadata41,
              :tun_metadata42,
              :tun_metadata43,
              :tun_metadata44,
              :tun_metadata45,
              :tun_metadata46,
              :tun_metadata47,
              :tun_metadata48,
              :tun_metadata49,
              :tun_metadata50,
              :tun_metadata51,
              :tun_metadata52,
              :tun_metadata53,
              :tun_metadata54,
              :tun_metadata55,
              :tun_metadata56,
              :tun_metadata57,
              :tun_metadata58,
              :tun_metadata59,
              :tun_metadata60,
              :tun_metadata61,
              :tun_metadata62,
              :tun_metadata63
            ],
       do: :arbitrary

  defp oxm_header__({class, exp}, field, has_mask, length),
    do: <<class::16, 0::7, has_mask::1, length + 6::8, exp::32, field::16>>

  defp oxm_header__(class, field, has_mask, length),
    do: <<class::16, field::7, has_mask::1, length::8>>

  defp oxm_header(class, field, length),
    do: oxm_header__(class, field, 0, length)

  defp oxm_header_w(class, field, length),
    do: oxm_header__(class, field, 1, length * 2)

  defp trim_heading_pad(v0, f) do
    case n_bits_of(f) do
      n_bits when bit_size(v0) < n_bits ->
        head_pad_len = n_bits - bit_size(v0)
        <<0::size(head_pad_len), v0::bytes>>

      n_bits when bit_size(v0) > n_bits ->
        head_pad_len = bit_size(v0) - n_bits
        <<_::size(head_pad_len), value::size(n_bits)-bits>> = v0
        value

      _ ->
        v0
    end
  end
end
