defmodule Openflow.Instruction.ApplyActions do
  defstruct(actions: [])

  alias __MODULE__

  @type t :: %ApplyActions{actions: [Openflow.Action.type()]}

  @spec new(Openflow.Action.type() | [Openflow.Action.type()]) :: t()
  def new(actions), do: %ApplyActions{actions: actions}

  @spec to_binary(t()) :: <<_::64, _::_*8>>
  def to_binary(%ApplyActions{actions: actions}) do
    actions_bin = Openflow.Action.to_binary(actions)
    length = 8 + byte_size(actions_bin)
    <<4::16, length::16, 0::size(4)-unit(8), actions_bin::bytes>>
  end

  @spec read(<<_::64, _::_*8>>) :: t()
  def read(<<4::16, _length::16, _::size(4)-unit(8), actions_bin::bytes>>) do
    actions = Openflow.Action.read(actions_bin)
    %ApplyActions{actions: actions}
  end
end
