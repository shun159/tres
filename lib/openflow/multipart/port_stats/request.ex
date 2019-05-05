defmodule Openflow.Multipart.Port.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    flags: [],
    port_number: :any
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(options \\ []) do
    %Request{
      xid: options[:xid] || 0,
      port_number: options[:port_no] || :any
    }
  end

  def read(<<port_no_int::32, _::size(4)-unit(8)>>) do
    port_no = Openflow.Utils.get_enum(port_no_int, :openflow13_port_no)
    %Request{port_number: port_no}
  end

  def to_binary(%Request{port_number: port_no} = msg) do
    port_no_int = Openflow.Utils.get_enum(port_no, :openflow13_port_no)
    body_bin = <<port_no_int::32, 0::size(4)-unit(8)>>
    header_bin = Openflow.Multipart.Request.header(msg)
    <<header_bin::bytes, body_bin::bytes>>
  end
end
