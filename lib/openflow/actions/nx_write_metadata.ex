defmodule Openflow.Action.NxWriteMetadata do
  defstruct(
    metadata: 0,
    metadata_mask: 0xFFFFFFFFFFFFFFFF
  )

  @experimenter 0x00002320
  @nxast 22

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ [])

  def new(metadata) when is_integer(metadata) do
    new(metadata: metadata)
  end

  def new(options) when is_list(options) do
    metadata = options[:metadata] || raise "metadata must be specified"
    metadata_mask = options[:metadata_mask] || 0xFFFFFFFFFFFFFFFF
    %NxWriteMetadata{metadata: metadata, metadata_mask: metadata_mask}
  end

  def to_binary(%NxWriteMetadata{metadata: metadata, metadata_mask: metadata_mask}) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      0::size(6)-unit(8),
      metadata::64,
      metadata_mask::64
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, _::size(6)-unit(8), metadata::64, metadata_mask::64>>) do
    %NxWriteMetadata{metadata: metadata, metadata_mask: metadata_mask}
  end
end
