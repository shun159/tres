defmodule Openflow.Action.CopyTtlOut do
  defstruct([])

  alias __MODULE__

  def ofpat, do: 11

  def new do
    %CopyTtlOut{}
  end

  def to_binary(%CopyTtlOut{}) do
    <<11::16, 8::16, 0::size(4)-unit(8)>>
  end

  def read(<<11::16, 8::16, _::size(4)-unit(8)>>) do
    %CopyTtlOut{}
  end
end
