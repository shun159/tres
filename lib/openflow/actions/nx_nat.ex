defmodule Openflow.Action.NxNat do
  defstruct(
    flags: [],
    ipv4_min: nil,
    ipv4_max: nil,
    ipv6_min: nil,
    ipv6_max: nil,
    proto_min: nil,
    proto_max: nil
  )

  @experimenter 0x00002320
  @nxast 36

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @type in_addr :: :inet.ip4_address()
  @type in6_addr :: :inet.ip6_address()
  @type port_number :: :inet.port_number()
  @type flag :: :src | :dst | :persistent | :protocol_hash | :protocol_random
  @type nat_range :: :ipv4_min | :ipv4_max | :ipv6_min | :ipv6_max | :proto_min | :proto_max
  @type t :: %NxNat{
          flags: [flag()],
          ipv4_min: in_addr(),
          ipv4_max: in_addr(),
          ipv6_min: in6_addr(),
          ipv6_max: in6_addr(),
          proto_min: port_number(),
          proto_max: port_number()
        }

  @spec new(
          flags: [flag()],
          ipv4_min: in_addr(),
          ipv4_max: in_addr(),
          ipv6_min: in6_addr(),
          ipv6_max: in6_addr(),
          proto_min: port_number(),
          proto_max: port_number()
        ) :: t()
  def new(options \\ []) do
    %NxNat{
      flags: options[:flags] || [],
      ipv4_min: options[:ipv4_min],
      ipv4_max: options[:ipv4_max],
      ipv6_min: options[:ipv6_min],
      ipv6_max: options[:ipv6_max],
      proto_min: options[:proto_min],
      proto_max: options[:proto_max]
    }
  end

  @spec to_binary(t()) :: binary()
  def to_binary(%NxNat{flags: flags} = nat) do
    flags_int = Openflow.Enums.flags_to_int(flags, :nx_nat_flags)
    range_flags = get_range_flags(nat)
    ranges_bin = encode_ranges("", range_flags, nat)
    range_flags_int = Openflow.Enums.flags_to_int(range_flags, :nx_nat_range)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      0::size(2)-unit(8),
      flags_int::16,
      range_flags_int::16,
      ranges_bin::bytes
    >>)
  end

  @spec read(binary()) :: t()
  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<0::size(2)-unit(8), flags_int::16, range_flags_int::16, ranges_bin::bytes>> = body
    flags = Openflow.Enums.int_to_flags(flags_int, :nx_nat_flags)
    range_flags = Openflow.Enums.int_to_flags(range_flags_int, :nx_nat_range)
    decode_ranges(%NxNat{flags: flags}, range_flags, ranges_bin)
  end

  # private functions

  @range_keys [:ipv4_min, :ipv4_max, :ipv6_min, :ipv6_max, :proto_min, :proto_max]

  @spec get_range_flags(t()) :: [nat_range()]
  defp get_range_flags(nat) do
    @range_keys
    |> Enum.reduce([], fn
      key, acc when key in @range_keys ->
        if not is_nil(Map.get(nat, key)), do: [key | acc], else: acc
    end)
    |> Enum.reverse()
  end

  @spec encode_ranges(binary(), [nat_range()], t()) :: binary()
  defp encode_ranges(acc, [], _nat), do: acc

  defp encode_ranges(acc, [:ipv4_min | rest], %NxNat{ipv4_min: {a1, a2, a3, a4}} = nat) do
    encode_ranges(<<acc::bytes, a1, a2, a3, a4>>, rest, nat)
  end

  defp encode_ranges(acc, [:ipv4_max | rest], %NxNat{ipv4_max: {a1, a2, a3, a4}} = nat) do
    encode_ranges(<<acc::bytes, a1, a2, a3, a4>>, rest, nat)
  end

  defp encode_ranges(
         acc,
         [:ipv6_min | rest],
         %NxNat{ipv6_min: {a1, a2, a3, a4, a5, a6, a7, a8}} = nat
       ) do
    encode_ranges(
      <<acc::bytes, a1::16, a2::16, a3::16, a4::16, a5::16, a6::16, a7::16, a8::16>>,
      rest,
      nat
    )
  end

  defp encode_ranges(
         acc,
         [:ipv6_max | rest],
         %NxNat{ipv6_max: {a1, a2, a3, a4, a5, a6, a7, a8}} = nat
       ) do
    encode_ranges(
      <<acc::bytes, a1::16, a2::16, a3::16, a4::16, a5::16, a6::16, a7::16, a8::16>>,
      rest,
      nat
    )
  end

  defp encode_ranges(acc, [:proto_min | rest], %NxNat{proto_min: proto} = nat)
       when is_integer(proto) do
    encode_ranges(<<acc::bytes, proto::16>>, rest, nat)
  end

  defp encode_ranges(acc, [:proto_max | rest], %NxNat{proto_max: proto} = nat)
       when is_integer(proto) do
    encode_ranges(<<acc::bytes, proto::16>>, rest, nat)
  end

  @spec decode_ranges(t(), [nat_range()], binary()) :: t()
  defp decode_ranges(nat, [], _), do: nat

  defp decode_ranges(acc, [:ipv4_min | rest], <<a1, a2, a3, a4, binary::bytes>>) do
    decode_ranges(%{acc | ipv4_min: {a1, a2, a3, a4}}, rest, binary)
  end

  defp decode_ranges(acc, [:ipv4_max | rest], <<a1, a2, a3, a4, binary::bytes>>) do
    decode_ranges(%{acc | ipv4_max: {a1, a2, a3, a4}}, rest, binary)
  end

  defp decode_ranges(
         acc,
         [:ipv6_min | rest],
         <<a1::16, a2::16, a3::16, a4::16, a5::16, a6::16, a7::16, a8::16, binary::bytes>>
       ) do
    decode_ranges(%{acc | ipv6_min: {a1, a2, a3, a4, a5, a6, a7, a8}}, rest, binary)
  end

  defp decode_ranges(
         acc,
         [:ipv6_max | rest],
         <<a1::16, a2::16, a3::16, a4::16, a5::16, a6::16, a7::16, a8::16, binary::bytes>>
       ) do
    decode_ranges(%{acc | ipv6_max: {a1, a2, a3, a4, a5, a6, a7, a8}}, rest, binary)
  end

  defp decode_ranges(acc, [:proto_min | rest], <<proto::16, binary::bytes>>) do
    decode_ranges(%{acc | proto_min: proto}, rest, binary)
  end

  defp decode_ranges(acc, [:proto_max | rest], <<proto::16, binary::bytes>>) do
    decode_ranges(%{acc | proto_max: proto}, rest, binary)
  end
end
