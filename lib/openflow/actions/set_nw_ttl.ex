defmodule Openflow.Action.SetNwTtl do
  @moduledoc """
  Set IP TTL
  """

  defstruct(ttl: 0)

  alias __MODULE__

  @type t :: %SetNwTtl{ttl: 0..0xFF}

  @spec ofpat() :: 23
  def ofpat, do: 23

  @doc """
  Create a new set_nw_ttl action struct

  ## Options:
  - IP TTL

  ```elixir
  iex> %SetNwTtl{ttl: 64} = SetNwTtl.new(_ttl = 64)
  ```
  """
  @spec new(ttl :: 0..0xFF) :: t()
  def new(ttl) do
    %SetNwTtl{ttl: ttl}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%SetNwTtl{ttl: ttl}) do
    <<23::16, 8::16, ttl::8, 0::size(3)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<23::16, 8::16, ttl::8, _::size(3)-unit(8)>>) do
    %SetNwTtl{ttl: ttl}
  end
end
