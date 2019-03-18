defmodule Openflow.Action.NxPopMpls do
  defstruct(ethertype: 0x8847)

  @experimenter 0x00002320
  @nxast 24

  @eth_p_mpls_uc 0x8847

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(ethertype \\ @eth_p_mpls_uc) do
    %NxPopMpls{ethertype: ethertype}
  end

  def to_binary(%NxPopMpls{ethertype: ethertype}) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      ethertype::16,
      0::size(4)-unit(8)
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, ethertype::16, _::size(4)-unit(8)>>) do
    %NxPopMpls{ethertype: ethertype}
  end
end
