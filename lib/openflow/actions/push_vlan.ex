defmodule Openflow.Action.PushVlan do
  defstruct(ethertype: 0x8100)

  alias __MODULE__

  def ofpat, do: 17

  def new(ethertype \\ 0x8100) do
    %PushVlan{ethertype: ethertype}
  end

  def to_binary(%PushVlan{ethertype: ethertype}) do
    <<17::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>
  end

  def read(<<17::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>) do
    %PushVlan{ethertype: ethertype}
  end
end
