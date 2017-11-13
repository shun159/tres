defmodule Openflow.Action.NxSample do
  defstruct(
    probability:      0,
    collector_set_id: 0,
    obs_domain_id:    0,
    obs_point_id:     0
  )

  @experimenter 0x00002320
  @nxast 29

  alias __MODULE__

  def new(options) do
    probability = Keyword.get(options, :probability, 0)
    collector_set_id = Keyword.get(options, :collector_set_id, 0)
    obs_domain_id = Keyword.get(options, :obs_domain_id, 0)
    obs_point_id = Keyword.get(options, :obs_point_id, 0)
    %NxSample{probability:      probability,
              collector_set_id: collector_set_id,
              obs_domain_id:    obs_domain_id,
              obs_point_id:     obs_point_id}
  end

  def to_binary(%NxSample{probability:      probability,
                          collector_set_id: collector_set_id,
                          obs_domain_id:    obs_domain_id,
                          obs_point_id:     obs_point_id}) do
    exp_body = <<@experimenter::32, @nxast::16, probability::16,
      collector_set_id::32, obs_domain_id::32, obs_point_id::32>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, probability::16,
             collector_set_id::32, obs_domain_id::32, obs_point_id::32>>) do
    %NxSample{probability:      probability,
              collector_set_id: collector_set_id,
              obs_domain_id:    obs_domain_id,
              obs_point_id:     obs_point_id}
  end
end
