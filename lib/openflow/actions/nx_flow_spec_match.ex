defmodule Openflow.Action.NxFlowSpecMatch do
  defstruct(
    src: nil,
    dst: nil,
    n_bits:     0,
    src_offset: 0,
    dst_offset: 0
  )

  @learn_src_field     0
  @learn_src_immediate 1
  @learn_dst           0

  alias __MODULE__

  def new(options) do
    src = Keyword.get(options, :src)
    dst = Keyword.get(options, :dst)
    default_n_bits = Openflow.Match.Field.n_bits_of(dst)
    n_bits = Keyword.get(options, :n_bits, default_n_bits)
    src_ofs = Keyword.get(options, :src_offset, 0)
    dst_ofs = Keyword.get(options, :dst_offset, 0)
    %NxFlowSpecMatch{src: src,
                     dst: dst,
                     n_bits: n_bits,
                     src_offset: src_ofs,
                     dst_offset: dst_ofs}
  end

  def to_binary(%NxFlowSpecMatch{} = fsm) do
    %NxFlowSpecMatch{
      dst:        dst_field,
      n_bits:     n_bits,
      src_offset: src_ofs,
      dst_offset: dst_ofs
    } = fsm
    {src_code, src_bin} = codec_src(fsm)
    dst_bin = Openflow.Match.codec_header(dst_field)
    case src_code do
      @learn_src_immediate ->
        <<0::2, src_code::1, @learn_dst::2, n_bits::11,
          src_bin::bytes, dst_bin::4-bytes, dst_ofs::16>>
      @learn_src_field ->
        <<0::2, src_code::1, @learn_dst::2, n_bits::11,
          src_bin::bytes, src_ofs::16, dst_bin::4-bytes, dst_ofs::16>>
    end
  end

  def read(<<_::2, @learn_src_field::1, @learn_dst::2, n_bits::11, src_bin::4-bytes,
             src_ofs::16, dst_bin::4-bytes, dst_ofs::16, rest::bitstring>>) do
    src = Openflow.Match.codec_header(src_bin)
    dst = Openflow.Match.codec_header(dst_bin)
    flow_spec = %NxFlowSpecMatch{src: src,
                                 dst: dst,
                                 n_bits: n_bits,
                                 src_offset: src_ofs,
                                 dst_offset: dst_ofs}
    {flow_spec, rest}
  end
  def read(<<_::2, @learn_src_immediate::1, @learn_dst::2, n_bits::11, binary::bitstring>>) do
    rounded_up_len = Openflow.Utils.pad_length(n_bits, 8)
    rounded_up_nbits = n_bits + rounded_up_len
    <<src_bin::size(rounded_up_nbits)-bits, dst_bin::4-bytes, dst_ofs::16, rest::bitstring>> = binary
    dst = Openflow.Match.codec_header(dst_bin)
    src = Openflow.Match.Field.codec(src_bin, dst)
    flow_spec = %NxFlowSpecMatch{src: src,
                                 dst: dst,
                                 n_bits: n_bits,
                                 dst_offset: dst_ofs}
    {flow_spec, rest}
  end

  # private functions

  defp codec_src(%NxFlowSpecMatch{src: src_field}) when is_atom(src_field) do
    src_bin = Openflow.Match.codec_header(src_field)
    {@learn_src_field, src_bin}
  end
  defp codec_src(%NxFlowSpecMatch{src: src, dst: dst_field}) do
    src_bin = Openflow.Match.Field.codec(src, dst_field)
    {@learn_src_immediate, src_bin}
  end
end
