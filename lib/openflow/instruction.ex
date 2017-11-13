defmodule Openflow.Instruction do

  def read(instruction_bin) do
    do_read([], instruction_bin)
  end

  def to_binary(instructions) when is_list(instructions) do
    to_binary(<<>>, instructions)
  end
  def to_binary(instruction) do
    to_binary([instruction])
  end

  # private functions

  defp do_read(acc, <<>>), do: Enum.reverse(acc)
  defp do_read(acc, <<type::16, length::16, _::bytes>> = binary) do
    <<instruction_bin::size(length)-bytes, rest::bytes>> = binary
    codec = Openflow.Enums.to_atom(type, :instruction_type)
    do_read([codec.read(instruction_bin)|acc], rest)
  end

  defp to_binary(acc, []), do: acc
  defp to_binary(acc, [instruction|rest]) do
    codec = instruction.__struct__
    to_binary(<<acc::bytes, (codec.to_binary(instruction))::bytes>>, rest)
  end
end
