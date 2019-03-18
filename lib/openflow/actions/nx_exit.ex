defmodule Openflow.Action.NxExit do
  defstruct([])

  @experimenter 0x00002320
  @nxast 17

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new do
    %NxExit{}
  end

  def to_binary(%NxExit{}) do
    Experimenter.pack_exp_header(<<@experimenter::32, @nxast::16, 0::48>>)
  end

  def read(<<@experimenter::32, @nxast::16, 0::48, _::bytes>>) do
    %NxExit{}
  end
end
