defmodule Openflow.Action.SetField do
  @moduledoc """
  Set a header field using OXM TLV format.
  """

  defstruct(field: nil)

  alias __MODULE__

  @type t :: %SetField{field: Keyword.t()}

  @set_field_size 8

  def ofpat, do: 25

  @doc """
  Create a new set_field action struct

  note: The following oxm(nxm)_header values are potentially acceptable as `field`:

  - :tun_id
  - :tun_ipv4_src
  - :tun_ipv4_dst
  - :tun_ipv6_src
  - :tun_ipv6_dst
  - :tun_flags
  - :tun_gbp_id
  - :tun_gbp_flags
  - :tun_metadata{0..63}
  - :in_port
  - :pkt_mark
  - :ct_mark
  - :ct_label
  - :reg{0..15}
  - :xreg{0..8}
  - :xxreg{0..4}
  - :eth_src
  - :eth_dst
  - :vlan_tci
  - :mpls_ttl
  - :ip_src
  - :ip_dst
  - :ipv6_src
  - :ipv6_dst
  - :ipv6_label
  - :ip_tos
  - :ip_ecn
  - :ip_ttl
  - :arp_op
  - :arp_spa
  - :arp_tpa
  - :arp_sha
  - :arp_tha
  - :tcp_src
  - :tcp_dst
  - :udp_src
  - :udp_dst
  - :icmp_type
  - :icmp_code
  - :icmpv6_type
  - :icmpv6_code
  - :nd_target
  - :nd_sll
  - :nd_tll
  - :metadata

  ```elixir
  iex> %SetField{field: [reg1: 10]} = SetField.new(reg1: 10)
  ```
  """
  @spec new(Keyword.t()) :: t()
  def new([{_field, _value}] = oxm_field) do
    %SetField{field: oxm_field}
  end

  def to_binary(%SetField{field: field}) do
    match_bin =
      field
      |> Openflow.Match.new()
      |> Openflow.Match.to_binary()

    <<1::16, _length::16, padded_field::bytes>> = match_bin
    patial_len = @set_field_size - 4 + byte_size(padded_field)
    padding = Openflow.Utils.padding(patial_len, 8)
    length = patial_len + padding
    <<25::16, length::16, padded_field::bytes, 0::size(padding)-unit(8)>>
  end

  def read(<<25::16, _length::16, match_field_bin::bytes>>) do
    <<_class::16, _field::7, _hm::1, flen::8, _rest::bytes>> = match_field_bin
    match_len = 4 + 4 + flen
    match_bin = <<1::16, match_len::16, match_field_bin::bytes>>
    {[field | _], _rest} = Openflow.Match.read(match_bin)
    %SetField{field: [field]}
  end
end
