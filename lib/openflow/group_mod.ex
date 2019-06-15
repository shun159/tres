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

  @type command :: :add | :delete | :modify
  @type type :: :add | :select | :indirect | :fast_failover
  @type id :: :max | :all | :any | 0..0xFFFFFFFF

  @type t :: %GroupMod{
          version: 4,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFF | nil,
          xid: 0..0xFFFFFFFF,
          command: command(),
          type: type(),
          group_id: id(),
          buckets: [Openflow.Bucket.t()]
        }

  @spec ofp_type() :: 15
  def ofp_type, do: 15

  @spec new(
          xid: 0..0xFFFFFFFF,
          command: command(),
          type: type(),
          group_id: id(),
          buckets: [Openflow.Bucket.t()]
        ) :: t()
  def new(options \\ []) do
    %GroupMod{
      xid: options[:xid] || 0,
      command: options[:command] || :add,
      type: options[:type] || :all,
      group_id: options[:group_id] || 0,
      buckets: options[:buckets] || []
    }
  end

  @spec read(<<_::64, _::_*128>>) :: t()
  def read(<<command_int::16, type_int::8, _::8, group_id_int::32, buckets_bin::bytes>>) do
    command = Openflow.Utils.get_enum(command_int, :group_mod_command)
    type = Openflow.Utils.get_enum(type_int, :group_type)
    group_id = Openflow.Utils.get_enum(group_id_int, :group_id)
    buckets = Openflow.Bucket.read(buckets_bin)
    %GroupMod{command: command, type: type, group_id: group_id, buckets: buckets}
  end

  @spec to_binary(t()) :: <<_::64, _::_*128>>
  def to_binary(%GroupMod{command: command, type: type, group_id: group_id, buckets: buckets}) do
    command_int = Openflow.Utils.get_enum(command, :group_mod_command)
    type_int = Openflow.Utils.get_enum(type, :group_type)
    group_id_int = Openflow.Utils.get_enum(group_id, :group_id)
    buckets_bin = Openflow.Bucket.to_binary(buckets)
    <<command_int::16, type_int::8, 0::8, group_id_int::32, buckets_bin::bytes>>
  end
end
