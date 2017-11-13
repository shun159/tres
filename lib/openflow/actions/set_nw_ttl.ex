defmodule Openflow.Action.SetNwTtl do
  defstruct(ttl: 0)

  alias __MODULE__

  def ofpat, do: 23

  def new(ttl) do
    %SetNwTtl{ttl: ttl}
  end

  def to_binary(%SetNwTtl{ttl: ttl}) do
    <<23::16, 8::16, ttl::8, 0::size(3)-unit(8)>>
  end

  def read(<<23::16, 8::16, ttl::8, _::size(3)-unit(8)>>) do
    %SetNwTtl{ttl: ttl}
  end
end
