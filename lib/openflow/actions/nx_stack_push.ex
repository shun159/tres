defmodule Openflow.Action.NxStackPush do
  defstruct(
    n_bits:   0,
    offset:   0,
    field:  nil
  )

  @experimenter 0x00002320
  @nxast 27

  alias __MODULE__

  def new(options) do
    field = Keyword.get(options, :field)
    default_n_bits = Openflow.Match.Field.n_bits_of(field)
    n_bits = Keyword.get(options, :n_bits, default_n_bits)
    ofs = Keyword.get(options, :offset, 0)
    %NxStackPush{n_bits: n_bits, offset: ofs, field: field}
  end

  def to_binary(%NxStackPush{n_bits: n_bits, offset: ofs, field: field}) do
    field_bin = Openflow.Match.codec_header(field)
    exp_body = <<@experimenter::32, @nxast::16, ofs::16,
      field_bin::4-bytes, n_bits::16, 0::size(6)-unit(8)>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, ofs::16,
             field_bin::4-bytes, n_bits::16, _::size(6)-unit(8)>>) do
    field = Openflow.Match.codec_header(field_bin)
    %NxStackPush{n_bits: n_bits, offset: ofs, field: field}
  end
end
