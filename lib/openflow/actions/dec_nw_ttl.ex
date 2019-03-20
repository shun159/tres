defmodule Openflow.Action.DecNwTtl do
  @moduledoc """
  """

  defstruct([])

  alias __MODULE__

  def ofpat, do: 24

  def new do
    %DecNwTtl{}
  end

  def to_binary(%DecNwTtl{}) do
    <<24::16, 8::16, 0::size(4)-unit(8)>>
  end

  def read(<<24::16, 8::16, _::size(4)-unit(8)>>) do
    %DecNwTtl{}
  end
end
