defmodule Openflow.Action.NxSetTunnel64 do
  defstruct(tunnel_id: 0)

  @experimenter 0x00002320
  @nxast 9

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @spec new(tunnel_id :: 0..0xFFFFFFFFFFFFFFFF) :: %NxSetTunnel64{tunnel_id: 0..0xFFFFFFFFFFFFFFFF}
  def new(tunnel_id) do
    %NxSetTunnel64{tunnel_id: tunnel_id}
  end

  def to_binary(%NxSetTunnel64{tunnel_id: tunnel_id}) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      0::size(6)-unit(8),
      tunnel_id::64
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, 0::size(6)-unit(8), tunnel_id::64>>) do
    %NxSetTunnel64{tunnel_id: tunnel_id}
  end
end
