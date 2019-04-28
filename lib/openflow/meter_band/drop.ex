defmodule Openflow.MeterBand.Drop do
  defstruct(
    rate: 0,
    burst_size: 0
  )

  alias __MODULE__

  @type t :: %Drop{rate: 0..0xFFFFFFFF, burst_size: 0..0xFFFFFFFF}

  @spec new(rate: 0..0xFFFFFFFF, burst_size: 0..0xFFFFFFFF) :: t()
  def new(options),
    do: %Drop{rate: options[:rate] || 0, burst_size: options[:burst_size] || 0}

  @spec read(<<_::128>>) :: t()
  def read(<<1::16, 16::16, rate::32, burst_size::32, _::size(4)-unit(8)>>),
    do: %Drop{rate: rate, burst_size: burst_size}

  @spec to_binary(t()) :: <<_::128>>
  def to_binary(%Drop{rate: rate, burst_size: burst_size}),
    do: <<1::16, 16::16, rate::32, burst_size::32, 0::size(4)-unit(8)>>
end
