defmodule Openflow.Multipart.Queue.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    flags: [],
    port_number: :any,
    queue_id: :all
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(options) do
    port_no = Keyword.get(options, :port_number, :any)
    queue_id = Keyword.get(options, :queue_id, :all)
    %Request{port_number: port_no, queue_id: queue_id}
  end

  def read(<<port_no_int::32, queue_id_int::32>>) do
    port_no = Openflow.Utils.get_enum(port_no_int, :openflow13_port_no)
    queue_id = Openflow.Utils.get_enum(queue_id_int, :queue_id)
    %Request{port_number: port_no, queue_id: queue_id}
  end

  def to_binary(%Request{port_number: port_no, queue_id: queue_id} = msg) do
    port_no_int = Openflow.Utils.get_enum(port_no, :openflow13_port_no)
    queue_id_int = Openflow.Utils.get_enum(queue_id, :queue_id)
    body_bin = <<port_no_int::32, queue_id_int::32>>
    header_bin = Openflow.Multipart.Request.header(msg)
    <<header_bin::bytes, body_bin::bytes>>
  end
end
