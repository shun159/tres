defmodule Openflow.Action.NxClone do
  defstruct(
    actions: []
  )

  @experimenter 0x00002320
  @nxast 42

  alias __MODULE__

  def new(actions \\ []) do
    %NxClone{actions: actions}
  end

  def to_binary(%NxClone{actions: actions}) do
    actions_bin = Openflow.Action.to_binary(actions)
    exp_body = <<@experimenter::32, @nxast::16, 0::size(6)-unit(8), actions_bin::bytes>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, 0::size(6)-unit(8), actions_bin::bytes>>) do
    actions = Openflow.Action.read(actions_bin)
    %NxClone{actions: actions}
  end
end
