defmodule Openflow.Action.NxPopQueue do
  defstruct([])

  @experimenter 0x00002320
  @nxast 5
 
  alias __MODULE__

  def new do
    %NxPopQueue{}
  end

  def to_binary(%NxPopQueue{}) do
    exp_body = <<@experimenter::32, @nxast::16, 0::48>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, 0::size(6)-unit(8)>>) do
    %NxPopQueue{}
  end
end
