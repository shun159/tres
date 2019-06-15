defmodule Openflow.Action.NxBundleLoad do
  import Bitwise

  defstruct(
    algorithm: :active_backup,
    hash_field: :eth_src,
    basis: 0,
    slave_type: :nx_in_port,
    n_slaves: 0,
    slaves: [],
    offset: 0,
    n_bits: 0,
    dst_field: nil
  )

  @experimenter 0x00002320
  @nxast 13

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @type algorithm :: :active_backup | :highest_random_weight
  @type hash_field ::
          :eth_src
          | :symmetric_l4
          | :symmetric_l3l4
          | :symmetric_l3l4_udp
          | :nw_src
          | :nw_dst

  @type t :: %NxBundleLoad{
          algorithm: algorithm(),
          hash_field: hash_field(),
          basis: non_neg_integer(),
          slave_type: :nx_in_port,
          n_slaves: non_neg_integer(),
          slaves: [pos_integer()],
          offset: non_neg_integer(),
          n_bits: pos_integer(),
          dst_field: atom()
        }

  @spec new(
          algorithm: algorithm(),
          hash_field: hash_field(),
          basis: non_neg_integer(),
          slave_type: :nx_in_port,
          n_slaves: non_neg_integer(),
          slaves: [pos_integer()],
          offset: non_neg_integer(),
          n_bits: pos_integer(),
          dst_field: atom()
        ) :: t()
  def new(options \\ []) do
    dst_field = options[:dst_field] || raise "dst_field must be specified"
    default_n_bits = Openflow.Match.Field.n_bits_of(dst_field)
    slaves = options[:slaves] || []

    %NxBundleLoad{
      algorithm: options[:algorithm] || :active_backup,
      hash_field: options[:hash_field] || :eth_src,
      basis: options[:basis] || 0,
      n_slaves: length(slaves),
      slaves: slaves,
      offset: options[:offset] || 0,
      n_bits: options[:n_bits] || default_n_bits,
      dst_field: dst_field
    }
  end

  def to_binary(%NxBundleLoad{} = bundle_load) do
    hash_field_int = Openflow.Enums.to_int(bundle_load.hash_field, :nx_hash_fields)
    alg_int = Openflow.Enums.to_int(bundle_load.algorithm, :nx_bd_algorithm)
    slave_type_bin = Openflow.Match.codec_header(bundle_load.slave_type)
    slaves_bin = codec_slaves(bundle_load.slaves)
    ofs_nbits = bundle_load.offset <<< 6 ||| bundle_load.n_bits - 1
    dst_field_bin = Openflow.Match.codec_header(bundle_load.dst_field)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      alg_int::16,
      hash_field_int::16,
      bundle_load.basis::16,
      slave_type_bin::4-bytes,
      bundle_load.n_slaves::16,
      ofs_nbits::16,
      dst_field_bin::4-bytes,
      0::32,
      slaves_bin::bytes
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<alg_int::16, hash_field_int::16, basis::16, slave_type_bin::4-bytes, n_slaves::16, ofs::10,
      n_bits::6, dst_field_bin::4-bytes, _reserved::32, rest::bytes>> = body

    slave_len = n_slaves * 2
    <<slaves_bin::size(slave_len)-bytes, _::bytes>> = rest
    alg = Openflow.Enums.to_atom(alg_int, :nx_bd_algorithm)
    hash_field = Openflow.Enums.to_atom(hash_field_int, :nx_hash_fields)
    slave_type = Openflow.Match.codec_header(slave_type_bin)
    slaves = codec_slaves(slaves_bin)
    n_slaves = length(slaves)
    dst_field = Openflow.Match.codec_header(dst_field_bin)

    %NxBundleLoad{
      algorithm: alg,
      hash_field: hash_field,
      basis: basis,
      slave_type: slave_type,
      n_slaves: n_slaves,
      slaves: slaves,
      offset: ofs,
      n_bits: n_bits + 1,
      dst_field: dst_field
    }
  end

  # private functions

  defp codec_slaves(slaves) when is_list(slaves) do
    slaves1 =
      for slave <- slaves do
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
