defmodule Tres.SecureChannelState do
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

  def increment_transaction_id(table_ref) do
    :ets.update_counter(table_ref, :datapath_xid, {2, 1, 0xffffffff, 0})
  end

  def set_transaction_id(table_ref, xid) do
    :ets.insert(table_ref, {:datapath_xid, xid})
  end

  def get_transaction_id(table_ref) do
    case :ets.lookup(table_ref, :datapath_xid) do
      [{_, xid} | _] -> xid
    end
  end

  # private functions

  @spec create_counter() :: reference()
  defp create_counter do
    table_ref = :ets.new(:xid_counter, [:set, :private])
    _ = :ets.insert(table_ref, {:datapath_xid, 0})
    {:ok, table_ref}
  end
end
