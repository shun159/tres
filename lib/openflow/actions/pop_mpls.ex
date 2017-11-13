defmodule Openflow.Action.PopMpls do
  defstruct(ethertype: 0x8847)

  alias __MODULE__

  def ofpat, do: 20

  def new(ethertype) do
    %PopMpls{ethertype: ethertype}
  end

  def to_binary(%PopMpls{ethertype: ethertype}) do
    <<20::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>
  end

  def read(<<20::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>) do
    %PopMpls{ethertype: ethertype}
  end
end
