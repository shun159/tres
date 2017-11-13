defmodule Openflow.Action.Output do
  defstruct(
    port_number: 0,
    max_len: :no_buffer
  )

  alias __MODULE__

  def ofpat, do: 0

  def new(port) when not is_list(port) do
    new(port_number: port)
  end
  def new(options) when is_list(options) do
    port_no = Keyword.get(options, :port_number)
    max_len = Keyword.get(options, :max_len, :no_buffer)
    %Output{port_number: port_no, max_len: max_len}
  end

  def to_binary(%Output{port_number: port_no, max_len: max_len}) do
    port_no_int = Openflow.Utils.get_enum(port_no, :openflow13_port_no)
    max_len = Openflow.Utils.get_enum(max_len, :controller_max_len)
    <<0::16, 16::16, port_no_int::32, max_len::16, 0::size(6)-unit(8)>>
  end

  def read(<<0::16, 16::16, port_no_int::32, max_len::16, _pad::size(6)-unit(8)>>) do
    port_no = Openflow.Utils.get_enum(port_no_int, :openflow13_port_no)
    max_len = Openflow.Utils.get_enum(max_len, :controller_max_len)
    %Output{port_number: port_no, max_len: max_len}
  end
end
