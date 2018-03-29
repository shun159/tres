defmodule Openflow.Action.NxSetTunnel do
  defstruct(tunnel_id: 0)

  @experimenter 0x00002320
  @nxast 2

  alias __MODULE__

  def new(tunnel_id) do
    %NxSetTunnel{tunnel_id: tunnel_id}
  end

  def to_binary(%NxSetTunnel{tunnel_id: tunnel_id}) do
    exp_body = <<@experimenter::32, @nxast::16, 0::16, tunnel_id::32>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, _::16, tunnel_id::32>>) do
    %NxSetTunnel{tunnel_id: tunnel_id}
  end
end
