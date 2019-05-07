defmodule Openflow.PacketIn do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    buffer_id: :no_buffer,
    total_len: 0,
    reason: :no_match,
    table_id: 0,
    cookie: 0,
    in_port: :controller,
    match: [],
    data: ""
  )

  alias __MODULE__

  @type reason :: :no_match | :action | :invalid_ttl | :action_set | :group | :packet_out

  def ofp_type, do: 10

  def read(
        <<buffer_id_int::32, total_len::16, reason_int::8, table_id_int::8, cookie::64,
          rest0::bytes>>
      ) do
    buffer_id = Openflow.Utils.get_enum(buffer_id_int, :buffer_id)
    reason = Openflow.Utils.get_enum(reason_int, :packet_in_reason)
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    {match_fields0, rest1} = Openflow.Match.read(rest0)
    <<_pad::size(2)-unit(8), data::bytes>> = rest1
    in_port = Keyword.get(match_fields0, :in_port, :any)
    match_fields = Keyword.delete(match_fields0, :in_port)

    %PacketIn{
      buffer_id: buffer_id,
      total_len: total_len,
      reason: reason,
      table_id: table_id,
      cookie: cookie,
      in_port: in_port,
      match: match_fields,
      data: data
    }
  end
end
