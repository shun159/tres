defmodule Openflow.Action.NxDecTtl do
  defstruct([])

  @experimenter 0x00002320
  @nxast 18

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new do
    %NxDecTtl{}
  end

  def to_binary(%NxDecTtl{}) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      0::size(6)-unit(8)
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, _::16, _::size(4)-unit(8)>>) do
    %NxDecTtl{}
  end
end
