defmodule Openflow.Action.NxFlowSpecOutput do
  defstruct(
    n_bits: 0,
    src: nil,
    src_offset: 0
  )

  @learn_src_field 0
  @learn_dst 2

  alias __MODULE__

  @type t :: %NxFlowSpecOutput{
          n_bits: non_neg_integer(),
          src: atom(),
          src_offset: non_neg_integer()
        }

  @spec new(src: atom(), n_bits: non_neg_integer(), src_offset: non_neg_integer()) :: t()
  def new(options \\ []) do
    src = options[:src] || raise ":src must be specified"
    n_bits = options[:n_bits] || Openflow.Match.Field.n_bits_of(src)
    %NxFlowSpecOutput{n_bits: n_bits, src: src, src_offset: options[:src_offset] || 0}
  end

  @spec to_binary(t()) :: binary()
  def to_binary(%NxFlowSpecOutput{} = flow_spec) do
    <<
      0::2,
      @learn_src_field::1,
      @learn_dst::2,
      flow_spec.n_bits::11,
      Openflow.Match.codec_header(flow_spec.src)::4-bytes,
      flow_spec.src_offset::16
    >>
  end

  @spec read(binary()) :: {t(), binary()}
  def read(
        <<0::2, @learn_src_field::1, @learn_dst::2, n_bits::11, src_bin::4-bytes, src_ofs::16,
          rest::bitstring>>
      ) do
    flow_spec = %NxFlowSpecOutput{
      n_bits: n_bits,
      src: Openflow.Match.codec_header(src_bin),
      src_offset: src_ofs
    }

    {flow_spec, rest}
  end
end
