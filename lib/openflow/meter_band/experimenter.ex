defmodule Openflow.MeterBand.Experimenter do
  defstruct(
    rate:         0,
    burst_size:   0,
    experimenter: 0
  )

  alias __MODULE__

  def new(options) do
    rate = Keyword.get(options, :rate, 0)
    burst_size = Keyword.get(options, :burst_size, 0)
    experimenter = Keyword.get(options, :experimenter, 0)
    %Experimenter{rate: rate, burst_size: burst_size, experimenter: experimenter}
  end

  def read(<<0xffff::16, _::16, rate::32, burst_size::32, experimenter::32>>) do
    %Experimenter{rate: rate, burst_size: burst_size, experimenter: experimenter}
  end

  def to_binary(%Experimenter{rate: rate, burst_size: burst_size, experimenter: experimenter}) do
    <<0xffff::16, 16::16, rate::32, burst_size::32, experimenter::32>>
  end
end
