defmodule Openflow.Action.NxExit do
  defstruct([])

  @experimenter 0x00002320
  @nxast 17

  alias __MODULE__

  def new do
    %NxExit{}
  end

  def to_binary(%NxExit{}) do
    exp_body = <<@experimenter::32, @nxast::16, 0::48>>
    <<0xffff::16, 16::16, exp_body::bytes>>
  end

  def read(<<@experimenter::32, @nxast::16, 0::48>>) do
    %NxExit{}
  end
end
