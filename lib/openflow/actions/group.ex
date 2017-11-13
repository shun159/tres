defmodule Openflow.Action.Group do
  defstruct(id: 0)

  alias __MODULE__

  def ofpat, do: 22

  def new(id) do
    %Group{id: id}
  end

  def to_binary(%Group{id: id}) do
    <<22::16, 8::16, id::32>>
  end

  def read(<<22::16, 8::16, id::32>>) do
    %Group{id: id}
  end
end
