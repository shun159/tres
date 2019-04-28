defmodule Openflow.Echo.Reply do
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

  @type t :: %Reply{
          version: 4,
          xid: 0..0xFFFFFFFF,
          data: String.t(),
          datapath_id: String.t() | nil,
          aux_id: 0..0xFFFF | nil
        }

  @spec ofp_type :: 3
  def ofp_type, do: 3

  @spec new(xid: 0..0xFFFFFFFF, data: String.t()) :: t()
  def new(options) when is_list(options) do
    %Reply{
      xid: options[:xid] || 0,
      data: options[:data] || ""
    }
  end

  @spec new(String.t()) :: t()
  def new(data) when is_binary(data), do: %Reply{data: data}

  @spec new() :: t()
  def new, do: new([])

  @spec read(String.t()) :: t()
  def read(data), do: %Reply{data: data}

  @spec to_binary(t()) :: String.t()
  def to_binary(%Reply{data: data}), do: data
end
