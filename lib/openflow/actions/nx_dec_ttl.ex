defmodule Openflow.Action.NxDecTtl do
  defstruct([])

  @experimenter 0x00002320
  @nxast 18

  alias __MODULE__

  def new do
    %NxDecTtl{}
  end

  def to_binary(%NxDecTtl{}) do
    exp_body = <<@experimenter::32, @nxast::16, 0::size(6)-unit(8)>>
    <<0xFFFF::16, 16::16, exp_body::bytes>>
  end

  def read(<<@experimenter::32, @nxast::16, _::16, _::size(4)-unit(8)>>) do
    %NxDecTtl{}
  end
end
