defmodule Openflow.Action.NxBundle do
  defstruct(
    algorithm: :active_backup,
    hash_field: :eth_src,
    basis: 0,
    slave_type: :nx_in_port,
    n_slaves: 0,
    slaves: []
  )

  @experimenter 0x00002320
  @nxast 12

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

  @type t :: %NxBundle{
          algorithm: algorithm(),
          hash_field: hash_field(),
          basis: non_neg_integer(),
          slave_type: :nx_in_port,
          n_slaves: non_neg_integer(),
          slaves: [pos_integer()]
        }

  @spec new(
          algorithm: algorithm(),
          hash_field: hash_field(),
          basis: non_neg_integer(),
          slave_type: :nx_in_port,
          n_slaves: non_neg_integer(),
          slaves: [pos_integer()]
        ) :: t()
  def new(options \\ []) do
    slaves = options[:slaves] || []

    %NxBundle{
      algorithm: options[:algorithm] || :active_backup,
      hash_field: options[:hash_field] || :eth_src,
      basis: options[:basis] || 0,
      n_slaves: length(slaves),
      slaves: slaves
    }
  end

  def to_binary(%NxBundle{} = bundle) do
    bundle_hash_field_int = Openflow.Enums.to_int(bundle.hash_field, :nx_hash_fields)
    bundle_alg_int = Openflow.Enums.to_int(bundle.algorithm, :nx_bd_algorithm)
    bundle_slave_type_bin = Openflow.Match.codec_header(bundle.slave_type)
    bundle_slaves_bin = codec_slaves(bundle.slaves)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      bundle_alg_int::16,
      bundle_hash_field_int::16,
      bundle.basis::16,
      bundle_slave_type_bin::4-bytes,
      bundle.n_slaves::16,
      0::size(2)-unit(8),
      0::size(4)-unit(8),
      0::size(4)-unit(8),
      bundle_slaves_bin::bytes
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<alg_int::16, hash_field_int::16, basis::16, slave_type_bin::4-bytes, n_slaves::16, _::16,
      _::32, _::32, rest::bytes>> = body

    slave_len = n_slaves * 2
    <<slaves_bin::size(slave_len)-bytes, _::bytes>> = rest
    alg = Openflow.Enums.to_atom(alg_int, :nx_bd_algorithm)
    hash_field = Openflow.Enums.to_atom(hash_field_int, :nx_hash_fields)
    slave_type = Openflow.Match.codec_header(slave_type_bin)
    slaves = codec_slaves(slaves_bin)
    n_slaves = length(slaves)

    %NxBundle{
      algorithm: alg,
      hash_field: hash_field,
      basis: basis,
      slave_type: slave_type,
      n_slaves: n_slaves,
      slaves: slaves
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
