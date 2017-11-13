defmodule Openflow.Multipart.Group.Reply do
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
    groups = Openflow.Multipart.Group.read(groups_bin)
    %Reply{groups: groups}
  end
end

defmodule Openflow.Multipart.Group do
  defstruct(
    group_id:      0,
    ref_count:     0,
    packet_count:  0,
    byte_count:    0,
    duration_sec:  0,
    duration_nsec: 0,
    bucket_stats:  []
  )

  @ofp_group_stats_size 40

  alias __MODULE__

  def read(binary) do
    do_read([], binary)
  end

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)
  defp do_read(acc, <<length::16, _binary::bytes>> = binary) do
    <<group_bin::size(length)-bytes, rest::bytes>> = binary
    do_read([codec(group_bin)|acc], rest)
  end

  defp codec(<<length::16, _::size(2)-unit(8),
               group_id::32, ref_count::32,
               _::size(4)-unit(8), packet_count::64,
               byte_count::64, duration_sec::32,
               duration_nsec::32, tail::bytes>>) do
    bucket_stats_size = length - @ofp_group_stats_size
    <<bucket_stats_bin::size(bucket_stats_size)-bytes, _rest::bytes>> = tail
    bucket_stats = for <<packet_count::64, byte_count::64 <- bucket_stats_bin>> do
      %{packet_count: packet_count, byte_count: byte_count}
    end
    %Group{group_id: group_id,
           ref_count: ref_count,
           packet_count: packet_count,
           byte_count: byte_count,
           duration_sec: duration_sec,
           duration_nsec: duration_nsec,
           bucket_stats: bucket_stats}
  end
end
