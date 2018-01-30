defmodule Openflow.MeterBand.Remark do
  defstruct(
    rate: 0,
    burst_size: 0,
    prec_level: 0
  )

  alias __MODULE__

  def new(options) do
    rate = Keyword.get(options, :rate, 0)
    burst_size = Keyword.get(options, :burst_size, 0)
    prec_level = Keyword.get(options, :prec_level, 0)
    %Remark{rate: rate, burst_size: burst_size, prec_level: prec_level}
  end

  def read(<<2::16, 16::16, rate::32, burst_size::32, prec_level::8, _::size(3)-unit(8)>>) do
    %Remark{rate: rate, burst_size: burst_size, prec_level: prec_level}
  end

  def to_binary(%Remark{rate: rate, burst_size: burst_size, prec_level: prec_level}) do
    <<2::16, 16::16, rate::32, burst_size::32, prec_level::8, 0::size(3)-unit(8)>>
  end
end
