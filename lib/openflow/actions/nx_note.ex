defmodule Openflow.Action.NxNote do
  defstruct(note: "")

  @experimenter 0x00002320
  @nxast 8

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(note) do
    %NxNote{note: note}
  end

  def to_binary(%NxNote{note: note}) do
    Experimenter.pack_exp_header(<<@experimenter::32, @nxast::16, note::bytes>>)
  end

  def read(<<@experimenter::32, @nxast::16, note_bin::bytes>>) do
    note = Openflow.Utils.decode_string(note_bin)
    %NxNote{note: note}
  end
end
