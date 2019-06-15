defmodule Tres.SecureChannelState do
  use Bitwise

  defstruct(
    handler_pid: nil,
    handler_ref: nil,
    ref: nil,
    socket: nil,
    transport: nil,
    buffer: "",
    ip_addr: nil,
    port: "",
    datapath_id: "",
    aux_id: "",
    timer_ref: nil,
    xid: nil,
    main_monitor_ref: nil,
    ping_xid: 0,
    ping_timer_ref: nil,
    ping_fail_count: 0,
    last_received: 0,
    xact_kv_ref: nil,
    action_queue: :queue.new()
  )

  alias __MODULE__
  alias :tres_xact_kv, as: XACT_KV

  def new(options) do
    ref = Keyword.get(options, :ref)
    socket = Keyword.get(options, :socket)
    transport = Keyword.get(options, :transport)
    {:ok, {ip_addr, port}} = :inet.peername(socket)
    {:ok, table_ref} = create_counter()
    kv_ref = XACT_KV.create()

    %SecureChannelState{
      ref: ref,
      socket: socket,
      transport: transport,
      ip_addr: :inet.ntoa(ip_addr),
      port: port,
      xid: table_ref,
      xact_kv_ref: kv_ref
    }
  end

  @spec increment_transaction_id(:counters.counters_ref()) :: integer()
  def increment_transaction_id(counter_ref) do
    :ok = :counters.add(counter_ref, 1, 1)
    get_transaction_id(counter_ref)
  end

  @spec set_transaction_id(:counters.counters_ref(), integer()) :: integer()
  def set_transaction_id(counter_ref, xid) do
    :ok = :counters.put(counter_ref, 1, xid)
    get_transaction_id(counter_ref)
  end

  @spec get_transaction_id(:counters.counters_ref()) :: integer()
  def get_transaction_id(counter_ref) do
    :counters.get(counter_ref, 1) &&& 0xFFFFFFFF
  end

  # private functions

  @spec create_counter() :: reference()
  defp create_counter do
    {:ok, :counters.new(1, [])}
  end
end
