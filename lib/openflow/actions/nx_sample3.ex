defmodule Openflow.Action.NxSample3 do
  defstruct(
    probability: 0,
    collector_set_id: 0,
    obs_domain_id: 0,
    obs_point_id: 0,
    sampling_port: 0,
    direction: :default
  )

  @experimenter 0x00002320
  @nxast 41

  alias __MODULE__

  def new(options) do
    probability = Keyword.get(options, :probability, 0)
    collector_set_id = Keyword.get(options, :collector_set_id, 0)
    obs_domain_id = Keyword.get(options, :obs_domain_id, 0)
    obs_point_id = Keyword.get(options, :obs_point_id, 0)
    sampling_port = Keyword.get(options, :sampling_port, 0)
    direction = Keyword.get(options, :direction, :default)

    %NxSample3{
      probability: probability,
      collector_set_id: collector_set_id,
      obs_domain_id: obs_domain_id,
      obs_point_id: obs_point_id,
      sampling_port: sampling_port,
      direction: direction
    }
  end

  def to_binary(%NxSample3{
        probability: probability,
        collector_set_id: collector_set_id,
        obs_domain_id: obs_domain_id,
        obs_point_id: obs_point_id,
        sampling_port: sampling_port,
        direction: direction
      }) do
    direction_int = Openflow.Enums.to_int(direction, :nx_action_sample_direction)

    exp_body =
      <<@experimenter::32, @nxast::16, probability::16, collector_set_id::32, obs_domain_id::32,
        obs_point_id::32, sampling_port::16, direction_int::8, 0::size(5)-unit(8)>>

    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(
        <<@experimenter::32, @nxast::16, probability::16, collector_set_id::32, obs_domain_id::32,
          obs_point_id::32, sampling_port::16, direction_int::8, 0::size(5)-unit(8)>>
      ) do
    direction = Openflow.Enums.to_atom(direction_int, :nx_action_sample_direction)

    %NxSample3{
      probability: probability,
      collector_set_id: collector_set_id,
      obs_domain_id: obs_domain_id,
      obs_point_id: obs_point_id,
      sampling_port: sampling_port,
      direction: direction
    }
  end
end
