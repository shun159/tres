defmodule PatchPanel.Openflow.Controller do
  use GenServer
  use Tres.Controller

  import Logger

  defmodule State do
    defstruct [:datapath_id]
  end

  def create_patch(datapath_id, port_a, port_b) do
    case PatchPanel.Openflow.Registry.lookup_pid(datapath_id) do
      nil ->
        {:error, :not_found}
      pid when is_pid(pid) ->
        GenServer.call(pid, {:create, port_a, port_b})
    end
  end

  def delete_patch(datapath_id, port_a, port_b) do
    case PatchPanel.Openflow.Registry.lookup_pid(datapath_id) do
      nil ->
        {:error, :not_found}
      pid when is_pid(pid) ->
        GenServer.call(pid, {:delete, port_a, port_b})
    end
  end

  def start_link({datapath_id, _aux_id}, _start_args) do
    GenServer.start_link(__MODULE__, [datapath_id])
  end

  def init([datapath_id]) do
    :ok = info("Switch Connected: datapath_id = #{datapath_id}")
    {:ok, _} = PatchPanel.Openflow.Registry.register(datapath_id)
    {:ok, %State{datapath_id: datapath_id}}
  end

  def handle_call({:create, port_a, port_b}, _from, %State{datapath_id: datapath_id} = state) do
    :ok = add_flow_entries(datapath_id, port_a, port_b)
    {:reply, :ok, state}
  end
  def handle_call({:delete, port_a, port_b}, _from, %State{datapath_id: datapath_id} = state) do
    :ok = del_flow_entries(datapath_id, port_a, port_b)
    {:reply, :ok, state}
  end

  def handle_info({:switch_disconnected, reason}, %State{datapath_id: datapath_id} = state) do
    :ok = warn("#{datapath_id} disconnected: reason = #{inspect(reason)}")
    :ok = PatchPanel.Openflow.Registry.unregister(datapath_id)
    {:stop, :normal, state}
  end
  def handle_info(_info, state) do
    {:noreply, state}
  end

  def terminate(reason, state) do
    {reason, state}
  end

  # private functions

  defp add_flow_entries(datapath_id, port_a, port_b) do
    :ok = send_flow_mod_add(
      datapath_id,
      match: Match.new(in_port: port_a),
      instructions: [ApplyActions.new(Output.new(port_b))]
    )

    :ok = send_flow_mod_add(
      datapath_id,
      match: Match.new(in_port: port_b),
      instructions: [ApplyActions.new(Output.new(port_a))]
    )
  end

  defp del_flow_entries(datapath_id, port_a, port_b) do
    :ok = send_flow_mod_delete(datapath_id, match: Match.new(in_port: port_a))
    :ok = send_flow_mod_delete(datapath_id, match: Match.new(in_port: port_b))
  end
end
