defmodule Openflow.GetConfig.Request do
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
          aux_id: non_neg_integer() | nil
        }

  @spec ofp_type() :: 7
  def ofp_type, do: 7

  @spec new(xid :: 0..0xFFFFFFFF) :: t()
  def new(xid \\ 0), do: %Request{xid: xid}

  @spec read(any()) :: t()
  def read(_), do: %Request{}

  @spec to_binary(t()) :: <<>>
  def to_binary(%Request{}), do: <<>>
end
