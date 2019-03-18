defmodule Openflow.Action.NxSetTunnel do
  defstruct(tunnel_id: 0)

  @experimenter 0x00002320
  @nxast 2

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(tunnel_id) do
    %NxSetTunnel{tunnel_id: tunnel_id}
  end

  def to_binary(%NxSetTunnel{tunnel_id: tunnel_id}) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      0::16,
      tunnel_id::32
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, _::16, tunnel_id::32>>) do
    %NxSetTunnel{tunnel_id: tunnel_id}
  end
end
