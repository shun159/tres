defmodule Openflow.PacketOut do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id:      0,
    buffer_id:   :no_buffer,
    in_port:     :controller,
    actions:     [],
    data:        ""
  )

  alias __MODULE__

  def ofp_type, do: 13

  def new(options) do
    buffer_id = Keyword.get(options, :buffer_id, :no_buffer)
    in_port = Keyword.get(options, :in_port, :controller)
    actions = Keyword.get(options, :actions, [])
    data = Keyword.get(options, :data, "")
    %PacketOut{buffer_id: buffer_id,
               in_port: in_port,
               actions: actions,
               data:  data}
  end

  def read(<<buffer_id_int::32, in_port_int::32, actions_len::16, _pad::size(6)-unit(8),
             actions_bin::size(actions_len)-bytes, data::bytes>>) do
    buffer_id = Openflow.Utils.get_enum(buffer_id_int, :buffer_id)
    in_port = Openflow.Utils.get_enum(in_port_int, :openflow13_port_no)
    actions = Openflow.Action.read(actions_bin)
    %PacketOut{buffer_id: buffer_id,
               in_port: in_port,
               actions: actions,
               data:  data}
  end

  def to_binary(%PacketOut{} = packet_out) do
    %PacketOut{buffer_id: buffer_id,
               in_port: in_port,
               actions: actions,
               data:  data} = packet_out
    buffer_id_int = Openflow.Utils.get_enum(buffer_id, :buffer_id)
    in_port_int = Openflow.Utils.get_enum(in_port, :openflow13_port_no)
    actions_bin = Openflow.Action.to_binary(actions)
    actions_len = byte_size(actions_bin)
    <<buffer_id_int::32, in_port_int::32, actions_len::16, 0::size(6)-unit(8),
      actions_bin::size(actions_len)-bytes, data::bytes>>
  end
end
