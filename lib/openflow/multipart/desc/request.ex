defmodule Openflow.Multipart.Desc.Request do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    flags: []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new do
    %Request{}
  end

  def read("") do
    %Request{}
  end

  def to_binary(%Request{} = msg) do
    Openflow.Multipart.Request.header(msg)
  end
end
