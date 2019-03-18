defmodule Openflow.Action.NxResubmitTableCt do
  defstruct(in_port: :in_port, table_id: :all)

  @experimenter 0x00002320
  @nxast 44

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ [])

  def new(table_id) when is_atom(table_id) or is_integer(table_id) do
    new(table_id: table_id)
  end

  def new(options) when is_list(options) do
    in_port = options[:in_port] || :in_port
    table_id = options[:table_id] || :all
    %NxResubmitTableCt{in_port: in_port, table_id: table_id}
  end

  def to_binary(%NxResubmitTableCt{} = resubmit_table) do
    in_port_int = Openflow.Utils.get_enum(resubmit_table.in_port, :openflow10_port_no)
    table_id_int = Openflow.Utils.get_enum(resubmit_table.table_id, :table_id)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      in_port_int::16,
      table_id_int::8,
      0::24
    >>)
  end

  def read(
        <<@experimenter::32, @nxast::16, in_port_int::16, table_id_int::8, 0::size(3)-unit(8)>>
      ) do
    in_port = Openflow.Utils.get_enum(in_port_int, :openflow10_port_no)
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    %NxResubmitTableCt{in_port: in_port, table_id: table_id}
  end
end
