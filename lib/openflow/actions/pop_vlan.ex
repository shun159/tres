defmodule Openflow.Action.PopVlan do
  defstruct([])

  alias __MODULE__

  def ofpat, do: 18

  def new do
    %PopVlan{}
  end

  def to_binary(%PopVlan{}) do
    <<18::16, 8::16, 0::size(4)-unit(8)>>
  end

  def read(<<18::16, 8::16, _::size(4)-unit(8)>>) do
    %PopVlan{}
  end
end
