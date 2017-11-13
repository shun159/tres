defmodule Openflow.Action.NxFinTimeout do
  defstruct(
    idle_timeout: 0,
    hard_timeout: 0
  )

  @experimenter 0x00002320
  @nxast 19

  alias __MODULE__

  def new(options) do
    fin_idle = Keyword.get(options, :idle_timeout, 0)
    fin_hard = Keyword.get(options, :hard_timeout, 0)
    %NxFinTimeout{idle_timeout: fin_idle, hard_timeout: fin_hard}
  end

  def to_binary(%NxFinTimeout{idle_timeout: fin_idle, hard_timeout: fin_hard}) do
    exp_body = <<@experimenter::32, @nxast::16, fin_idle::16, fin_hard::16>>
    <<0xffff::16, 16::16, exp_body::bytes, 0::size(2)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, fin_idle::16, fin_hard::16, _::size(2)-unit(8)>>) do
    %NxFinTimeout{idle_timeout: fin_idle, hard_timeout: fin_hard}
  end
end
