defmodule Openflow.Action.NxSample do
  defstruct(
    probability: 0,
    collector_set_id: 0,
    obs_domain_id: 0,
    obs_point_id: 0
  )

  @experimenter 0x00002320
  @nxast 29

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ []) do
    (is_integer(options[:probability]) and options[:probability] > 0) ||
      raise("probability must be greater than 0")

    %NxSample{
      probability: options[:probability] || 0,
      collector_set_id: options[:collector_set_id] || 0,
      obs_domain_id: options[:obs_domain_id] || 0,
      obs_point_id: options[:obs_point_id] || 0
    }
  end

  def to_binary(%NxSample{} = sample) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      sample.probability::16,
      sample.collector_set_id::32,
      sample.obs_domain_id::32,
      sample.obs_point_id::32
    >>)
  end

  def read(
        <<@experimenter::32, @nxast::16, probability::16, collector_set_id::32, obs_domain_id::32,
          obs_point_id::32>>
      ) do
    %NxSample{
      probability: probability,
      collector_set_id: collector_set_id,
      obs_domain_id: obs_domain_id,
      obs_point_id: obs_point_id
    }
  end
end
