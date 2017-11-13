defmodule Openflow.Action.NxFlowSpec do

  def read(flow_spec_bin) do
    do_read([], flow_spec_bin)
  end

  def to_binary(flow_specs) when is_list(flow_specs) do
    to_binary(<<>>, flow_specs)
  end
  def to_binary(flow_spec) do
    to_binary([flow_spec])
  end

  # private functions

  defp do_read(acc, <<>>), do: Enum.reverse(acc)
  defp do_read(acc, <<0::16, _::bitstring>>), do: Enum.reverse(acc)
  defp do_read(acc, <<_::2, _::1, type::2, _::bitstring>> = binary) do
    codec = Openflow.Enums.to_atom(type, :nx_flow_spec_type)
    {flow_spec, rest} = codec.read(binary)
    do_read([flow_spec|acc], rest)
  end

  defp to_binary(acc, []), do: acc
  defp to_binary(acc, [flow_spec|rest]) do
    codec = flow_spec.__struct__
    to_binary(<<acc::bytes, (codec.to_binary(flow_spec))::bytes>>, rest)
  end
end
