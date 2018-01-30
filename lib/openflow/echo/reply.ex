defmodule Openflow.Echo.Reply do
  defstruct(
    version: 4,
    xid: 0,
    data: "",
    # virtual field
    datapath_id: nil,
    # virtual field
    aux_id: 0
  )

  alias __MODULE__

  def ofp_type, do: 3

  def new(data \\ "") do
    %Reply{data: data}
  end

  def read(data) do
    %Reply{data: data}
  end

  def to_binary(%Reply{data: data}) do
    data
  end
end
