defmodule Openflow.Action.NxSetMplsTc do
  defstruct(tc: 0)

  @experimenter 0x00002320
  @nxast 31

  alias __MODULE__

  def new(tc) do
    %NxSetMplsTc{tc: tc}
  end

  def to_binary(%NxSetMplsTc{tc: tc}) do
    exp_body = <<@experimenter::32, @nxast::16, tc::8, 0::size(5)-unit(8)>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, tc::8, _::size(5)-unit(8)>>) do
    %NxSetMplsTc{tc: tc}
  end
end
