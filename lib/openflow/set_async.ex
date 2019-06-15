defmodule Openflow.SetAsync do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    # virtual field
    aux_id: 0,
    packet_in_mask_master: [],
    packet_in_mask_slave: [],
    port_status_mask_master: [],
    port_status_mask_slave: [],
    flow_removed_mask_master: [],
    flow_removed_mask_slave: []
  )

  alias __MODULE__
  alias Openflow.Enums

  def ofp_type, do: 28

  def new(options \\ []) do
    %SetAsync{
      xid: Keyword.get(options, :xid, 0),
      packet_in_mask_master: Keyword.get(options, :packet_in_mask_master, []),
      packet_in_mask_slave: Keyword.get(options, :packet_in_mask_slave, []),
      port_status_mask_master: Keyword.get(options, :port_status_mask_master, []),
      port_status_mask_slave: Keyword.get(options, :port_status_mask_slave, []),
      flow_removed_mask_master: Keyword.get(options, :flow_removed_mask_master, []),
      flow_removed_mask_slave: Keyword.get(options, :flow_removed_mask_slave, [])
    }
  end

  def to_binary(%SetAsync{
        packet_in_mask_master: pin_mask_master,
        packet_in_mask_slave: pin_mask_slave,
        port_status_mask_master: ps_mask_master,
        port_status_mask_slave: ps_mask_slave,
        flow_removed_mask_master: fr_mask_master,
        flow_removed_mask_slave: fr_mask_slave
      }) do
    <<
      Enums.flags_to_int(pin_mask_master, :packet_in_reason_mask)::32,
      Enums.flags_to_int(pin_mask_slave, :packet_in_reason_mask)::32,
      Enums.flags_to_int(ps_mask_master, :port_reason_mask)::32,
      Enums.flags_to_int(ps_mask_slave, :port_reason_mask)::32,
      Enums.flags_to_int(fr_mask_master, :flow_removed_reason_mask)::32,
      Enums.flags_to_int(fr_mask_slave, :flow_removed_reason_mask)::32
    >>
  end
end
