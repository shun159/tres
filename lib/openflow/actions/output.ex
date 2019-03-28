defmodule Openflow.Action.Output do
  @moduledoc """
  Action for sends packets out `port_number`.
  """

  defstruct port_number: 0,
            max_len: :no_buffer

  alias __MODULE__

  @type port_no ::
          0..0xFFFFFFFF
          | :max
          | :in_port
          | :table
          | :normal
          | :flood
          | :all
          | :controller
          | :local
          | :any

  @type max_len :: 0..0xFFFFFFFF | :no_buffer | :max

  @type t :: %Output{port_number: port_no(), max_len: max_len()}

  @spec ofpat() :: 0
  def ofpat, do: 0

  @doc """
  Create a new output action structure

  ## Options:
    - `port_number`: Output port
    - `max_len`: Max length to send to controller

  ## Example

  ```elixir
  iex> %Output{port_number: 1, max_len: :no_buffer} = Output.new(1)
  ```
  """
  @spec new([port_number: port_no, max_len: max_len()] | port_no()) :: Output.t()
  def new(options \\ [])

  @spec new(port :: port_no()) :: Output.t()
  def new(port) when is_atom(port) or is_integer(port),
    do: new(port_number: port)

  @spec new(options :: [port_number: port_no(), max_len: max_len()]) :: Output.t()
  def new(options) when is_list(options) do
    port_no = options[:port_number] || raise "port_number must be specified"
    max_len = options[:max_len] || :no_buffer
    %Output{port_number: port_no, max_len: max_len}
  end

  @spec to_binary(Output.t()) :: <<_::16, _::_*8>>
  def to_binary(%Output{port_number: port_no, max_len: max_len}) do
    port_no_int = Openflow.Utils.get_enum(port_no, :openflow13_port_no)
    max_len = Openflow.Utils.get_enum(max_len, :controller_max_len)
    <<0::16, 16::16, port_no_int::32, max_len::16, 0::size(6)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: Output.t()
  def read(<<0::16, 16::16, port_no_int::32, max_len::16, _pad::size(6)-unit(8)>>) do
    port_no = Openflow.Utils.get_enum(port_no_int, :openflow13_port_no)
    max_len = Openflow.Utils.get_enum(max_len, :controller_max_len)
    %Output{port_number: port_no, max_len: max_len}
  end
end
