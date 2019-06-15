defmodule Openflow.Bucket do
  defstruct(
    weight: 0,
    watch_port: 0,
    watch_group: 0,
    actions: []
  )

  alias __MODULE__

  @type t :: %Bucket{
          weight: 0..0xFFFF,
          watch_port: Openflow.Port.no(),
          watch_group: Openflow.GroupMod.id(),
          actions: [Openflow.Actions.type()]
        }

  @header_size 16

  @spec new(
          weight: 0..0xFFFF,
          watch_port: Openflow.Port.no(),
          watch_group: Openflow.GroupMod.id(),
          actions: [Openflow.Actions.type()]
        ) :: t()
  def new(options) do
    %Bucket{
      weight: options[:weight] || 0,
      watch_port: options[:watch_port] || :any,
      watch_group: options[:watch_group] || :any,
      actions: options[:actions] || []
    }
  end

  @spec read(<<_::_*128>>) :: [t()]
  def read(buckets_bin), do: do_read([], buckets_bin)

  @spec read([t()]) :: <<_::_*128>>
  def to_binary(buckets), do: to_binary("", buckets)

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)

  defp do_read(
         acc,
         <<length::16, weight::16, watch_port_int::32, watch_group_int::32, _::size(4)-unit(8),
           binary::bytes>>
       ) do
    actions_len = length - @header_size
    <<actions_bin::size(actions_len)-bytes, rest::bytes>> = binary
    watch_port = Openflow.Utils.get_enum(watch_port_int, :openflow13_port_no)
    watch_group = Openflow.Utils.get_enum(watch_group_int, :group_id)
    actions = Openflow.Action.read(actions_bin)

    bucket = %Bucket{
      weight: weight,
      watch_port: watch_port,
      watch_group: watch_group,
      actions: actions
    }

    do_read([bucket | acc], rest)
  end

  defp to_binary(acc, []), do: acc

  defp to_binary(acc, [bucket | rest]) do
    %Bucket{weight: weight, watch_port: watch_port, watch_group: watch_group, actions: actions} =
      bucket

    watch_port_int = Openflow.Utils.get_enum(watch_port, :openflow13_port_no)
    watch_group_int = Openflow.Utils.get_enum(watch_group, :group_id)
    actions_bin = Openflow.Action.to_binary(actions)
    length = byte_size(actions_bin) + @header_size

    bucket_bin =
      <<length::16, weight::16, watch_port_int::32, watch_group_int::32, 0::size(4)-unit(8),
        actions_bin::bytes>>

    to_binary(<<acc::bytes, bucket_bin::bytes>>, rest)
  end
end
