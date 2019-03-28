defmodule Openflow.Action.SetQueue do
  @moduledoc """
  Set queue id when outputting to a port
  """

  defstruct(id: 0)

  alias __MODULE__

  @type t :: %SetQueue{id: 0..0xFFFFFFFF}

  @spec ofpat() :: 21
  def ofpat, do: 21

  @doc """
  Create a new set_queue action struct

  ## Options:
    - Queue id for the packets

  ```elixir
  iex> %SetQueue{id: 1} = SetQueue.new(_id = 1)
  ```
  """
  @spec new(id :: 0..0xFFFFFFFF) :: t()
  def new(id) do
    %SetQueue{id: id}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%SetQueue{id: id}) do
    <<21::16, 8::16, id::32>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<21::16, 8::16, id::32>>) do
    %SetQueue{id: id}
  end
end
