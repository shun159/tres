defmodule Openflow.GroupMod do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    command: :add,
    type: :all,
    group_id: 0,
    buckets: []
  )

  alias __MODULE__

  def ofp_type, do: 15

  def new(options \\ []) do
    xid = Keyword.get(options, :xid, 0)
    command = Keyword.get(options, :command, :add)
    type = Keyword.get(options, :type, :all)
    group_id = Keyword.get(options, :group_id, 0)
    buckets = Keyword.get(options, :buckets, [])
    %GroupMod{xid: xid, command: command, type: type, group_id: group_id, buckets: buckets}
  end

  def read(<<command_int::16, type_int::8, _::8, group_id_int::32, buckets_bin::bytes>>) do
    command = Openflow.Utils.get_enum(command_int, :group_mod_command)
    type = Openflow.Utils.get_enum(type_int, :group_type)
    group_id = Openflow.Utils.get_enum(group_id_int, :group_id)
    buckets = Openflow.Bucket.read(buckets_bin)
    %GroupMod{command: command, type: type, group_id: group_id, buckets: buckets}
  end

  def to_binary(%GroupMod{command: command, type: type, group_id: group_id, buckets: buckets}) do
    command_int = Openflow.Utils.get_enum(command, :group_mod_command)
    type_int = Openflow.Utils.get_enum(type, :group_type)
    group_id_int = Openflow.Utils.get_enum(group_id, :group_id)
    buckets_bin = Openflow.Bucket.to_binary(buckets)
    <<command_int::16, type_int::8, 0::8, group_id_int::32, buckets_bin::bytes>>
  end
end
