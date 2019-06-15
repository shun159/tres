defmodule Openflow.Action.NxRegMove do
  @moduledoc """
  Copies src[src_ofs:src_ofs+n_bits] to dst[dst_ofs:dst_ofs+n_bits], where
  a[b:c] denotes the bits within 'a' numbered 'b' through 'c' (not including
  bit 'c').  Bit numbering starts at 0 for the least-significant bit, 1 for
  the next most significant bit, and so on.

  The following nxm_header values are potentially acceptable as 'src':
    - `:in_port`
    - `:eth_dst`
    - `:eth_src`
    - `:eth_type`
    - `:vlan_tci`
    - `:ip_tos`
    - `:ip_proto`
    - `:ip_src`
    - `:ip_dst`
    - `:tcp_src`
    - `:tcp_dst`
    - `:udp_src`
    - `:udp_dst`
    - `:icmp_type`
    - `:icmp_code`
    - `:arp_op`
    - `:arp_spa`
    - `:arp_tpa`
    - `:tun_id`
    - `:arp_sha`
    - `:arp_tha`
    - `:icmpv6_type`
    - `:icmpv6_code`
    - `:nd_sll`
    - `:nd_tll`
    - `:reg(idx)` for idx in the switch's accepted range.
    - `:pkt_mark`
    - `:tun_ipv4_src`
    - `:tun_ipv4_dst`

  The following nxm_header values are potentially acceptable as 'dst':
    - `:eth_dst`
    - `:eth_src`
    - `:ip_tos`
    - `:ip_src`
    - `:ip_dst`
    - `:tcp_src`
    - `:tcp_dst`
    - `:udp_src`
    - `:udp_dst`
    - `:icmp_type`
    - `:icmp_code`
    - `:icmpv6_type`
    - `:icmpv6_code`
    - `:arp_sha`
    - `:arp_tha`
    - `:arp_op`
    - `:arp_spa`
    - `:arp_tpa`

    Modifying any of the above fields changes the corresponding packet header.

    - `:in_port`

    - `:reg(idx)` for idx in the switch's accepted range.

    - `:pkt_mark`

    - `:vlan_tci`.  Modifying this field's value has side effects on the
      packet's 802.1Q header.  Setting a value with CFI=0 removes the 802.1Q
      header (if any), ignoring the other bits.  Setting a value with CFI=1
      adds or modifies the 802.1Q header appropriately, setting the TCI field
      to the field's new value (with the CFI bit masked out).

    - `:tun_id`, `:tun_ipv4_src`, `:tun_ipv4_dst`.  Modifying
      any of these values modifies the corresponding tunnel header field used
      for the packet's next tunnel encapsulation, if allowed by the
      configuration of the output tunnel port.

  A given nxm_header value may be used as 'src' or 'dst' only on a flow whose
  nx_match satisfies its prerequisites.  For example, NXM_OF_IP_TOS may be
  used only if the flow's nx_match includes an nxm_entry that specifies
  nxm_type=NXM_OF_ETH_TYPE, nxm_hasmask=0, and nxm_value=0x0800.

  The switch will reject actions for which src_ofs+n_bits is greater than the
  width of 'src' or dst_ofs+n_bits is greater than the width of 'dst' with
  error type OFPET_BAD_ACTION, code OFPBAC_BAD_ARGUMENT.

  This action behaves properly when 'src' overlaps with 'dst', that is, it
  behaves as if 'src' were copied out to a temporary buffer, then the
  temporary buffer copied to 'dst'.
  """

  defstruct(
    n_bits: 0,
    src_offset: 0,
    dst_offset: 0,
    src_field: nil,
    dst_field: nil
  )

  @experimenter 0x00002320
  @nxast 6

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @type t :: %NxRegMove{
          n_bits: 0..0xFFFF,
          src_offset: 0..0xFFFF,
          dst_offset: 0..0xFFFF,
          src_field: atom(),
          dst_field: atom()
        }

  @doc """
  Creates a new reg_move action struct

  ## Options:
  - n_bits: Number of bits
  - src_offset: Starting bit offset in source
  - dst_offset: Starting bit offset in destination
  - src_field: oxm/nxm field name for source field
  - dst_field: oxm/nxm field name for destination field

  ## Example

  ```elixir
  # 1. move:NXM_OF_IN_PORT[]->NXM_OF_VLAN_TCI[]
  iex> NxRegMove.new(src_field: :nx_in_port, :nx_vlan_tci)

  # 2. move:NXM_NX_TUN_ID[40..57]->NXM_NX_REG1[0..17]
  iex> NxRegMove.new(
  iex>   src_field: :tun_id,
  iex>   src_offset: 40,
  iex>   dst_field: :reg1
  iex>   dst_offset: 0,
  iex>   n_bits: 18
  iex> )
  ```
  """
  @spec new(
          n_bits: 0..0xFFFF,
          src_offset: 0..0xFFFF,
          dst_offset: 0..0xFFFF,
          src_field: atom(),
          dst_field: atom()
        ) :: t()
  def new(options \\ []) do
    src_field = options[:src_field] || raise "src_field must be specified"
    dst_field = options[:dst_field] || raise "dst_field must be specified"
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)

    %NxRegMove{
      n_bits: options[:n_bits] || default_n_bits,
      src_offset: options[:src_offset] || 0,
      dst_offset: options[:dst_offset] || 0,
      src_field: src_field,
      dst_field: dst_field
    }
  end

  @spec to_binary(t()) :: binary()
  def to_binary(%NxRegMove{} = move) do
    src_field_bin = Openflow.Match.codec_header(move.src_field)
    dst_field_bin = Openflow.Match.codec_header(move.dst_field)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      move.n_bits::16,
      move.src_offset::16,
      move.dst_offset::16,
      src_field_bin::4-bytes,
      dst_field_bin::4-bytes
    >>)
  end

  @spec read(binary()) :: t()
  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<n_bits::16, src_ofs::16, dst_ofs::16, src_field_bin::4-bytes, dst_field_bin::4-bytes>> =
      body

    src_field = Openflow.Match.codec_header(src_field_bin)
    dst_field = Openflow.Match.codec_header(dst_field_bin)

    %NxRegMove{
      n_bits: n_bits,
      src_offset: src_ofs,
      dst_offset: dst_ofs,
      src_field: src_field,
      dst_field: dst_field
    }
  end
end
