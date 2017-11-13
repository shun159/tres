defmodule Openflow.Instruction.WriteMetadata do
  defstruct(metadata: 0, metadata_mask: 0xffffffffffffffff)

  alias __MODULE__

  def new(options) do
    metadata = Keyword.get(options, :metadata, 0)
    metadata_mask = Keyword.get(options, :metadata_mask, 0xffffffffffffffff)
    %WriteMetadata{metadata: metadata, metadata_mask: metadata_mask}
  end

  def to_binary(%WriteMetadata{metadata: metadata, metadata_mask: metadata_mask}) do
    <<2::16, 24::16, 0::size(4)-unit(8), metadata::64, metadata_mask::64>>
  end

  def read(<<2::16, 24::16, _::size(4)-unit(8), metadata::64, metadata_mask::64>>) do
    %WriteMetadata{metadata: metadata, metadata_mask: metadata_mask}
  end
end
