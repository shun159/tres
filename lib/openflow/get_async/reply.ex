defmodule Openflow.GetAsync.Reply do
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

  @type t :: %Reply{
          version: 4,
          datapath_id: String.t() | nil,
          aux_id: 0..0xF,
          xid: 0..0xFFFFFFFF,
          packet_in_mask_master: [Openflow.Packet.reason()],
          packet_in_mask_slave: [Openflow.Packet.reason()],
          port_status_mask_master: [Openflow.Packet.reason()],
          port_status_mask_slave: [Openflow.Packet.reason()],
          flow_removed_mask_master: [Openflow.Packet.reason()],
          flow_removed_mask_slave: [Openflow.Packet.reason()]
        }

  @spec ofp_type() :: 27
  def ofp_type, do: 27

  @spec new(
          xid: 0..0xFFFFFFFF,
          packet_in_mask_master: [Openflow.Packet.reason()],
          packet_in_mask_slave: [Openflow.Packet.reason()],
          port_status_mask_master: [Openflow.Packet.reason()],
          port_status_mask_slave: [Openflow.Packet.reason()],
          flow_removed_mask_master: [Openflow.Packet.reason()],
          flow_removed_mask_slave: [Openflow.Packet.reason()]
        ) :: t()
  def new(options \\ []) do
    %Reply{
      xid: options[:xid] || 0,
      packet_in_mask_master: options[:packet_in_mask_master] || [],
      packet_in_mask_slave: options[:packet_in_mask_slave] || [],
      port_status_mask_master: options[:port_status_mask_master] || [],
      port_status_mask_slave: options[:port_status_mask_slave] || [],
      flow_removed_mask_master: options[:flow_removed_mask_master] || [],
      flow_removed_mask_slave: options[:flow_removed_mask_slave] || []
    }
  end

  @spec read(<<_::192>>) :: t()
  def read(<<
        pin_mask_master::32,
        pin_mask_slave::32,
        ps_mask_master::32,
        ps_mask_slave::32,
        fr_mask_master::32,
        fr_mask_slave::32
      >>) do
    %Reply{
      packet_in_mask_master: Enums.int_to_flags(pin_mask_master, :packet_in_reason_mask),
      packet_in_mask_slave: Enums.int_to_flags(pin_mask_slave, :packet_in_reason_mask),
      port_status_mask_master: Enums.int_to_flags(ps_mask_master, :port_reason_mask),
      port_status_mask_slave: Enums.int_to_flags(ps_mask_slave, :port_reason_mask),
      flow_removed_mask_master: Enums.int_to_flags(fr_mask_master, :flow_removed_reason_mask),
      flow_removed_mask_slave: Enums.int_to_flags(fr_mask_slave, :flow_removed_reason_mask)
    }
  end

  @spec to_binary(t()) :: <<_::192>>
  def to_binary(%Reply{
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
