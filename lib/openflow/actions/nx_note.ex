defmodule Openflow.Action.NxNote do
  defstruct(note: "")

  @experimenter 0x00002320
  @nxast 8

  alias __MODULE__

  def new(note) do
    %NxNote{note: note}
  end

  def to_binary(%NxNote{note: note}) do
    padding = Openflow.Utils.padding(byte_size(note) + 2, 8)
    exp_body = <<@experimenter::32, @nxast::16, note::bytes, 0::size(padding)-unit(8)>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, note_bin::bytes>>) do
    note = Openflow.Utils.decode_string(note_bin)
    %NxNote{note: note}
  end
end
