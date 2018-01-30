defmodule Openflow.MeterBand do
  def read(meter_band_bin) do
    do_read([], meter_band_bin)
  end

  def to_binary(meter_bands) when is_list(meter_bands) do
    to_binary(<<>>, meter_bands)
  end

  def to_binary(meter_band) do
    to_binary([meter_band])
  end

  # private functions

  defp do_read(acc, <<>>), do: Enum.reverse(acc)

  defp do_read(acc, <<type::16, length::16, _::bytes>> = binary) do
    <<meter_band_bin::size(length)-bytes, rest::bytes>> = binary
    codec = Openflow.Enums.to_atom(type, :meter_band_type)
    do_read([codec.read(meter_band_bin) | acc], rest)
  end

  defp to_binary(acc, []), do: acc

  defp to_binary(acc, [meter_band | rest]) do
    codec = meter_band.__struct__
    to_binary(<<acc::bytes, codec.to_binary(meter_band)::bytes>>, rest)
  end
end
