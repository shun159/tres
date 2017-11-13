defmodule Openflow.Instruction.ClearActions do
  defstruct([])

  alias __MODULE__

  def new do
    %ClearActions{}
  end

  def to_binary(%ClearActions{}) do
    actions_bin = ""
    length = 8 + byte_size(actions_bin)
    <<5::16, length::16, 0::size(4)-unit(8), actions_bin::bytes>>
  end

  def read(<<5::16, _length::16, _::size(4)-unit(8), _::bytes>>) do
    %ClearActions{}
  end
end
