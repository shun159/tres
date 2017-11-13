defmodule Openflow.GetAsync.Request do
  defstruct(
    version:        4,
    xid:            0,
    datapath_id:  nil, # virtual field
    aux_id:         0  # virtual field
  )

  alias __MODULE__

  def ofp_type, do: 26

  def read(_) do
    %Request{}
  end

  def to_binary(%Request{}) do
    <<>>
  end
end
