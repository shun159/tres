defmodule Openflow.Action.DecMplsTtl do
  defstruct([])

  alias __MODULE__

  def ofpat, do: 16

  def new do
    %DecMplsTtl{}
  end

  def to_binary(%DecMplsTtl{}) do
    <<16::16, 8::16, 0::size(4)-unit(8)>>
  end

  def read(<<16::16, 8::16, _::size(4)-unit(8)>>) do
    %DecMplsTtl{}
  end
end
