defmodule Openflow.Instruction.WriteActions do
  defstruct(actions: [])

  alias __MODULE__

  def new(actions) do
    %WriteActions{actions: actions}
  end

  def to_binary(%WriteActions{actions: actions}) do
    actions_bin = Openflow.Action.to_binary(actions)
    length = 8 + byte_size(actions_bin)
    <<3::16, length::16, 0::size(4)-unit(8), actions_bin::bytes>>
  end

  def read(<<3::16, _length::16, _::size(4)-unit(8), actions_bin::bytes>>) do
    actions = Openflow.Action.read(actions_bin)
    %WriteActions{actions: actions}
  end
end
