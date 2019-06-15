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
  alias Openflow.Action.Experimenter

  def new(options \\ []) do
    (is_integer(options[:probability]) and options[:probability] > 0) ||
      raise("probability must be greater than 0")

    %NxSample3{
      probability: options[:probability] || 0,
      collector_set_id: options[:collector_set_id] || 0,
      obs_domain_id: options[:obs_domain_id] || 0,
      obs_point_id: options[:obs_point_id] || 0,
      sampling_port: options[:sampling_port] || 0,
      direction: options[:direction] || :default
    }
  end

  def to_binary(%NxSample3{} = sample) do
    sample_direction_int = Openflow.Enums.to_int(sample.direction, :nx_action_sample_direction)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      sample.probability::16,
      sample.collector_set_id::32,
      sample.obs_domain_id::32,
      sample.obs_point_id::32,
      sample.sampling_port::16,
      sample_direction_int::8,
      0::size(5)-unit(8)
    >>)
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
