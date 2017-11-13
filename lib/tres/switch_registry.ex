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

  def send_message(message, {_dpid, _aux_id} = datapath_id) do
    Registry.dispatch(__MODULE__, datapath_id, &dispatch(&1, message))
  end
  def send_message(message, dpid) when is_binary(dpid) do
    send_message(message, {dpid, 0})
  end

  # private function

  defp dispatch(entries, message) do
    for {pid, _} <- entries, do: :gen_statem.cast(pid, {:send_message, message})
  end
end
