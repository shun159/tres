defmodule Openflow.TableMod do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    table_id: 0,
    config: 0
  )

  alias __MODULE__

  def ofp_type, do: 17

  def new(table_id) do
    %TableMod{table_id: table_id}
  end

  def read(<<table_id_int::8, _::size(3)-unit(8), config::32>>) do
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    %TableMod{table_id: table_id, config: config}
  end

  def to_binary(%TableMod{table_id: table_id, config: config}) do
    table_id_int = Openflow.Utils.get_enum(table_id, :table_id)
    <<table_id_int::8, 0::size(3)-unit(8), config::32>>
  end
end
