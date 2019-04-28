defmodule Openflow.PortStatus do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    reason: :add,
    port: nil
  )

  alias __MODULE__

  @type reason :: :add | :delete | :modify

  def ofp_type, do: 12

  def read(<<reason_int::8, _pad::size(7)-unit(8), port_bin::64-bytes>>) do
    reason = Openflow.Enums.to_atom(reason_int, :port_reason)
    port = Openflow.Port.read(port_bin)
    %PortStatus{reason: reason, port: port}
  end
end
