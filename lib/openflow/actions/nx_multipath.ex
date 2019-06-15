defmodule Openflow.Action.NxMultipath do
  import Bitwise

  defstruct(
    hash_field: :eth_src,
    basis: 0,
    algorithm: :modulo_n,
    max_link: 0,
    argument: 0,
    offset: 0,
    n_bits: 0,
    dst_field: nil
  )

  @experimenter 0x00002320
  @nxast 10

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @spec new(Keyword.t()) :: %NxMultipath{}
  def new(options) do
    dst_field = options[:dst_field] || raise "dst_field must be specified"
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)

    %NxMultipath{
      hash_field: options[:hash_field] || :eth_src,
      basis: options[:basis] || 0,
      algorithm: options[:algorithm] || :modulo_n,
      max_link: options[:max_link] || 0,
      offset: options[:offset] || 0,
      n_bits: options[:n_bits] || default_n_bits,
      argument: options[:argument] || 0,
      dst_field: dst_field
    }
  end

  def to_binary(%NxMultipath{} = multipath) do
    hash_field_int = Openflow.Enums.to_int(multipath.hash_field, :nx_hash_fields)
    alg_int = Openflow.Enums.to_int(multipath.algorithm, :nx_mp_algorithm)
    dst_field_bin = Openflow.Match.codec_header(multipath.dst_field)
    ofs_nbits = multipath.offset <<< 6 ||| multipath.n_bits - 1

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      hash_field_int::16,
      multipath.basis::16,
      0::size(2)-unit(8),
      alg_int::16,
      multipath.max_link::16,
      multipath.argument::32,
      0::size(2)-unit(8),
      ofs_nbits::16,
      dst_field_bin::4-bytes
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<hash_field_int::16, basis::16, _::size(2)-unit(8), alg_int::16, max_link::16, arg::32,
      _::size(2)-unit(8), ofs::10, n_bits::6, dst_field_bin::4-bytes>> = body

    hash_field = Openflow.Enums.to_atom(hash_field_int, :nx_hash_fields)
    alg = Openflow.Enums.to_atom(alg_int, :nx_mp_algorithm)
    dst_field = Openflow.Match.codec_header(dst_field_bin)

    %NxMultipath{
      hash_field: hash_field,
      basis: basis,
      algorithm: alg,
      max_link: max_link,
      argument: arg,
      offset: ofs,
      n_bits: n_bits + 1,
      dst_field: dst_field
    }
  end
end
