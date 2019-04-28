defmodule Openflow.Instruction.Experimenter do
  defstruct(exp_id: 0, data: "")

  alias __MODULE__

  @type t :: %Experimenter{exp_id: 0..0xFFFFFFFF, data: binary()}

  @spec new(exp_id :: 0..0xFFFFFFFF, data :: String.t()) :: t()
  def new(exp_id, data \\ ""),
    do: %Experimenter{exp_id: exp_id, data: data}

  @spec to_binary(t()) :: <<_::64, _::_*8>>
  def to_binary(%Experimenter{exp_id: exp_id, data: data}) do
    length = 8 + byte_size(data)
    <<0xFFFF::16, length::16, exp_id::32, data::bytes>>
  end

  @spec read(<<_::64, _::_*8>>) :: t()
  def read(<<0xFFFF::16, _::16, exp_id::32, data::bytes>>) do
    %Experimenter{exp_id: exp_id, data: data}
  end
end
