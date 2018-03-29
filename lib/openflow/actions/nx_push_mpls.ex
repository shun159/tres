defmodule Openflow.Action.NxPushMpls do
  defstruct(ethertype: 0x8847)

  @experimenter 0x00002320
  @nxast 23

  alias __MODULE__

  def new(ethertype \\ 0x8847) do
    %NxPushMpls{ethertype: ethertype}
  end

  def to_binary(%NxPushMpls{ethertype: ethertype}) do
    exp_body = <<@experimenter::32, @nxast::16, ethertype::16, 0::size(4)-unit(8)>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, ethertype::16, _::size(4)-unit(8)>>) do
    %NxPushMpls{ethertype: ethertype}
  end
end
