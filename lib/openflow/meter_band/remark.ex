defmodule Openflow.MeterBand.Remark do
  defstruct(
    rate: 0,
    burst_size: 0,
    prec_level: 0
  )

  alias __MODULE__

  @type t :: %Remark{
          rate: 0..0xFFFFFFFF,
          burst_size: 0..0xFFFFFFFF,
          prec_level: 0..0xFF
        }

  @spec new(
          rate: 0..0xFFFFFFFF,
          burst_size: 0..0xFFFFFFFF,
          prec_level: 0..0xFF
        ) :: t()
  def new(options) do
    %Remark{
      rate: options[:rate] || 0,
      burst_size: options[:burst_size] || 0,
      prec_level: options[:prec_level] || 0
    }
  end

  @spec read(<<_::128>>) :: t()
  def read(<<2::16, 16::16, rate::32, burst_size::32, prec_level::8, _::size(3)-unit(8)>>),
    do: %Remark{rate: rate, burst_size: burst_size, prec_level: prec_level}

  @spec to_binary(t()) :: <<_::128>>
  def to_binary(%Remark{rate: rate, burst_size: burst_size, prec_level: prec_level}),
    do: <<2::16, 16::16, rate::32, burst_size::32, prec_level::8, 0::size(3)-unit(8)>>
end
