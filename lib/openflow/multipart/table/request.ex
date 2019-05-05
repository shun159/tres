defmodule Openflow.Multipart.Table.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    flags: []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(options \\ []) do
    %Request{xid: options[:xid] || 0}
  end

  def read("") do
    %Request{}
  end

  def to_binary(%Request{} = msg) do
    Openflow.Multipart.Request.header(msg)
  end
end
