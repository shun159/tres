defmodule Openflow.FlowMod do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    cookie: 0,
    cookie_mask: 0,
    table_id: 0,
    command: :add,
    idle_timeout: 0,
    hard_timeout: 0,
    priority: 0,
    buffer_id: :no_buffer,
    out_port: :any,
    out_group: :any,
    flags: [],
    match: [],
    instructions: []
  )

  alias __MODULE__

  def ofp_type, do: 14

  def new(options \\ []) do
    xid = Keyword.get(options, :xid, 0)
    cookie = Keyword.get(options, :cookie, 0)
    cookie_mask = Keyword.get(options, :cookie_mask, 0)
    table_id = Keyword.get(options, :table_id, 0)
    command = Keyword.get(options, :command, :add)
    idle = Keyword.get(options, :idle_timeout, 0)
    hard = Keyword.get(options, :hard_timeout, 0)
    priority = Keyword.get(options, :priority, 0)
    buffer_id = Keyword.get(options, :buffer_id, :no_buffer)
    out_port = Keyword.get(options, :out_port, :any)
    out_group = Keyword.get(options, :out_group, :any)
    flags = Keyword.get(options, :flags, [])
    match = Keyword.get(options, :match, Openflow.Match.new())
    instructions = Keyword.get(options, :instructions, [])

    %FlowMod{
      xid: xid,
      cookie: cookie,
      cookie_mask: cookie_mask,
      priority: priority,
      table_id: table_id,
      command: command,
      idle_timeout: idle,
      hard_timeout: hard,
      buffer_id: buffer_id,
      out_port: out_port,
      out_group: out_group,
      flags: flags,
      match: match,
      instructions: instructions
    }
  end

  def read(
        <<cookie::64, cookie_mask::64, table_id_int::8, command_int::8, idle::16, hard::16,
          prio::16, buffer_id_int::32, out_port_int::32, out_group_int::32, flags_int::16,
          _::size(2)-unit(8), rest::bytes>>
      ) do
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    command = Openflow.Utils.get_enum(command_int, :flow_mod_command)
    buffer_id = Openflow.Utils.get_enum(buffer_id_int, :buffer_id)
    out_port = Openflow.Utils.get_enum(out_port_int, :openflow13_port_no)
    out_group = Openflow.Utils.get_enum(out_group_int, :group_id)
    flags = Openflow.Enums.int_to_flags(flags_int, :flow_mod_flags)
    {match_fields, instructions_bin} = Openflow.Match.read(rest)
    match = Openflow.Match.new(match_fields)
    instructions = Openflow.Instruction.read(instructions_bin)

    %FlowMod{
      cookie: cookie,
      cookie_mask: cookie_mask,
      priority: prio,
      table_id: table_id,
      command: command,
      idle_timeout: idle,
      hard_timeout: hard,
      buffer_id: buffer_id,
      out_port: out_port,
      out_group: out_group,
      flags: flags,
      match: match,
      instructions: instructions
    }
  end

  def to_binary(flow_mod) do
    %FlowMod{
      cookie: cookie,
      cookie_mask: cookie_mask,
      priority: prio,
      table_id: table_id,
      command: command,
      idle_timeout: idle,
      hard_timeout: hard,
      buffer_id: buffer_id,
      out_port: out_port,
      out_group: out_group,
      flags: flags,
      match: match_fields,
      instructions: instructions
    } = flow_mod

    table_id_int = Openflow.Utils.get_enum(table_id, :table_id)
    command_int = Openflow.Utils.get_enum(command, :flow_mod_command)
    buffer_id_int = Openflow.Utils.get_enum(buffer_id, :buffer_id)
    out_port_int = Openflow.Utils.get_enum(out_port, :openflow13_port_no)
    out_group_int = Openflow.Utils.get_enum(out_group, :group_id)
    flags_int = Openflow.Enums.flags_to_int(flags, :flow_mod_flags)
    match_fields_bin = Openflow.Match.to_binary(match_fields)
    instructions_bin = Openflow.Instruction.to_binary(instructions)

    <<cookie::64, cookie_mask::64, table_id_int::8, command_int::8, idle::16, hard::16, prio::16,
      buffer_id_int::32, out_port_int::32, out_group_int::32, flags_int::16, 0::size(2)-unit(8),
      match_fields_bin::bytes, instructions_bin::bytes>>
  end
end
