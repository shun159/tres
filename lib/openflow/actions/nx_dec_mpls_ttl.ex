defmodule Openflow.Action.NxDecMplsTtl do
  defstruct([])

  @experimenter 0x00002320
  @nxast 26

  alias __MODULE__

  def new do
    %NxDecMplsTtl{}
  end

  def to_binary(%NxDecMplsTtl{}) do
    exp_body = <<@experimenter::32, @nxast::16, 0::size(6)-unit(8)>>
    <<0xFFFF::16, 16::16, exp_body::bytes>>
  end

  def read(<<@experimenter::32, @nxast::16, _::size(6)-unit(8)>>) do
    %NxDecMplsTtl{}
  end
end
