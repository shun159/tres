defmodule Tres.SwitchRegistry do
  @moduledoc """
  Dispatcher
  """

  # For DatapathHandler

  def register_handler_pid({_dpid, _aux_id} = datapath_id, pid) do
    case Registry.register(Tres.HandlerRegistry, datapath_id, pid) do
      {:ok, _owner} ->
        :ok

      {:error, {:already_registered, _owner}} ->
        :ok
    end
  end

  def lookup_handler_pid({_dpid, _aux_id} = datapath_id) do
    case Registry.lookup(Tres.HandlerRegistry, datapath_id) do
      [{_owner, pid}] -> pid
      [] -> nil
    end
  end

  def lookup_handler_pid(datapath_id) when is_binary(datapath_id),
    do: lookup_handler_pid({datapath_id, 0})

  # For Datapath

  def register({_dpid, _aux_id} = datapath_id) do
    {:ok, _} = Registry.register(__MODULE__, datapath_id, [])
  end

  def unregister({_dpid, _aux_id} = datapath_id) do
    :ok = Registry.unregister(__MODULE__, datapath_id)
  end

  def lookup_pid({_dpid, _aux_id} = datapath_id) do
    case Registry.lookup(__MODULE__, datapath_id) do
      [{pid, _}] -> pid
      [] -> nil
    end
  end

  def lookup_pid(datapath_id) do
    lookup_pid({datapath_id, 0})
  end

  def send_message(message, dpid, _blocking = true) do
    blocking_send_message(message, dpid)
  end

  def send_message(message, dpid, _blocking) do
    send_message(message, dpid)
  end

  def send_message(message, {_dpid, _aux_id} = datapath_id) do
    Registry.dispatch(__MODULE__, datapath_id, &do_send_message(&1, message))
  end

  def send_message(message, dpid) when is_binary(dpid) do
    send_message(message, {dpid, 0})
  end

  def blocking_send_message(message, {_dpid, _aux_id} = datapath_id) do
    datapath_id
    |> lookup_pid
    |> call({:send_message, message}, 5_000)
  end

  def blocking_send_message(message, dpid) when is_binary(dpid) do
    blocking_send_message(message, {dpid, 0})
  end

  def get_current_xid({_dpid, _aux_id} = datapath_id) do
    datapath_id
    |> lookup_pid
    |> call(:get_xid, 1_000)
  end

  def get_current_xid(datapath_id) do
    get_current_xid({datapath_id, 0})
  end

  def monitor(datapath_id) do
    datapath_id
    |> lookup_pid
    |> Process.monitor()
  end

  # private function

  defp call(nil, _, _) do
    {:error, :not_found}
  end

  defp call(pid, msg, timeout) when is_pid(pid) do
    :gen_statem.call(pid, msg, timeout)
  catch
    :exit, {:timeout, _} ->
      {:error, :timeout}
  end

  defp do_send_message(entries, message) do
    for {pid, _} <- entries, do: :gen_statem.cast(pid, {:send_message, message})
  end
end
