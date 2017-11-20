defmodule Openflow.Action.NxBundleLoad do
  import Bitwise

  defstruct(
    algorithm:  :active_backup,
    hash_field: :eth_src,
    basis:      0,
    slave_type: :nx_in_port,
    n_slaves:   0,
    slaves:     [],
    offset:     0,
    n_bits:     0,
    dst_field:  nil
  )

  @experimenter 0x00002320
  @nxast 13

  alias __MODULE__

  def new(options) do
    dst_field = options[:dst_field]
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)
    slaves = options[:slaves] || []
    %NxBundleLoad{algorithm:  options[:algorithm]  || :active_backup,
                  hash_field: options[:hash_field] || :eth_src,
                  basis:      options[:basis]      || 0,
                  n_slaves:   length(slaves),
                  slaves:     slaves,
                  offset:     options[:offset] || 0,
                  n_bits:     options[:n_bits] || default_n_bits,
                  dst_field:  options[:dst_field]}
  end

  def to_binary(%NxBundleLoad{algorithm: alg,
                              hash_field: hash_field,
                              basis: basis,
                              slave_type: slave_type,
                              n_slaves: n_slaves,
                              slaves: slaves,
                              offset: ofs,
                              n_bits: n_bits,
                              dst_field: dst_field}) do
    hash_field_int = Openflow.Enums.to_int(hash_field, :nx_hash_fields)
    alg_int = Openflow.Enums.to_int(alg, :nx_bd_algorithm)
    slave_type_bin = Openflow.Match.codec_header(slave_type)
    slaves_bin = codec_slaves(slaves)
    ofs_nbits = (ofs <<< 6) ||| (n_bits - 1)
    dst_field_bin = Openflow.Match.codec_header(dst_field)
    body = <<alg_int::16, hash_field_int::16, basis::16,
             slave_type_bin::4-bytes, n_slaves::16, ofs_nbits::16,
             dst_field_bin::4-bytes, 0::32, slaves_bin::bytes>>
    exp_body = <<@experimenter::32, @nxast::16, body::bytes>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<alg_int::16, hash_field_int::16, basis::16,
      slave_type_bin::4-bytes, n_slaves::16, ofs::10, n_bits::6,
      dst_field_bin::4-bytes, _reserved::32, rest::bytes>> = body
    slave_len = n_slaves * 2
    <<slaves_bin::size(slave_len)-bytes, _::bytes>> = rest
    alg = Openflow.Enums.to_atom(alg_int, :nx_bd_algorithm)
    hash_field = Openflow.Enums.to_atom(hash_field_int, :nx_hash_fields)
    slave_type = Openflow.Match.codec_header(slave_type_bin)
    slaves = codec_slaves(slaves_bin)
    n_slaves = length(slaves)
    dst_field = Openflow.Match.codec_header(dst_field_bin)
    %NxBundleLoad{algorithm: alg,
                  hash_field: hash_field,
                  basis: basis,
                  slave_type: slave_type,
                  n_slaves: n_slaves,
                  slaves: slaves,
                  offset: ofs,
                  n_bits: n_bits + 1,
                  dst_field: dst_field}
  end

  # private functions

  defp codec_slaves(slaves) when is_list(slaves) do
    slaves1 = for slave <- slaves do
      slave_int = Openflow.Utils.get_enum(slave, :openflow10_port_no)
      <<slave_int::16>>
    end
    Enum.join(slaves1, "")
  end
  defp codec_slaves(slaves) when is_binary(slaves) do
    for <<slave_int::16 <- slaves>> do
      Openflow.Utils.get_enum(slave_int, :openflow10_port_no)
    end
  end
end
