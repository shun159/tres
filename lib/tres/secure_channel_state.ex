defmodule Tres.SecureChannelState do
  defstruct(
    handler_pid:          nil,
    handler_ref:          nil,
    ref:                  nil,
    socket:               nil,
    transport:            nil,
    buffer:                "",
    ip_addr:              nil,
    port:                  "",
    datapath_id:           "",
    aux_id:                "",
    timer_ref:            nil,
    xid:                  nil,
    main_monitor_ref:     nil,
    ping_xid:             0,
    ping_timer_ref:       nil,
    ping_fail_count:      0,
    last_received:        0,
    xact_kv_ref:          nil
  )

  alias __MODULE__
  alias :tres_xact_kv, as: XACT_KV

  def new(options) do
    ref = Keyword.get(options, :ref)
    socket = Keyword.get(options, :socket)
    transport = Keyword.get(options, :transport)
    {:ok, {ip_addr, port}} = :inet.peername(socket)
    {:ok, xid_agent} = Agent.start_link(fn -> 0 end)
    kv_ref = XACT_KV.create
    %SecureChannelState{
      ref:       ref,
      socket:    socket,
      transport: transport,
      ip_addr:   :inet.ntoa(ip_addr),
      port:      port,
      xid:       xid_agent,
      xact_kv_ref: kv_ref
    }
  end

  def increment_transaction_id(xid_agent) do
    Agent.get_and_update(xid_agent, &({&1 + 1, &1 + 1}))
  end

  def set_transaction_id(xid_agent, xid) do
    Agent.update(xid_agent, fn(_) -> xid end)
  end

  def get_transaction_id(xid_agent) do
    Agent.get(xid_agent, &(&1))
  end
end
