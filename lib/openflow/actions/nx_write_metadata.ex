defmodule Openflow.Action.NxWriteMetadata do
  defstruct(
    metadata: 0,
    metadata_mask: 0xFFFFFFFFFFFFFFFF
  )

  @experimenter 0x00002320
  @nxast 22

  alias __MODULE__

  def new(metadata) when is_integer(metadata) do
    new(metadata: metadata)
  end

  def new(options) when is_list(options) do
    metadata = Keyword.get(options, :metadata, 0)
    metadata_mask = Keyword.get(options, :metadata_mask, 0xFFFFFFFFFFFFFFFF)
    %NxWriteMetadata{metadata: metadata, metadata_mask: metadata_mask}
  end

  def to_binary(%NxWriteMetadata{metadata: metadata, metadata_mask: metadata_mask}) do
    exp_body =
      <<@experimenter::32, @nxast::16, 0::size(6)-unit(8), metadata::64, metadata_mask::64>>

    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, _::size(6)-unit(8), metadata::64, metadata_mask::64>>) do
    %NxWriteMetadata{metadata: metadata, metadata_mask: metadata_mask}
  end
end
