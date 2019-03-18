defmodule Openflow.Action.NxClone do
  defstruct(actions: [])

  @experimenter 0x00002320
  @nxast 42

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(actions \\ []) do
    %NxClone{actions: actions}
  end

  def to_binary(%NxClone{actions: actions}) do
    actions_bin = Openflow.Action.to_binary(actions)

    Experimenter.pack_exp_header(
      <<@experimenter::32, @nxast::16, 0::size(6)-unit(8), actions_bin::bytes>>
    )
  end

  def read(<<@experimenter::32, @nxast::16, 0::size(6)-unit(8), actions_bin::bytes>>) do
    actions = Openflow.Action.read(actions_bin)
    %NxClone{actions: actions}
  end
end
