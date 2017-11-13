defmodule Openflow.Barrier.Reply do
  defstruct(
    version:        4,
    xid:            0,
    datapath_id:  nil, # virtual field
    aux_id:         0  # virtual field
  )

  alias __MODULE__

  def ofp_type, do: 21

  def new do
    %Reply{}
  end

  def read(_) do
    %Reply{}
  end

  def to_binary(%Reply{}) do
    <<>>
  end
end
