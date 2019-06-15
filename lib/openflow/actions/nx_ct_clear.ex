defmodule Openflow.Action.NxCtClear do
  defstruct([])

  @experimenter 0x00002320
  @nxast 43

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new do
    %NxCtClear{}
  end

  def to_binary(%NxCtClear{}) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      0::16,
      0::size(4)-unit(8)
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, _::16, _::size(4)-unit(8)>>) do
    %NxCtClear{}
  end
end
