defmodule Openflow.MeterBand.Drop do
  defstruct(
    rate:       0,
    burst_size: 0
  )

  alias __MODULE__

  def new(options) do
    rate = Keyword.get(options, :rate, 0)
    burst_size = Keyword.get(options, :burst_size, 0)
    %Drop{rate: rate, burst_size: burst_size}
  end

  def read(<<1::16, 16::16, rate::32, burst_size::32, _::size(4)-unit(8)>>) do
    %Drop{rate: rate, burst_size: burst_size}
  end

  def to_binary(%Drop{rate: rate, burst_size: burst_size}) do
    <<1::16, 16::16, rate::32, burst_size::32, 0::size(4)-unit(8)>>
  end
end
