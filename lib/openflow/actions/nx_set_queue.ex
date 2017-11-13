defmodule Openflow.Action.NxSetQueue do
  defstruct([queue_id: 0])

  @experimenter 0x00002320
  @nxast 4

  alias __MODULE__

  def new(queue_id) do
    %NxSetQueue{queue_id: queue_id}
  end

  def to_binary(%NxSetQueue{queue_id: queue_id}) do
    exp_body = <<@experimenter::32, @nxast::16, 0::16, queue_id::32>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, 0::size(2)-unit(8), queue_id::32>>) do
    %NxSetQueue{queue_id: queue_id}
  end
end
