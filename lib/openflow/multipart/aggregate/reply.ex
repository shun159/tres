defmodule Openflow.Multipart.Aggregate.Reply do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    aux_id: nil,
    flags: [],
    packet_count: 0,
    byte_count: 0,
    flow_count: 0
  )

  alias __MODULE__

  @type t :: %Reply{
          version: 4,
          xid: 0..0xFFFFFFFF,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFF,
          flags: [],
          packet_count: 0..0xFFFFFFFFFFFFFFFF,
          byte_count: 0..0xFFFFFFFFFFFFFFFF,
          flow_count: 0..0xFFFFFFFF
        }

  @spec ofp_type() :: 19
  def ofp_type, do: 19

  @spec new(
          xid: 0..0xFFFFFFFF,
          flags: [],
          packet_count: 0..0xFFFFFFFFFFFFFFFF,
          byte_count: 0..0xFFFFFFFFFFFFFFFF,
          flow_count: 0..0xFFFFFFFF
        ) :: t()
  def new(options \\ []) do
    %Reply{
      xid: options[:xid] || 0,
      flags: options[:flags] || [],
      packet_count: options[:packet_count] || 0,
      byte_count: options[:byte_count] || 0,
      flow_count: options[:flow_count] || 0
    }
  end

  @spec to_binary(t()) :: <<_::64, _::_*8>>
  def to_binary(aggregate) do
    <<
      Openflow.Multipart.Reply.header(aggregate)::bytes,
      aggregate.packet_count::64,
      aggregate.byte_count::64,
      aggregate.flow_count::32,
      0::size(4)-unit(8)
    >>
  end

  @spec read(<<_::192>>) :: t()
  def read(<<
        packet_count::64,
        byte_count::64,
        flow_count::32,
        _::size(4)-unit(8)
      >>) do
    %Reply{
      packet_count: packet_count,
      byte_count: byte_count,
      flow_count: flow_count
    }
  end
end
