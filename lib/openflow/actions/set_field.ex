defmodule Openflow.Action.SetField do
  defstruct(field: nil)

  alias __MODULE__

  @set_field_size 8

  def ofpat, do: 25

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
