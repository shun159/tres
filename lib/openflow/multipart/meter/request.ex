defmodule Openflow.Multipart.Meter.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    flags: [],
    meter_id: :all
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(meter_id \\ :all) do
    %Request{meter_id: meter_id}
  end

  def read(<<meter_id_int::32, _::size(4)-unit(8)>>) do
    meter_id = Openflow.Utils.get_enum(meter_id_int, :meter_id)
    %Request{meter_id: meter_id}
  end

  def to_binary(%Request{meter_id: meter_id} = msg) do
    meter_id_int = Openflow.Utils.get_enum(meter_id, :meter_id)
    body_bin = <<meter_id_int::32, 0::size(4)-unit(8)>>
    header_bin = Openflow.Multipart.Request.header(msg)
    <<header_bin::bytes, body_bin::bytes>>
  end
end
