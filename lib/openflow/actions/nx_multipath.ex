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

  def new(options) do
    hash_field = Keyword.get(options, :hash_field, :eth_src)
    basis = Keyword.get(options, :basis, 0)
    alg = Keyword.get(options, :algorithm, :modulo_n)
    max_link = Keyword.get(options, :max_link, 0)
    arg = Keyword.get(options, :argument, 0)
    dst_field = Keyword.get(options, :dst_field)
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)
    n_bits = Keyword.get(options, :n_bits, default_n_bits)
    ofs = Keyword.get(options, :offset, 0)

    %NxMultipath{
      hash_field: hash_field,
      basis: basis,
      algorithm: alg,
      max_link: max_link,
      offset: ofs,
      n_bits: n_bits,
      argument: arg,
      dst_field: dst_field
    }
  end

  def to_binary(%NxMultipath{
        hash_field: hash_field,
        basis: basis,
        algorithm: alg,
        max_link: max_link,
        argument: arg,
        offset: ofs,
        n_bits: n_bits,
        dst_field: dst_field
      }) do
    hash_field_int = Openflow.Enums.to_int(hash_field, :nx_hash_fields)
    alg_int = Openflow.Enums.to_int(alg, :nx_mp_algorithm)
    dst_field_bin = Openflow.Match.codec_header(dst_field)
    ofs_nbits = ofs <<< 6 ||| n_bits - 1

    body =
      <<hash_field_int::16, basis::16, 0::size(2)-unit(8), alg_int::16, max_link::16, arg::32,
        0::size(2)-unit(8), ofs_nbits::16, dst_field_bin::4-bytes>>

    exp_body = <<@experimenter::32, @nxast::16, body::bytes>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
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
