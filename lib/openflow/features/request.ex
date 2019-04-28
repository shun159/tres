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

  @type t :: %Request{
          version: 4,
          xid: 0..0xFFFFFFFF,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFFFF | nil
        }

  @spec ofp_type :: 5
  def ofp_type, do: 5

  @spec new(0..0xFFFF) :: t()
  def new(xid \\ 0), do: %Request{xid: xid}

  @spec read(any()) :: t()
  def read(_), do: %Request{}

  @spec to_binary(t()) :: <<>>
  def to_binary(%Request{}), do: <<>>
end
