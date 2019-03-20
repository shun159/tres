defmodule Openflow.Action.CopyTtlIn do
  @moduledoc """
  Copy the TTL from next-to-outermost to outermost header with TTL.\\
  Copy can be IP-to-IP, MPLS-to-MPLS, or IP-to-MPLS.
  """

  defstruct([])

  alias __MODULE__

  @type t :: %CopyTtlIn{}

  @spec ofpat() :: 12
  def ofpat, do: 12

  @doc """
  Create a copy_ttl_in action struct

  ## Example:
  ```elixir
  iex> %CopyTtlIn{} = Openflow.Action.CopyTtlIn.new()
  ```
  """
  @spec new() :: CopyTtlIn.t()
  def new do
    %CopyTtlIn{}
  end

  @spec to_binary(CopyTtlIn.t()) :: <<_::16, _::_*8>>
  def to_binary(%CopyTtlIn{}) do
    <<12::16, 8::16, 0::size(4)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: CopyTtlIn.t()
  def read(<<12::16, 8::16, _::size(4)-unit(8)>>) do
    %CopyTtlIn{}
  end
end
