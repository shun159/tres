defmodule Openflow.Action.DecMplsTtl do
  @moduledoc """
  Decrement MPLS TTL action
  """

  defstruct([])

  alias __MODULE__

  @type t :: %DecMplsTtl{}

  @spec ofpat() :: 16
  def ofpat, do: 16

  @doc """
  Create a new dec_mpls_ttl action struct.

  Note: Need to be specified the one of `ETH_P_MPLS_*` on `eth_type` match field when using this action.

  ## Example:

  ````elixir
  iex> %DecMplsTtl{} = DecMplsTtl.new()
  ````
  """
  @spec new() :: t()
  def new do
    %DecMplsTtl{}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%DecMplsTtl{}) do
    <<16::16, 8::16, 0::size(4)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<16::16, 8::16, _::size(4)-unit(8)>>) do
    %DecMplsTtl{}
  end
end
