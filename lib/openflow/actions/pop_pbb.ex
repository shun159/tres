defmodule Openflow.Action.PopPbb do
  defstruct([])

  alias __MODULE__

  def ofpat, do: 27

  def new do
    %PopPbb{}
  end

  def to_binary(%PopPbb{}) do
    <<27::16, 8::16, 0::size(4)-unit(8)>>
  end

  def read(<<27::16, 8::16, _::size(4)-unit(8)>>) do
    %PopPbb{}
  end
end
