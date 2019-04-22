defmodule Openflow.Action.NxFinTimeout do
  defstruct(
    idle_timeout: 0,
    hard_timeout: 0
  )

  @experimenter 0x00002320
  @nxast 19

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @spec new(Keyword.t()) :: %NxFinTimeout{}
  def new(options) do
    %NxFinTimeout{
      idle_timeout: options[:idle_timeout] || 0,
      hard_timeout: options[:hard_timeout] || 0
    }
  end

  def to_binary(%NxFinTimeout{} = fin_timeout) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      fin_timeout.idle_timeout::16,
      fin_timeout.hard_timeout::16
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, fin_idle::16, fin_hard::16, _::size(2)-unit(8)>>) do
    %NxFinTimeout{idle_timeout: fin_idle, hard_timeout: fin_hard}
  end
end
