defmodule Openflow.Action.SetMplsTtl do
  defstruct(ttl: 0)

  alias __MODULE__

  def ofpat, do: 15

  def new(ttl) do
    %SetMplsTtl{ttl: ttl}
  end

  def to_binary(%SetMplsTtl{ttl: ttl}) do
    <<15::16, 8::16, ttl::8, 0::size(3)-unit(8)>>
  end

  def read(<<15::16, 8::16, ttl::8, _::size(3)-unit(8)>>) do
    %SetMplsTtl{ttl: ttl}
  end
end
