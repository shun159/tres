defmodule PatchPanel.Openflow.Registry do
  def register(datapath_id) do
    {:ok, _} = Registry.register(__MODULE__, datapath_id, [])
  end

  def unregister(datapath_id) do
    :ok = Registry.unregister(__MODULE__, datapath_id)
  end

  def lookup_pid(datapath_id) do
    case Registry.lookup(__MODULE__, datapath_id) do
      [{pid, _}] -> pid
      [] -> nil
    end
  end
end
