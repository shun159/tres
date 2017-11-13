defmodule Openflow.GetConfig.Request do
  defstruct(
    version:        4,
    xid:            0,
    datapath_id:  nil, # virtual field
    aux_id:         0  # virtual field
  )

  alias __MODULE__

  def ofp_type, do: 7

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
