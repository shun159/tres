defmodule Openflow.Action.PopVlan do
  @moduledoc """
  Pop the outer VLAN tag.
  """

  defstruct([])

  alias __MODULE__

  @type t() :: %PopVlan{}

  @spec ofpat() :: 18
  def ofpat, do: 18

  @doc """
  Create a new pop_vlan action struct

  ````elixir
  iex> %PopVlan{} = PopVlan.new()
  ````
  """
  @spec new() :: t()
  def new do
    %PopVlan{}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%PopVlan{}) do
    <<18::16, 8::16, 0::size(4)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<18::16, 8::16, _::size(4)-unit(8)>>) do
    %PopVlan{}
  end
end
