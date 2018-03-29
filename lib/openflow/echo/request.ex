defmodule Openflow.Echo.Request do
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

  def ofp_type, do: 2

  def new(options) when is_list(options) do
    %Request{
      xid: options[:xid] || 0,
      data: options[:data] || ""
    }
  end

  def new(data) when is_binary(data) do
    %Request{data: data}
  end

  def read(data) do
    %Request{data: data}
  end

  def to_binary(%Request{data: data}) do
    data
  end
end
