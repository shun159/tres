defmodule Openflow.Instruction.Experimenter do
  defstruct(exp_id: 0, data: "")

  alias __MODULE__

  def new(exp_id, data \\ "") do
    %Experimenter{exp_id: exp_id, data: data}
  end

  def to_binary(%Experimenter{exp_id: exp_id, data: data}) do
    length = 8 + byte_size(data)
    <<0xffff::16, length::16, exp_id::32, data::bytes>>
  end

  def read(<<0xffff::16, _::16, exp_id::32, data::bytes>>) do
    %Experimenter{exp_id: exp_id, data: data}
  end
end
