defmodule Openflow.Barrier.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    # virtual field
    aux_id: 0
  )

  alias __MODULE__

  def ofp_type, do: 20

  def new do
    %Request{}
  end

  def read(_) do
    %Request{}
  end

  def to_binary(%Request{}) do
    <<>>
  end
end
