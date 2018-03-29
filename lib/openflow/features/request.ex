defmodule Openflow.Features.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    # virtual field
    aux_id: 0
  )

  alias __MODULE__

  def ofp_type, do: 5

  def new(xid \\ 0) do
    %Request{xid: xid}
  end

  def read(_) do
    %Request{}
  end

  def to_binary(%Request{}) do
    <<>>
  end
end
