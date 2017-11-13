defmodule Openflow.Multipart.Aggregate.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    flags:        [],
    packet_count: 0,
    byte_count:   0,
    flow_count:   0
  )

  alias __MODULE__

  def ofp_type, do: 18

  def read(<<packet_count::64, byte_count::64, flow_count::32, _::size(4)-unit(8)>>) do
    %Reply{packet_count: packet_count, byte_count: byte_count, flow_count: flow_count}
  end
end
