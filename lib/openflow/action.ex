defmodule Openflow.Action do
  def read(action_bin) do
    do_read([], action_bin)
  end

  def to_binary(actions) when is_list(actions) do
    to_binary(<<>>, actions)
  end

  def to_binary(action) do
    to_binary([action])
  end

  # private functions

  defp do_read(acc, <<>>), do: Enum.reverse(acc)
  defp do_read(acc, <<0::32, _::bytes>>), do: Enum.reverse(acc)

  defp do_read(acc, <<type::16, length::16, _::bytes>> = binary) do
    <<action_bin::size(length)-bytes, rest::bytes>> = binary
    codec = Openflow.Enums.to_atom(type, :action_type)
    do_read([codec.read(action_bin) | acc], rest)
  end

  defp to_binary(acc, []), do: acc

  defp to_binary(acc, [action | rest]) do
    codec = action.__struct__
    to_binary(<<acc::bytes, codec.to_binary(action)::bytes>>, rest)
  end
end
