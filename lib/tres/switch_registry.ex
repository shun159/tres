defmodule Tres.SwitchRegistry do
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
    [{pid, _} | _] = Registry.lookup(__MODULE__, datapath_id)
    :gen_statem.call(pid, {:send_message, message}, 500)
  catch
    :exit, {:timeout, _} ->
      {:error, :timeout}
  end

  def blocking_send_message(message, dpid) when is_binary(dpid) do
    blocking_send_message(message, {dpid, 0})
  end

  def get_current_xid({_dpid, _aux_id} = datapath_id) do
    [{pid, _} | _] = Registry.lookup(__MODULE__, datapath_id)
    :gen_statem.call(pid, :get_xid, 1000)
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

  defp do_send_message(entries, message) do
    for {pid, _} <- entries, do: :gen_statem.cast(pid, {:send_message, message})
  end
end
