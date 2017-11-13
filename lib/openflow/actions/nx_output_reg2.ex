defmodule Openflow.Action.NxOutputReg2 do
  import Bitwise

  defstruct(
    n_bits:     0,
    offset:     0,
    src_field:  nil,
    max_len:    :no_buffer
  )

  @experimenter 0x00002320
  @nxast 32

  alias __MODULE__

  def new(options) do
    src_field = Keyword.get(options, :src_field)
    default_n_bits = Openflow.Match.Field.n_bits_of(src_field)
    n_bits = Keyword.get(options, :n_bits, default_n_bits)
    ofs = Keyword.get(options, :offset, 0)
    max_len = Keyword.get(options, :max_len, :no_buffer)
    %NxOutputReg2{n_bits: n_bits, offset: ofs, src_field: src_field, max_len: max_len}
  end

  def to_binary(%NxOutputReg2{n_bits: n_bits, offset: ofs, src_field: src_field, max_len: max_len}) do
    src_field_bin = Openflow.Match.codec_header(src_field)
    ofs_nbits = (ofs <<< 6) ||| (n_bits - 1)
    max_len = Openflow.Utils.get_enum(max_len, :controller_max_len)
    padding = Openflow.Utils.padding(byte_size(src_field_bin), 10)
    body = <<ofs_nbits::16, max_len::16, src_field_bin::bytes, 0::size(padding)-unit(8)>>
    exp_body = <<@experimenter::32, @nxast::16, body::bytes>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<ofs::10, n_bits::6, max_len::16, oxm_header::4-bytes, rest::bitstring>> = body
    exp_size = match_header_size(oxm_header) - 4
    <<experimenter_int::size(exp_size)-unit(8), _padding::bytes>> = rest
    src_field = Openflow.Match.codec_header(<<oxm_header::bytes, experimenter_int::size(exp_size)-unit(8)>>)
    max_len = Openflow.Utils.get_enum(max_len, :controller_max_len)
    %NxOutputReg2{n_bits: n_bits + 1, offset: ofs, src_field: src_field, max_len: max_len}
  end

  # private functions

  defp match_header_size(<<0xffff::16, _::bytes>>), do: 8
  defp match_header_size(<<_::16, _::bytes>>),      do: 4
end
