defmodule Openflow.Multipart.Group.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    flags: [],
    group_id: :all
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(options) when is_list(options) do
    %Request{
      xid: options[:xid] || 0,
      group_id: options[:group_id] || :all
    }
  end

  def new(group_id) when is_integer(group_id) or is_atom(group_id) do
    %Request{group_id: group_id}
  end

  def read(<<group_id_int::32, _::size(4)-unit(8)>>) do
    group_id = Openflow.Utils.get_enum(group_id_int, :group_id)
    %Request{group_id: group_id}
  end

  def to_binary(%Request{group_id: group_id} = msg) do
    group_id_int = Openflow.Utils.get_enum(group_id, :group_id)
    body_bin = <<group_id_int::32, 0::size(4)-unit(8)>>
    header_bin = Openflow.Multipart.Request.header(msg)
    <<header_bin::bytes, body_bin::bytes>>
  end
end
