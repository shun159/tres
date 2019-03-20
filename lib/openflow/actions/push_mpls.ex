defmodule Openflow.Action.PushMpls do
  @moduledoc """
  Push a new MPLS label

      send_flow_mod_add(
        datapath_id,
        match: Match.new(),
        instruction: ApplyActions.new(PushMpls.new())
      )
  """

  defstruct(ethertype: 0x8847)

  @eth_p_mpls_uc 0x8847

  alias __MODULE__

  @type t :: %PushMpls{ethertype: 0..0xFFFF}

  @spec ofpat() :: 19
  def ofpat, do: 19

  @doc """
  Create a new push_mpls action struct\\
  0x8847(ETH_P_MPLS_UC) as a default value.

      iex> %PushMpls{ethertype: 0x8847} = PushMpls.new()
  """
  @spec new() :: t()
  @spec new(ethertype :: 0..0xFFFF) :: t()
  def new(ethertype \\ @eth_p_mpls_uc) do
    %PushMpls{ethertype: ethertype}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%PushMpls{ethertype: ethertype}) do
    <<19::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<19::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>) do
    %PushMpls{ethertype: ethertype}
  end
end
