defmodule Openflow.NxPacketIn2 do
  defstruct(
    version:        4,
    xid:            0,
    datapath_id:   "",
    aux_id:         0,
    # packet_in properties:
    packet:       nil,
    full_len:     nil,
    buffer_id:    nil,
    table_id:     nil,
    cookie:       nil,
    reason:       nil,
    metadata:     nil,
    userdata:     nil,
    continuation: nil,
    # continuation properties:
    continuation_bridge:      nil,
    continuation_stack:       nil,
    continuation_conntracked: nil,
    continuation_table_id:    nil,
    continuation_cookie:      nil,
    continuation_actions:     nil,
    continuation_action_set:  nil
  )

  alias __MODULE__

  @experimenter 0x00002320
  @nx_type 30

  def ofp_type, do: 4

end
