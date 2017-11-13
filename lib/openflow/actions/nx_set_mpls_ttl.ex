defmodule Openflow.Action.NxSetMplsTtl do
  defstruct(ttl: 0)

  @experimenter 0x00002320
  @nxast 25

  alias __MODULE__

  def new(ttl) do
    %NxSetMplsTtl{ttl: ttl}
  end

  def to_binary(%NxSetMplsTtl{ttl: ttl}) do
    exp_body = <<@experimenter::32, @nxast::16, ttl::8, 0::size(5)-unit(8)>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, ttl::8, _::size(5)-unit(8)>>) do
    %NxSetMplsTtl{ttl: ttl}
  end
end
