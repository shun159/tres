defmodule Openflow.Action.PopMpls do
  @moduledoc """
  Pop the out MPLS label

  note: The one of ETH__P_MPLS_* is needed to be specified to eth_type field
  """

  defstruct(ethertype: 0x8847)

  alias __MODULE__

  @type t :: %PopMpls{}

  @eth_p_mpls_uc 0x8847

  @spec ofpat() :: 20
  def ofpat, do: 20

  @doc """
  Create a new pop_mpls action struct

  note: 0x8847(ETH_P_MPLS_UC) as default value.

  ```elixir
  iex> %PopMpls{ethertype: 0x8847} = PopMpls.new()
  ```
  """
  @spec new() :: t()
  @spec new(ethertype :: 0..0xFFFF) :: t()
  def new(ethertype \\ @eth_p_mpls_uc) do
    %PopMpls{ethertype: ethertype}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%PopMpls{ethertype: ethertype}) do
    <<20::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<20::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>) do
    %PopMpls{ethertype: ethertype}
  end
end
