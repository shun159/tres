defmodule Openflow.Action.NxBundle do
  defstruct(
    algorithm:  :active_backup,
    hash_field: :eth_src,
    basis:      0,
    slave_type: :nx_in_port,
    n_slaves:   0,
    slaves:     []
  )

  @experimenter 0x00002320
  @nxast 12

  alias __MODULE__

  def new(options) do
    slaves = options[:slaves] || []
    %NxBundle{algorithm:  options[:algorithm]  || :active_backup,
              hash_field: options[:hash_field] || :eth_src,
              basis:      options[:basis]      || 0,
              n_slaves:   length(slaves),
              slaves:     slaves}
  end

  def to_binary(%NxBundle{algorithm: alg,
                          hash_field: hash_field,
                          basis: basis,
                          slave_type: slave_type,
                          n_slaves: n_slaves,
                          slaves: slaves}) do
    hash_field_int = Openflow.Enums.to_int(hash_field, :nx_hash_fields)
    alg_int = Openflow.Enums.to_int(alg, :nx_bd_algorithm)
    slave_type_bin = Openflow.Match.codec_header(slave_type)
    slaves_bin = codec_slaves(slaves)
    body = <<alg_int::16, hash_field_int::16, basis::16,
             slave_type_bin::4-bytes, n_slaves::16, 0::16, 0::size(4)-unit(8), 0::32,
             slaves_bin::bytes>>
    exp_body = <<@experimenter::32, @nxast::16, body::bytes>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<alg_int::16, hash_field_int::16, basis::16,
      slave_type_bin::4-bytes, n_slaves::16, _::16, _::32, _::32, rest::bytes>> = body
    slave_len = n_slaves * 2
    <<slaves_bin::size(slave_len)-bytes, _::bytes>> = rest
    alg = Openflow.Enums.to_atom(alg_int, :nx_bd_algorithm)
    hash_field = Openflow.Enums.to_atom(hash_field_int, :nx_hash_fields)
    slave_type = Openflow.Match.codec_header(slave_type_bin)
    slaves = codec_slaves(slaves_bin)
    n_slaves = length(slaves)
    %NxBundle{algorithm: alg,
              hash_field: hash_field,
              basis: basis,
              slave_type: slave_type,
              n_slaves: n_slaves,
              slaves: slaves}
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
