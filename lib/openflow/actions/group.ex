defmodule Openflow.Action.Group do
  @moduledoc """
  Apply Group
  """

  defstruct(id: 0)

  alias __MODULE__

  @type t :: %Group{id: 0..0xFFFFFFFF}

  @spec ofpat() :: 22
  def ofpat, do: 22

  @doc """
  Create a new group action struct

  ## Options
  - id: Group identifier

  ```elixir
  iex> %Group{id: 10} = Group.new(10)
  ```
  """
  @spec new(0..0xFFFFFFFF) :: t()
  def new(id) do
    %Group{id: id}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%Group{id: id}) do
    <<22::16, 8::16, id::32>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<22::16, 8::16, id::32>>) do
    %Group{id: id}
  end
end
