defmodule Openflow.Multipart.Group.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    aux_id: nil,
    flags: [],
    group_id: :all
  )

  alias __MODULE__

  @type t :: %Request{
          version: 4,
          xid: 0..0xFFFFFFFF,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFF | nil,
          flags: [],
          group_id: Openflow.GroupMod.id()
        }

  @spec ofp_type() :: 18
  def ofp_type, do: 18

  @spec new(xid: 0..0xFFFFFFFF, group_id: Openflow.GroupMod.id()) :: t()
  def new(options \\ []) do
    %Request{
      xid: options[:xid] || 0,
      group_id: options[:group_id] || :all
    }
  end

  @spec read(<<_::32, _::_*8>>) :: t()
  def read(<<group_id_int::32, _::size(4)-unit(8)>>) do
    group_id = Openflow.Utils.get_enum(group_id_int, :group_id)
    %Request{group_id: group_id}
  end

  @spec to_binary(t()) :: binary()
  def to_binary(%Request{group_id: group_id} = msg) do
    group_id_int = Openflow.Utils.get_enum(group_id, :group_id)
    header_bin = Openflow.Multipart.Request.header(msg)
    <<header_bin::bytes, group_id_int::32, 0::size(4)-unit(8)>>
  end
end
