defmodule Tres.MessageHandler do
  use GenServer

  defmodule State do
    defstruct [
      ip_addr:     nil,
      port:        nil,
      datapath_id: nil,
      conn_pid:    nil,
      conn_ref:    nil,
      handler_pid: nil,
      handler_ref: nil
    ]
  end

  alias Tres.MessageHandler.State

  @process_flags [trap_exit: true]

  def start_link({ip_addr, port}, conn_pid) do
    GenServer.start_link(__MODULE__, [{ip_addr, port}, conn_pid])
  end

  def init([{ip_addr, port}, conn_pid]) do
    init_process()
    conn_ref = Process.monitor(conn_pid)
    state = %State{
      conn_pid: conn_pid,
      conn_ref: conn_ref,
      ip_addr:  ip_addr,
      port:     port
    }
    {:ok, state}
  end

  def handle_info({:'EXIT', _pid, _reason}, state) do
    {:stop, :normal, state}
  end
  def handle_info({:'DOWN', conn_ref, :process, _conn_pid, _reason}, %State{conn_ref: conn_ref} = state) do
    {:stop, :normal, state}
  end

  def terminate(_reason, state) do
    {:shutdown, state}
  end

  ## private functions

  defp init_process do
    for {flag, value} <- @process_flags, do: Process.flag(flag, value)
  end
end
