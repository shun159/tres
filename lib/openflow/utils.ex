defmodule Openflow.Utils do
  import Bitwise

  def int_to_flags(acc, int, [{type, flagint}|rest]) when (int &&& flagint) == flagint do
    int_to_flags([type|acc], int, rest)
  end
  def int_to_flags(acc, int, [_h|rest]) do
    int_to_flags(acc, int, rest)
  end
  def int_to_flags(acc, _int, []), do: Enum.reverse(acc)

  def flags_to_int(acc, [], _enum), do: acc
  def flags_to_int(acc0, [flag|rest], enum) do
    acc = acc0 ||| Keyword.get(enum, flag, 0)
    flags_to_int(acc, rest, enum)
  end

  def to_hex_string(binary), do: datapath_id(binary)

  def padding(length, padding) do
    case (padding - rem(length, padding)) do
      ^padding -> 0
      pad_len  -> pad_len
    end
  end

  def pad_length(length, width) do
    rem((width - rem(length, width)), width)
  end

  def decode_string(binary) do
    String.trim_trailing(binary, <<0>>)
  end

  def encode_string(binary, length) do
    String.pad_trailing(binary, length, <<0>>)
  end

  def get_enum(int, type) when is_integer(int) do
    try do
      Openflow.Enums.to_atom(int, type)
    catch
      :bad_enum -> int
    end
  end
  def get_enum(int, type) do
    try do
      Openflow.Enums.to_int(int, type)
    catch
      :bad_enum -> int
    end
  end

  # private functions

  defp datapath_id(binary) do
    binary
    |> split_to_hex_string
    |> Enum.join("")
    |> String.downcase
  end

  defp split_to_hex_string(binary) do
    for <<int <- binary>>, do: integer_to_hex(int)
  end

  defp integer_to_hex(int) do
    case Integer.to_string(int, 16) do
      <<d>> -> <<48, d>>
      dd    -> dd
    end
  end
end
