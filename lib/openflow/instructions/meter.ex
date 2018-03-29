defmodule Openflow.Instruction.Meter do
  defstruct(meter_id: 0)

  alias __MODULE__

  def new(meter_id) do
    %Meter{meter_id: meter_id}
  end

  def to_binary(%Meter{meter_id: meter_id}) do
    meter_id_int = Openflow.Utils.get_enum(meter_id, :meter_id)
    <<6::16, 8::16, meter_id_int::32>>
  end

  def read(<<6::16, _::16, meter_id_int::32>>) do
    meter_id = Openflow.Utils.get_enum(meter_id_int, :meter_id)
    %Meter{meter_id: meter_id}
  end
end
