defmodule Openflow.Action.NxSetTunnel do
  @moduledoc """
  Set encapsulating tunnel ID.
  """

  defstruct(tunnel_id: 0)

  @experimenter 0x00002320
  @nxast 2

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @type tunnel_id :: 0..0xFFFFFFFF
  @type t :: %NxSetTunnel{tunnel_id: tunnel_id()}

  @doc """
  Creates a new set_tunnel action struct

  ## Example:
  ```elixir
  iex> %NxSetTunnel{tunnel_id: 1} = NxSetTunnel.new(1)
  ```
  """
  @spec new(tunnel_id()) :: t()
  def new(tunnel_id) do
    %NxSetTunnel{tunnel_id: tunnel_id}
  end

  @spec to_binary(t()) :: binary()
  def to_binary(%NxSetTunnel{tunnel_id: tunnel_id}) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      0::16,
      tunnel_id::32
    >>)
  end

  @spec read(binary()) :: t()
  def read(<<@experimenter::32, @nxast::16, _::16, tunnel_id::32>>) do
    %NxSetTunnel{tunnel_id: tunnel_id}
  end
end
