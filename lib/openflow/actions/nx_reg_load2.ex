defmodule Openflow.Action.NxRegLoad2 do
  defstruct(
    dst_field:  nil,
    value:      nil
  )

  @experimenter 0x00002320
  @nxast 33

  alias __MODULE__

  def new(options) do
    dst_field = Keyword.get(options, :dst_field)
    value = Keyword.get(options, :value)
    %NxRegLoad2{dst_field: dst_field, value: value}
  end

  def to_binary(%NxRegLoad2{dst_field: dst_field, value: value}) do
    match_bin =
      [{dst_field, value}]
      |> Openflow.Match.new
      |> Openflow.Match.to_binary
    <<1::16, _length::16, padded_field::bytes>> = match_bin
    patial_len = 4 + 4 + 2 + 6 + byte_size(padded_field)
    padding = Openflow.Utils.padding(patial_len, 8)
    exp_body = <<@experimenter::32, @nxast::16, 0::48, padded_field::bytes, 0::size(padding)-unit(8)>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, _::48, match_field_bin::bytes>>) do
    <<_class::16, _field::7, _hm::1, flen::8, _rest::bytes>> = match_field_bin
    match_len = 4 + 4 + flen
    match_bin = <<1::16, match_len::16, match_field_bin::bytes, 0::size(4)-unit(8)>>
    {[{dst_field, value}|_], _rest} = Openflow.Match.read(match_bin)
    %NxRegLoad2{dst_field: dst_field, value: value}
  end
end
