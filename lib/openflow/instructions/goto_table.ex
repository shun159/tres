defmodule Openflow.Instruction.GotoTable do
  defstruct(table_id: 0)

  alias __MODULE__

  @type t :: %GotoTable{table_id: 0..0xFF}

  @spec new(table_id :: 0..0xFF) :: t()
  def new(table_id), do: %GotoTable{table_id: table_id}

  @spec to_binary(t()) :: <<_::64>>
  def to_binary(%GotoTable{table_id: table_id}) do
    table_id_int = Openflow.Utils.get_enum(table_id, :table_id)
    <<1::16, 8::16, table_id_int::8, 0::size(3)-unit(8)>>
  end

  @spec read(<<_::64>>) :: t()
  def read(<<1::16, 8::16, table_id_int::8, _::size(3)-unit(8)>>) do
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    %GotoTable{table_id: table_id}
  end
end
