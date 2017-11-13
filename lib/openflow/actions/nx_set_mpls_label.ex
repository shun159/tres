defmodule Openflow.Action.NxSetMplsLabel do
  defstruct(label: 0)

  @experimenter 0x00002320
  @nxast 30

  alias __MODULE__

  def new(label) do
    %NxSetMplsLabel{label: label}
  end

  def to_binary(%NxSetMplsLabel{label: label}) do
    exp_body = <<@experimenter::32, @nxast::16, 0::16, label::32>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, _::16, label::32>>) do
    %NxSetMplsLabel{label: label}
  end
end
