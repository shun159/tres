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

  @type t :: %Reply{
          version: 4,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFF | nil,
          xid: 0..0xFFFFFFFF,
          flags: [:more],
          flows: [Openflow.Multipart.FlowStats.t()]
        }

  @spec ofp_type() :: 19
  def ofp_type, do: 19

  @spec read(<<_::16, _::_*384>>) :: t()
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

  @type t :: %FlowStats{
          table_id: 0..0xFF,
          duration_sec: 0..0xFFFFFFFF,
          duration_nsec: 0..0xFFFFFFFF,
          priority: 0..0xFFFF,
          idle_timeout: 0..0xFFFF,
          hard_timeout: 0..0xFFFF,
          flags: [:send_flow_rem | :delete_learned | :write_result],
          cookie: 0..0xFFFFFFFFFFFFFFFF,
          packet_count: 0..0xFFFFFFFFFFFFFFFF,
          byte_count: 0..0xFFFFFFFFFFFFFFFF,
          match: Openflow.Match.new(),
          instructions: [Openflow.Instruction.instruction()]
        }

  @spec read(<<_::_*8>>) :: [t()]
  def read(binary), do: do_read([], binary)

  # private functions

  @spec do_read(acc :: [t()], binary()) :: [t()]
  defp do_read(acc, ""), do: acc

  @spec do_read(acc :: [t()], <<_::16, _::_*8>>) :: [t()]
  defp do_read(acc, <<length::16, _tail::bytes>> = binary) do
    <<flow_stats_bin::size(length)-bytes, rest::bytes>> = binary
    do_read(acc ++ [codec(flow_stats_bin)], rest)
  end

  defp codec(<<
         _length::16,
         table_id::8,
         0::8,
         duration_sec::32,
         duration_nsec::32,
         priority::16,
         idle::16,
         hard::16,
         flags_int::16,
         _::size(4)-unit(8),
         cookie::64,
         packet_count::64,
         byte_count::64,
         tail::bytes
       >>) do
    flags = Openflow.Enums.int_to_flags(flags_int, :flow_mod_flags)
    {match, instructions_bin} = Openflow.Match.read(tail)
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
