defmodule Openflow.Action.CopyTtlIn do
  defstruct([])

  alias __MODULE__

  def ofpat, do: 12

  def new do
    %CopyTtlIn{}
  end

  def to_binary(%CopyTtlIn{}) do
    <<12::16, 8::16, 0::size(4)-unit(8)>>
  end

  def read(<<12::16, 8::16, _::size(4)-unit(8)>>) do
    %CopyTtlIn{}
  end
end
