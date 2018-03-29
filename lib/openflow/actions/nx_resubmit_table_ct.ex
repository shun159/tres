defmodule Openflow.Action.NxResubmitTableCt do
  defstruct(in_port: :in_port, table_id: :all)

  @experimenter 0x00002320
  @nxast 44

  alias __MODULE__

  def new(options) do
    in_port = Keyword.get(options, :in_port, :in_port)
    table_id = Keyword.get(options, :table_id, :all)
    %NxResubmitTableCt{in_port: in_port, table_id: table_id}
  end

  def to_binary(%NxResubmitTableCt{in_port: in_port, table_id: table_id}) do
    in_port_int = Openflow.Utils.get_enum(in_port, :openflow10_port_no)
    table_id_int = Openflow.Utils.get_enum(table_id, :table_id)
    exp_body = <<@experimenter::32, @nxast::16, in_port_int::16, table_id_int::8, 0::24>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(
        <<@experimenter::32, @nxast::16, in_port_int::16, table_id_int::8, 0::size(3)-unit(8)>>
      ) do
    in_port = Openflow.Utils.get_enum(in_port_int, :openflow10_port_no)
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    %NxResubmitTableCt{in_port: in_port, table_id: table_id}
  end
end
