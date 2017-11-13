defmodule Openflow.Action.NxFlowSpecOutput do
  defstruct(
    n_bits: 0,
    src: nil,
    src_offset: 0
  )

  @learn_src_field     0
  @learn_dst           2

  alias __MODULE__

  def new(options) do
    src = Keyword.get(options, :src)
    src_ofs = Keyword.get(options, :src_offset, 0)
    default_n_bits = Openflow.Match.Field.n_bits_of(src)
    n_bits = Keyword.get(options, :n_bits, default_n_bits)
    %NxFlowSpecOutput{n_bits: n_bits,
                      src: src,
                      src_offset: src_ofs}
  end

  def to_binary(%NxFlowSpecOutput{n_bits: n_bits,
                                  src: src,
                                  src_offset: src_ofs}) do
    src_bin = Openflow.Match.codec_header(src)
    <<0::2, @learn_src_field::1, @learn_dst::2, n_bits::11, src_bin::4-bytes, src_ofs::16>>
  end

  def read(<<0::2, @learn_src_field::1, @learn_dst::2,
             n_bits::11, src_bin::4-bytes, src_ofs::16, rest::bitstring>>) do
    src = Openflow.Match.codec_header(src_bin)
    flow_spec = %NxFlowSpecOutput{n_bits: n_bits,
                                  src: src,
                                  src_offset: src_ofs}
    {flow_spec, rest}
  end
end
