defmodule Openflow.GetAsync.Reply do
  defstruct(
    version:        4,
    xid:            0,
    datapath_id:  nil,  # virtual field
    aux_id:         0,  # virtual field
    packet_in_mask_master:    0,
    packet_in_mask_slave:     0,
    port_status_mask_master:  0,
    port_status_mask_slave:   0,
    flow_removed_mask_master: 0,
    flow_removed_mask_slave:  0
  )

  alias __MODULE__

  def ofp_type, do: 27

  def read(<<packet_in_mask_master::32, packet_in_mask_slave::32,
             port_status_mask_master::32, port_status_mask_slave::32,
             flow_removed_mask_master::32, flow_removed_mask_slave::32>>) do
    %Reply{packet_in_mask_master: packet_in_mask_master,
           packet_in_mask_slave: packet_in_mask_slave,
           port_status_mask_master: port_status_mask_master,
           port_status_mask_slave: port_status_mask_slave,
           flow_removed_mask_master: flow_removed_mask_master,
           flow_removed_mask_slave: flow_removed_mask_slave}
  end

  def to_binary(%Reply{packet_in_mask_master: packet_in_mask_master,
                       packet_in_mask_slave: packet_in_mask_slave,
                       port_status_mask_master: port_status_mask_master,
                       port_status_mask_slave: port_status_mask_slave,
                       flow_removed_mask_master: flow_removed_mask_master,
                       flow_removed_mask_slave: flow_removed_mask_slave}) do
    <<packet_in_mask_master::32, packet_in_mask_slave::32,
      port_status_mask_master::32, port_status_mask_slave::32,
      flow_removed_mask_master::32, flow_removed_mask_slave::32>>
  end
end
