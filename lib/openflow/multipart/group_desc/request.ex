defmodule Openflow.Multipart.GroupDesc.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    aux_id: nil,
    flags: []
  )

  alias __MODULE__

  @type t :: %Request{
          version: 4,
          datapath_id: String.t(),
          aux_id: 0..0xFF | nil,
          xid: 0..0xFFFFFFFF,
          flags: [:more]
        }

  def ofp_type, do: 18

  def new(xid \\ 0) do
    %Request{xid: xid}
  end

  def read("") do
    %Request{}
  end

  def to_binary(%Request{} = msg) do
    Openflow.Multipart.Request.header(msg)
  end
end
