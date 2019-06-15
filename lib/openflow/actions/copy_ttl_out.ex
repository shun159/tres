defmodule Openflow.Action.CopyTtlOut do
  @moduledoc """
  Copy the TTL from outermost to next-to-outermost header with TTL.\\
  Copy can be IP-to-IP, MPLS-to-MPLS, or MPLS-to-IP.
  """

  defstruct([])

  alias __MODULE__

  @type t :: %CopyTtlOut{}

  @spec ofpat() :: 11
  def ofpat, do: 11

  @doc """
  Create a copy_ttl_out action structure

  ## Example

  ```elixir
  iex> %CopyTtlOut{} = Openflow.Action.CopyTtlOut.new()
  ```
  """
  @spec new() :: CopyTtlOut.t()
  def new do
    %CopyTtlOut{}
  end

  @spec to_binary(CopyTtlIn.t()) :: <<_::16, _::_*8>>
  def to_binary(%CopyTtlOut{}) do
    <<11::16, 8::16, 0::size(4)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: CopyTtlOut.t()
  def read(<<11::16, 8::16, _::size(4)-unit(8)>>) do
    %CopyTtlOut{}
  end
end
