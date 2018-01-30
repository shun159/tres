defmodule Openflow.Features.Reply do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    n_buffers: 0,
    n_tables: 0,
    aux_id: 0,
    capabilities: []
  )

  alias __MODULE__

  def ofp_type, do: 6

  def read(
        <<datapath_id::64-bits, n_buf::32, n_tab::8, aux_id::8, _pad::16, caps_int::32, _rsv::32>>
      ) do
    dpid = Openflow.Utils.to_hex_string(datapath_id)
    flags = Openflow.Enums.int_to_flags(caps_int, :switch_capabilities)

    %Reply{
      datapath_id: dpid,
      n_buffers: n_buf,
      n_tables: n_tab,
      aux_id: aux_id,
      capabilities: flags
    }
  end

  def to_binary(%Reply{
        datapath_id: datapath_id,
        n_buffers: n_buf,
        n_tables: n_tab,
        aux_id: aux_id,
        capabilities: flags
      }) do
    dpid_int = String.to_integer(datapath_id, 16)
    flags_int = Openflow.Enums.flags_to_int(flags, :switch_capabilities)
    <<dpid_int::64, n_buf::32, n_tab::8, aux_id::8, 0::16, flags_int::32, 0::32>>
  end
end
