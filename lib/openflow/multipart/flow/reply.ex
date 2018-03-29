defmodule Openflow.Multipart.Flow.Reply do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    aux_id: nil,
    flags: [],
    flows: []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(flows \\ []) do
    %Reply{flows: flows}
  end

  def read(<<flows_bin::bytes>>) do
    flows = Openflow.Multipart.FlowStats.read(flows_bin)
    %Reply{flows: flows}
  end

  def append_body(%Reply{flows: flows} = message, %Reply{flags: [:more], flows: continue}) do
    %{message | flows: [continue | flows]}
  end

  def append_body(%Reply{flows: flows} = message, %Reply{flags: [], flows: continue}) do
    new_flows =
      [continue | flows]
      |> Enum.reverse()
      |> List.flatten()

    %{message | flows: new_flows}
  end
end

defmodule Openflow.Multipart.FlowStats do
  defstruct(
    table_id: 0,
    duration_sec: 0,
    duration_nsec: 0,
    priority: 0,
    idle_timeout: 0,
    hard_timeout: 0,
    flags: 0,
    cookie: 0,
    packet_count: 0,
    byte_count: 0,
    match: [],
    instructions: []
  )

  alias __MODULE__

  def read(binary) do
    do_read([], binary)
  end

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)

  defp do_read(acc, <<length::16, _tail::bytes>> = binary) do
    <<flow_stats_bin::size(length)-bytes, rest::bytes>> = binary
    do_read([codec(flow_stats_bin) | acc], rest)
  end

  defp codec(
         <<_length::16, table_id_int::8, 0::8, duration_sec::32, duration_nsec::32, priority::16,
           idle::16, hard::16, flags_int::16, _::size(4)-unit(8), cookie::64, packet_count::64,
           byte_count::64, tail::bytes>>
       ) do
    {match, instructions_bin} = Openflow.Match.read(tail)
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    flags = Openflow.Enums.int_to_flags(flags_int, :flow_mod_flags)
    instructions = Openflow.Instruction.read(instructions_bin)

    %FlowStats{
      table_id: table_id,
      duration_sec: duration_sec,
      duration_nsec: duration_nsec,
      priority: priority,
      idle_timeout: idle,
      hard_timeout: hard,
      flags: flags,
      cookie: cookie,
      packet_count: packet_count,
      byte_count: byte_count,
      match: match,
      instructions: instructions
    }
  end
end
