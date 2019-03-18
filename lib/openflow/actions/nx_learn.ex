defmodule Openflow.Action.NxLearn do
  defstruct(
    idle_timeout: 0,
    hard_timeout: 0,
    priority: 0,
    cookie: 0,
    flags: [],
    table_id: 0,
    fin_idle_timeout: 0,
    fin_hard_timeout: 0,
    flow_specs: []
  )

  @experimenter 0x00002320
  @nxast 16

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options) do
    %NxLearn{
      idle_timeout: options[:idle_timeout] || 0,
      hard_timeout: options[:hard_timeout] || 0,
      priority: options[:priority] || 0,
      cookie: options[:cookie] || 0,
      flags: options[:flags] || [],
      table_id: options[:table_id] || 0xFF,
      fin_idle_timeout: options[:fin_idle_timeout] || 0,
      fin_hard_timeout: options[:fin_hard_timeout] || 0,
      flow_specs: options[:flow_specs] || []
    }
  end

  def to_binary(%NxLearn{} = learn) do
    learn_flags_int = Openflow.Enums.flags_to_int(learn.flags, :nx_learn_flag)
    flow_specs_bin = Openflow.Action.NxFlowSpec.to_binary(learn.flow_specs)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      learn.idle_timeout::16,
      learn.hard_timeout::16,
      learn.priority::16,
      learn.cookie::64,
      learn_flags_int::16,
      learn.table_id::8,
      0::8,
      learn.fin_idle_timeout::16,
      learn.fin_hard_timeout::16,
      flow_specs_bin::bitstring
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, body::bitstring>>) do
    <<idle::16, hard::16, prio::16, cookie::64, flags_int::16, table_id::8, _pad::size(1)-unit(8),
      fin_idle::16, fin_hard::16, flow_specs_bin::bitstring>> = body

    flags = Openflow.Enums.int_to_flags(flags_int, :nx_learn_flag)
    flow_specs = Openflow.Action.NxFlowSpec.read(flow_specs_bin)

    %NxLearn{
      idle_timeout: idle,
      hard_timeout: hard,
      priority: prio,
      cookie: cookie,
      flags: flags,
      table_id: table_id,
      fin_idle_timeout: fin_idle,
      fin_hard_timeout: fin_hard,
      flow_specs: flow_specs
    }
  end
end
