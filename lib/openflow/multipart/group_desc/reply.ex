defmodule Openflow.Multipart.GroupDesc.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    flags:        [],
    groups:       []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(groups \\ []) do
    %Reply{groups: groups}
  end

  def read(<<groups_bin::bytes>>) do
    groups = Openflow.Multipart.GroupDescStats.read(groups_bin)
    %Reply{groups: groups}
  end

  def append_body(%Reply{groups: groups} = message, %Reply{flags: [:more], groups: continue}) do
    %{message|groups: [continue|groups]}
  end
  def append_body(%Reply{groups: groups} = message, %Reply{flags: [], groups: continue}) do
    new_groups = [continue|groups]
    |> Enum.reverse
    |> List.flatten
    %{message|groups: new_groups}
  end
end

defmodule Openflow.Multipart.GroupDescStats do
  defstruct(
    type:     :all,
    group_id:    0,
    buckets:    []
  )

  alias __MODULE__

  @ofp_group_desc_size 8

  def read(binary) do
    do_read([], binary)
  end

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)
  defp do_read(acc, <<length::16, _tail::bytes>> = binary) do
    <<group_stats_bin::size(length)-bytes, rest::bytes>> = binary
    do_read([codec(group_stats_bin)|acc], rest)
  end

  defp codec(<<length::16, type_int::8, _::8, group_id::32, tail::bytes>>) do
    buckets_bin_len = length - @ofp_group_desc_size
    <<buckets_bin::size(buckets_bin_len)-bytes, _::bytes>> = tail
    type = Openflow.Enums.to_atom(type_int, :group_type)
    buckets = Openflow.Bucket.read(buckets_bin)
    %GroupDescStats{type: type, group_id: group_id, buckets: buckets}
  end
end
