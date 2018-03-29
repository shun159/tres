defmodule Openflow.Action.NxRegLoad do
  import Bitwise

  defstruct(
    n_bits: 0,
    offset: 0,
    dst_field: nil,
    value: nil
  )

  @experimenter 0x00002320
  @nxast 7

  alias __MODULE__

  def new(options) do
    dst_field = Keyword.get(options, :dst_field)
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)
    n_bits = Keyword.get(options, :n_bits, default_n_bits)
    ofs = Keyword.get(options, :offset, 0)
    value = Keyword.get(options, :value)
    %NxRegLoad{n_bits: n_bits, offset: ofs, dst_field: dst_field, value: value}
  end

  def to_binary(%NxRegLoad{n_bits: n_bits, offset: ofs, dst_field: dst_field, value: value}) do
    dst_field_bin = Openflow.Match.codec_header(dst_field)
    value_bin0 = Openflow.Match.Field.codec(value, dst_field)
    tmp_value = :binary.decode_unsigned(value_bin0, :big)
    value_bin = <<tmp_value::64>>
    ofs_nbits = ofs <<< 6 ||| n_bits - 1
    body = <<ofs_nbits::16, dst_field_bin::4-bytes, value_bin::bytes>>
    exp_body = <<@experimenter::32, @nxast::16, body::bytes>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<ofs::10, n_bits::6, dst_field_bin::4-bytes, value_bin::bytes>> = body
    dst_field = Openflow.Match.codec_header(dst_field_bin)
    value = Openflow.Match.Field.codec(value_bin, dst_field)
    %NxRegLoad{n_bits: n_bits + 1, offset: ofs, dst_field: dst_field, value: value}
  end
end
