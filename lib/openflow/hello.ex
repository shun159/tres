defmodule Openflow.Hello do
  @moduledoc "OpenFlow Hello codec module"

  import Bitwise

  @ofp_hello_size 4

  defstruct(version: 4, xid: 0, elements: [])

  alias __MODULE__

  def ofp_type, do: 0

  def new(version) when is_integer(version) do
    %Hello{elements: [versionbitmap: [version]]}
  end

  def new(versions) when is_list(versions) do
    %Hello{elements: [versionbitmap: versions]}
  end

  def supported_version?(%Hello{version: 4, elements: []}), do: true
  def supported_version?(%Hello{elements: []}), do: false

  def supported_version?(%Hello{elements: elements}) do
    versionbitmaps = for {:versionbitmap, versions} <- elements, do: versions
    Enum.any?(versionbitmaps, fn versions -> 4 in versions end)
  end

  def read(binary), do: %Hello{elements: decode([], binary)}

  def to_binary(%Hello{elements: elements}), do: encode([], elements)

  # private functions

  defp decode(acc, <<>>), do: acc

  defp decode(acc, <<typeint::16, length::16, rest::bytes>>) do
    data_len = length - @ofp_hello_size
    <<data::bytes-size(data_len), rest2::bytes>> = rest

    try do
      typeint
      |> Openflow.Enums.to_atom(:hello_elem)
      |> decode_hello_elem(acc, data)
      |> decode(rest2)
    catch
      :bad_enum ->
        decode(acc, rest2)
    end
  end

  defp encode(acc, []), do: to_string(acc)
  defp encode(acc, [h | rest]), do: encode([encode_hello_elem(h) | acc], rest)

  defp decode_hello_elem(:versionbitmap, acc, binary),
    do: [{:versionbitmap, decode_bitmap([], binary, 0)} | acc]

  defp decode_hello_elem(_, acc, _binary), do: acc

  defp encode_hello_elem({:versionbitmap, versions}) do
    bitmap_bin = encode_bitmap(versions)
    type_int = Openflow.Enums.to_int(:versionbitmap, :hello_elem)
    size_int = @ofp_hello_size + byte_size(bitmap_bin)
    <<type_int::16, size_int::16, bitmap_bin::bytes>>
  end

  defp encode_hello_elem(_) do
    <<>>
  end

  defp decode_bitmap(acc, "", _), do: acc

  defp decode_bitmap(acc, <<int::32, rest::bytes>>, base) do
    acc
    |> decode_bitmap(int, 0, base)
    |> decode_bitmap(rest, base + 32)
  end

  defp encode_bitmap(list) do
    size =
      list
      |> Enum.max()
      |> div(32)

    encode_bitmap(0, list, size)
  end

  defp decode_bitmap(acc, _, index, _) when index >= 32, do: acc

  defp decode_bitmap(acc, int, index, base) when (int &&& 1 <<< index) == 0,
    do: decode_bitmap(acc, int, index + 1, base)

  defp decode_bitmap(acc, int, index, base),
    do: decode_bitmap([base + index | acc], int, index + 1, base)

  defp encode_bitmap(acc, [], size) do
    bytes = (size + 1) * 32
    <<acc::size(bytes)>>
  end

  defp encode_bitmap(acc, [h | rest], size) do
    index = size - div(h, 32) * 32 + rem(h, 32)
    encode_bitmap(acc ||| 1 <<< index, rest, size)
  end
end
