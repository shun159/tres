defmodule Openflow.Action.NxLearn2 do
  defstruct(
    idle_timeout: 0,
    hard_timeout: 0,
    priority: 0,
    cookie: 0,
    flags: [],
    table_id: 0,
    fin_idle_timeout: 0,
    fin_hard_timeout: 0,
    limit: 0,
    result_dst_offset: 0,
    result_dst: nil,
    flow_specs: []
  )

  @experimenter 0x00002320
  @nxast 45

  alias __MODULE__

  def new(options) do
    %NxLearn2{
      idle_timeout: options[:idle_timeout] || 0,
      hard_timeout: options[:hard_timeout] || 0,
      priority: options[:priority] || 0,
      cookie: options[:cookie] || 0,
      flags: options[:flags] || [],
      table_id: options[:table_id] || 0xFF,
      fin_idle_timeout: options[:fin_idle_timeout] || 0,
      fin_hard_timeout: options[:fin_hard_timeout] || 0,
      limit: options[:limit] || 0,
      result_dst_offset: options[:result_dst_offset] || 0,
      result_dst: options[:result_dst],
      flow_specs: options[:flow_specs] || []
    }
  end

  def to_binary(%NxLearn2{
        idle_timeout: idle,
        hard_timeout: hard,
        priority: prio,
        cookie: cookie,
        flags: flags,
        table_id: table_id,
        fin_idle_timeout: fin_idle,
        fin_hard_timeout: fin_hard,
        limit: limit,
        result_dst_offset: result_dst_ofs,
        result_dst: result_dst,
        flow_specs: flow_specs
      }) do
    flags_int = Openflow.Enums.flags_to_int(flags, :nx_learn_flag)

    result_dst_bin =
      if :write_result in flags do
        Openflow.Match.codec_header(result_dst)
      else
        ""
      end

    flow_specs_bin = Openflow.Action.NxFlowSpec.to_binary(flow_specs)

    exp_body =
      <<@experimenter::32, @nxast::16, idle::16, hard::16, prio::16, cookie::64, flags_int::16,
        table_id::8, 0::size(1)-unit(8), fin_idle::16, fin_hard::16, limit::32,
        result_dst_ofs::16, 0::size(2)-unit(8), result_dst_bin::bytes, flow_specs_bin::bitstring>>

    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, body::bytes>>) do
    <<idle::16, hard::16, prio::16, cookie::64, flags_int::16, table_id::8, 0::8, fin_idle::16,
      fin_hard::16, limit::32, result_dst_ofs::16, 0::size(2)-unit(8), rest::bytes>> = body

    flags = Openflow.Enums.int_to_flags(flags_int, :nx_learn_flag)

    learn = %NxLearn2{
      idle_timeout: idle,
      hard_timeout: hard,
      priority: prio,
      cookie: cookie,
      flags: flags,
      table_id: table_id,
      fin_idle_timeout: fin_idle,
      fin_hard_timeout: fin_hard,
      limit: limit,
      result_dst_offset: result_dst_ofs
    }

    if :write_result in flags do
      header_size = Openflow.Match.header_size(rest)
      <<result_dst_bin::size(header_size)-bytes, flow_specs_bin::bytes>> = rest
      result_dst = Openflow.Match.codec_header(result_dst_bin)
      flow_specs = Openflow.Action.NxFlowSpec.read(flow_specs_bin)
      struct(learn, %{result_dst: result_dst, flow_specs: flow_specs})
    else
      <<flow_specs_bin::bytes>> = rest
      flow_specs = Openflow.Action.NxFlowSpec.read(flow_specs_bin)
      struct(learn, %{flow_specs: flow_specs})
    end
  end
end
