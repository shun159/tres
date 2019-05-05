defmodule Openflow.Multipart.Group.Reply do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    aux_id: nil,
    flags: [],
    groups: []
  )

  alias __MODULE__

  @type t :: %Reply{
          version: 4,
          xid: 0..0xFFFFFFFF,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFF | nil,
          flags: [:more],
          groups: [Openflow.Multipart.GroupStats.t()]
        }

  @spec ofp_type() :: 18
  def ofp_type, do: 18

  @spec read(binary()) :: t()
  def read(<<groups_bin::bytes>>) do
    groups = Openflow.Multipart.GroupStats.read(groups_bin)
    %Reply{groups: groups}
  end

  def append_body(%Reply{groups: groups} = message, %Reply{flags: [:more], groups: continue}) do
    %{message | groups: [continue | groups]}
  end

  def append_body(%Reply{groups: groups} = message, %Reply{flags: [], groups: continue}) do
    new_groups =
      [continue | groups]
      |> Enum.reverse()
      |> List.flatten()

    %{message | groups: new_groups}
  end
end

defmodule Openflow.Multipart.GroupStats do
  defstruct(
    group_id: 0,
    ref_count: 0,
    packet_count: 0,
    byte_count: 0,
    duration_sec: 0,
    duration_nsec: 0,
    bucket_stats: []
  )

  @ofp_group_stats_size 40

  alias __MODULE__

  @type t :: %GroupStats{
          group_id: 0..0xFFFFFFFF,
          ref_count: 0..0xFFFFFFFF,
          packet_count: 0..0xFFFFFFFFFFFFFFFF,
          byte_count: 0..0xFFFFFFFFFFFFFFFF,
          duration_sec: 0..0xFFFFFFFF,
          duration_nsec: 0..0xFFFFFFFF
        }

  def read(binary) do
    do_read([], binary)
  end

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)

  defp do_read(acc, <<length::16, _binary::bytes>> = binary) do
    <<group_bin::size(length)-bytes, rest::bytes>> = binary
    do_read([codec(group_bin) | acc], rest)
  end

  defp codec(
         <<length::16, _::size(2)-unit(8), group_id::32, ref_count::32, _::size(4)-unit(8),
           packet_count::64, byte_count::64, duration_sec::32, duration_nsec::32, tail::bytes>>
       ) do
    bucket_stats_size = length - @ofp_group_stats_size
    <<bucket_stats_bin::size(bucket_stats_size)-bytes, _rest::bytes>> = tail

    bucket_stats =
      for <<packet_count::64, byte_count::64 <- bucket_stats_bin>>,
        do: %{packet_count: packet_count, byte_count: byte_count}

    %GroupStats{
      group_id: group_id,
      ref_count: ref_count,
      packet_count: packet_count,
      byte_count: byte_count,
      duration_sec: duration_sec,
      duration_nsec: duration_nsec,
      bucket_stats: bucket_stats
    }
  end
end
