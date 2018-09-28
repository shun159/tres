defmodule Openflow.Multipart.FlowMonitor.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    id: 0,
    flags: [],
    out_port: :none,
    table_id: :all,
    match: []
  )

  alias __MODULE__

  def new(%Request{}) do
    <<>>
  end

  def read(_binary) do
    %Request{}
  end
end
