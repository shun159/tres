defmodule Openflow.Action.DecNwTtl do
  @moduledoc """
  Decrement IP TTL
  """

  defstruct([])

  alias __MODULE__

  @type t :: %DecNwTtl{}

  @spec ofpat() :: 24
  def ofpat, do: 24

  @doc """
  Create a new dec_nw_ttl action struct

  ```elixir
  iex> %DecNwTtl{} = DecNwTtl.new()
  ```
  """
  @spec new() :: t()
  def new do
    %DecNwTtl{}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%DecNwTtl{}) do
    <<24::16, 8::16, 0::size(4)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<24::16, 8::16, _::size(4)-unit(8)>>) do
    %DecNwTtl{}
  end
end
