defmodule Openflow.FlowRemoved do
  defstruct(
    version:       4,
    xid:           0,
    datapath_id:   "",
    aux_id:        0,
    cookie:        0,
    priority:      0,
    reason:        :idle_timeout,
    table_id:      0,
    duration_sec:  0,
    duration_nsec: 0,
    idle_timeout:  0,
    hard_timeout:  0,
    packet_count:  0,
    byte_count:    0,
    match:         []
  )

  alias __MODULE__

  def ofp_type, do: 11

  def read(<<cookie::64, priority::16, reason_int::8,
             table_id_int::8, dsec::32, dnsec::32,
             idle::16, hard::16, pkt::64, byt::64, rest::bytes>>) do
    reason = Openflow.Enums.to_atom(reason_int, :flow_removed_reason)
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    {match_fields, _rest} = Openflow.Match.read(rest)
    %FlowRemoved{cookie:        cookie,
                 priority:      priority,
                 reason:        reason,
                 table_id:      table_id,
                 duration_sec:  dsec,
                 duration_nsec: dnsec,
                 idle_timeout:  idle,
                 hard_timeout:  hard,
                 packet_count:  pkt,
                 byte_count:    byt,
                 match:         match_fields}
  end
end
