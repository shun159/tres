defmodule Openflow.Action.SetMplsTtl do
  @moduledoc """
  Replace the existing MPLS TTL.\\
  Only applies to the packets with an existing MPLS shim header.
  """

  defstruct(ttl: 0)

  alias __MODULE__

  @type t :: %SetMplsTtl{ttl: 0..0xFF}

  @spec ofpat() :: 15
  def ofpat, do: 15

  @doc """
  Create a set_mpls_ttl action structure

  ## Example:
  ```elixir
  iex> %SetMplsTtl{ttl: 64} = Openflow.Action.SetMplsTtl.new(64)
  ```
  """
  @deprecated "OFPAT_SET_MPLS_TTL is deprecated in OpenFlow13, use SetField"
  @spec new(0..0xFF) :: SetMplsTtl.t()
  def new(ttl) do
    %SetMplsTtl{ttl: ttl}
  end

  @spec to_binary(SetMplsTtl.t()) :: <<_::16, _::_*8>>
  def to_binary(%SetMplsTtl{ttl: ttl}) do
    <<15::16, 8::16, ttl::8, 0::size(3)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: SetMplsTtl.t()
  def read(<<15::16, 8::16, ttl::8, _::size(3)-unit(8)>>) do
    %SetMplsTtl{ttl: ttl}
  end
end
