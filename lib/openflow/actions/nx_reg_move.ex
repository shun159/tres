defmodule Openflow.Action.NxRegMove do
  defstruct(
    n_bits:     0,
    src_offset: 0,
    dst_offset: 0,
    src_field:  nil,
    dst_field:  nil
  )

  @experimenter 0x00002320
  @nxast 6

  alias __MODULE__

  def new(options) do
    src_field = Keyword.get(options, :src_field)
    dst_field = Keyword.get(options, :dst_field)
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)
    n_bits = Keyword.get(options, :n_bits, default_n_bits)
    src_ofs = Keyword.get(options, :src_offset, 0)
    dst_ofs = Keyword.get(options, :dst_offset, 0)
    %NxRegMove{n_bits: n_bits,
               src_offset: src_ofs,
               dst_offset: dst_ofs,
               src_field: src_field,
               dst_field: dst_field}
  end

  def to_binary(%NxRegMove{n_bits: n_bits,
                           src_offset: src_ofs,
                           dst_offset: dst_ofs,
                           src_field: src_field,
                           dst_field: dst_field}) do
    src_field_bin = Openflow.Match.codec_header(src_field)
    dst_field_bin = Openflow.Match.codec_header(dst_field)
    body = <<n_bits::16, src_ofs::16, dst_ofs::16,
             src_field_bin::4-bytes, dst_field_bin::4-bytes>>
    exp_body = <<@experimenter::32, @nxast::16, body::bytes>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<n_bits::16, src_ofs::16, dst_ofs::16,
      src_field_bin::4-bytes, dst_field_bin::4-bytes>> = body
    src_field = Openflow.Match.codec_header(src_field_bin)
    dst_field = Openflow.Match.codec_header(dst_field_bin)
    %NxRegMove{n_bits: n_bits,
               src_offset: src_ofs,
               dst_offset: dst_ofs,
               src_field: src_field,
               dst_field: dst_field}
  end
end
