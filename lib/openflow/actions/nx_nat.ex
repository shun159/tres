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

  def new(options \\ []) do
    flags = Keyword.get(options, :flags, [])
    ipv4_min = Keyword.get(options, :ipv4_min)
    ipv4_max = Keyword.get(options, :ipv4_max)
    ipv6_min = Keyword.get(options, :ipv6_min)
    ipv6_max = Keyword.get(options, :ipv6_max)
    proto_min = Keyword.get(options, :proto_min)
    proto_max = Keyword.get(options, :proto_max)

    %NxNat{
      flags: flags,
      ipv4_min: ipv4_min,
      ipv4_max: ipv4_max,
      ipv6_min: ipv6_min,
      ipv6_max: ipv6_max,
      proto_min: proto_min,
      proto_max: proto_max
    }
  end

  def to_binary(%NxNat{flags: flags} = nat) do
    flags_int = Openflow.Enums.flags_to_int(flags, :nx_nat_flags)

    range_flags =
      nat
      |> get_ranges
      |> Openflow.Enums.flags_to_int(:nx_nat_range)
      |> Openflow.Enums.int_to_flags(:nx_nat_range)

    ranges_bin = encode_ranges("", range_flags, nat)
    range_flags_int = Openflow.Enums.flags_to_int(range_flags, :nx_nat_range)

    exp_body =
      <<@experimenter::32, @nxast::16, 0::size(2)-unit(8), flags_int::16, range_flags_int::16,
        ranges_bin::bytes>>

    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<0::size(2)-unit(8), flags_int::16, range_flags_int::16, ranges_bin::bytes>> = body
    flags = Openflow.Enums.int_to_flags(flags_int, :nx_nat_flags)
    range_flags = Openflow.Enums.int_to_flags(range_flags_int, :nx_nat_range)
    decode_ranges(%NxNat{flags: flags}, range_flags, ranges_bin)
  end

  # private functions

  defp get_ranges(nat) do
    nat
    |> Map.from_struct()
    |> Map.delete(:flags)
    |> Enum.map(fn {k, v} -> if(not is_nil(v), do: k, else: nil) end)
    |> Enum.filter(fn v -> not is_nil(v) end)
  end

  defp encode_ranges(acc, [], _nat), do: acc

  defp encode_ranges(acc, [range | rest], nat) do
    cond do
      range == :ipv4_min or range == :ipv4_max ->
        case Map.get(nat, range) do
          {a1, a2, a3, a4} ->
            encode_ranges(<<acc::bytes, a1, a2, a3, a4>>, rest, nat)

          "" ->
            encode_ranges(<<acc::bytes>>, rest, nat)
        end

      range == :ipv6_min or range == :ipv6_max ->
        case Map.get(nat, range) do
          {a1, a2, a3, a4, a5, a6, a7, a8} ->
            encode_ranges(
              <<acc::bytes, a1::16, a2::16, a3::16, a4::16, a5::16, a6::16, a7::16, a8::16>>,
              rest,
              nat
            )

          "" ->
            encode_ranges(<<acc::bytes>>, rest, nat)
        end

      range == :proto_min or range == :proto_max ->
        case Map.get(nat, range) do
          proto when is_integer(proto) and proto in 1..0xFFFF ->
            encode_ranges(<<acc::bytes, proto::16>>, rest, nat)

          _ ->
            encode_ranges(<<acc::bytes>>, rest, nat)
        end
    end
  end

  defp decode_ranges(nat, [], _), do: nat

  defp decode_ranges(nat, [range | ranges], bin) do
    cond do
      range == :ipv4_min or range == :ipv4_max ->
        case bin do
          <<a1, a2, a3, a4, rest::bytes>> ->
            decode_ranges(struct(nat, %{range => {a1, a2, a3, a4}}), ranges, rest)

          rest ->
            decode_ranges(struct(nat, %{range => ""}), ranges, rest)
        end

      range == :ipv6_min or range == :ipv6_max ->
        case bin do
          <<a1::16, a2::16, a3::16, a4::16, a5::16, a6::16, a7::16, a8::16, rest::bytes>> ->
            decode_ranges(struct(nat, %{range => {a1, a2, a3, a4, a5, a6, a7, a8}}), ranges, rest)

          rest ->
            decode_ranges(struct(nat, %{range => ""}), ranges, rest)
        end

      range == :proto_min or range == :proto_max ->
        case bin do
          <<proto::16, rest::bytes>> when proto in 1..0xFFFF ->
            decode_ranges(struct(nat, %{range => proto}), ranges, rest)

          rest ->
            decode_ranges(struct(nat, %{range => ""}), ranges, rest)
        end
    end
  end
end
