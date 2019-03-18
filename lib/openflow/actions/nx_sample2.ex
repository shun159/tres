defmodule Openflow.Action.NxSample2 do
  defstruct(
    probability: 0,
    collector_set_id: 0,
    obs_domain_id: 0,
    obs_point_id: 0,
    sampling_port: 0
  )

  @experimenter 0x00002320
  @nxast 38

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ []) do
    %NxSample2{
      probability: options[:probability] || 0,
      collector_set_id: options[:collector_set_id] || 0,
      obs_domain_id: options[:obs_domain_id] || 0,
      obs_point_id: options[:obs_point_id] || 0,
      sampling_port: options[:sampling_port] || 0
    }
  end

  def to_binary(%NxSample2{} = sample) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      sample.probability::16,
      sample.collector_set_id::32,
      sample.obs_domain_id::32,
      sample.obs_point_id::32,
      sample.sampling_port::16,
      0::size(6)-unit(8)
    >>)
  end

  def read(<<
        @experimenter::32,
        @nxast::16,
        probability::16,
        collector_set_id::32,
        obs_domain_id::32,
        obs_point_id::32,
        sampling_port::16,
        _::size(6)-unit(8)
      >>) do
    %NxSample2{
      probability: probability,
      collector_set_id: collector_set_id,
      obs_domain_id: obs_domain_id,
      obs_point_id: obs_point_id,
      sampling_port: sampling_port
    }
  end
end
