defmodule Openflow.Action.SetQueue do
  defstruct(id: 0)

  alias __MODULE__

  def ofpat, do: 21

  def new(id) do
    %SetQueue{id: id}
  end

  def to_binary(%SetQueue{id: id}) do
    <<21::16, 8::16, id::32>>
  end

  def read(<<21::16, 8::16, id::32>>) do
    %SetQueue{id: id}
  end
end
