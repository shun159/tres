defmodule Openflow.Action.PushMpls do
  defstruct(ethertype: 0x8847)

  alias __MODULE__

  def ofpat, do: 19

  def new(ethertype) do
    %PushMpls{ethertype: ethertype}
  end

  def to_binary(%PushMpls{ethertype: ethertype}) do
    <<19::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>
  end

  def read(<<19::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>) do
    %PushMpls{ethertype: ethertype}
  end
end
