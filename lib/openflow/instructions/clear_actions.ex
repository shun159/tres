defmodule Openflow.Instruction.ClearActions do
  defstruct([])

  alias __MODULE__

  @type t :: %ClearActions{}

  @spec new() :: t()
  def new,
    do: %ClearActions{}

  @spec to_binary(t()) :: <<_::64>>
  def to_binary(%ClearActions{}),
    do: <<5::16, 8::16, 0::32>>

  @spec read(<<_::64, _::_*8>>) :: t()
  def read(<<5::16, _length::16, _::size(4)-unit(8), _::bytes>>),
    do: %ClearActions{}
end
