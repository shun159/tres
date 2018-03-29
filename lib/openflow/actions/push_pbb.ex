defmodule Openflow.Action.PushPbb do
  defstruct(ethertype: 0x88E7)

  alias __MODULE__

  def ofpat, do: 26

  def new(ethertype) do
    %PushPbb{ethertype: ethertype}
  end

  def to_binary(%PushPbb{ethertype: ethertype}) do
    <<26::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>
  end

  def read(<<26::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>) do
    %PushPbb{ethertype: ethertype}
  end
end
