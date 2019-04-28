defmodule Openflow.Instruction do
  @moduledoc """
  Openflow instruction codec handler
  """

  @type instruction ::
          Openflow.Instruction.ApplyActions.t()
          | Openflow.Instruction.WriteActions.t()
          | Openflow.Instruction.ClearActions.t()
          | Openflow.Instruction.GotoTable.t()
          | Openflow.Instruction.WriteMetadata.t()
          | Openflow.Instruction.Meter.t()

  @spec read(<<_::32, _::_*8>>) :: [instruction()]
  def read(instruction_bin),
    do: do_read([], instruction_bin)

  @spec to_binary(instruction()) :: <<_::32, _::_*8>>
  def to_binary(instructions) when is_list(instructions),
    do: to_binary(<<>>, instructions)

  @spec to_binary([instruction()]) :: <<_::32, _::_*8>>
  def to_binary(instruction),
    do: to_binary([instruction])

  # private functions

  @spec do_read([instruction()], <<_::_*8>>) :: [instruction()]
  defp do_read(acc, <<>>), do: Enum.reverse(acc)

  defp do_read(acc, <<type::16, length::16, _::bytes>> = binary) do
    <<instruction_bin::size(length)-bytes, rest::bytes>> = binary
    codec = Openflow.Enums.to_atom(type, :instruction_type)
    do_read([codec.read(instruction_bin) | acc], rest)
  end

  @spec to_binary(<<_::_*8>>) :: [instruction()]
  defp to_binary(acc, []), do: acc

  defp to_binary(acc, [instruction | rest]) do
    codec = instruction.__struct__
    to_binary(<<acc::bytes, codec.to_binary(instruction)::bytes>>, rest)
  end
end
