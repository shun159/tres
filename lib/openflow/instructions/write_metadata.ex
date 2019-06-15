defmodule Openflow.Instruction.WriteMetadata do
  defstruct(value: 0, mask: 0xFFFFFFFFFFFFFFFF)

  alias __MODULE__

  @type t :: %WriteMetadata{
          value: 0..0xFFFFFFFFFFFFFFFF,
          mask: 0..0xFFFFFFFFFFFFFFFF
        }

  @spec new(
          value: 0..0xFFFFFFFFFFFFFFFF,
          mask: 0..0xFFFFFFFFFFFFFFFF
        ) :: t()
  def new(options) do
    %WriteMetadata{
      value: options[:value] || 0,
      mask: options[:mask] || 0xFFFFFFFFFFFFFFFF
    }
  end

  @spec to_binary(t()) :: <<_::192>>
  def to_binary(%WriteMetadata{value: value, mask: mask}) do
    <<2::16, 24::16, 0::size(4)-unit(8), value::64, mask::64>>
  end

  @spec read(<<_::192>>) :: t()
  def read(<<2::16, 24::16, _::size(4)-unit(8), value::64, mask::64>>) do
    %WriteMetadata{value: value, mask: mask}
  end
end
