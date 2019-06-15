defmodule Openflow.Action.NxRegLoad2 do
  defstruct(field: nil)

  @experimenter 0x00002320
  @nxast 33

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new([{_field, _value}] = field) do
    %NxRegLoad2{field: field}
  end

  def to_binary(%NxRegLoad2{field: field}) do
    match_bin =
      field
      |> Openflow.Match.new()
      |> Openflow.Match.to_binary()

    <<1::16, length::16, padded_field::bytes>> = match_bin
    field_len = length - 4
    <<field_bin::size(field_len)-bytes, _::bytes>> = padded_field

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      field_bin::bytes
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, match_field_bin::bytes>>) do
    <<_class::16, _field::7, _hm::1, flen::8, _rest::bytes>> = match_field_bin
    match_len = 4 + 4 + flen
    match_bin = <<1::16, match_len::16, match_field_bin::bytes>>
    {[field | _], _rest} = Openflow.Match.read(match_bin)
    %NxRegLoad2{field: [field]}
  end
end
