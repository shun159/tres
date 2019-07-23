defmodule NxLearningSwitch do
  @moduledoc """
  Emulates Layer2 switch
  """

  use GenServer
  use Tres.Controller

  import Logger

  # API functions

  def start_link(datapath_id, _args) do
    GenServer.start_link(__MODULE__, [datapath_id])
  end

  # GenServer callback functions

  @impl GenServer
  def init([{datapath_id, _aux_id}]) do
    :ok = info("Connected: datapath_id: #{datapath_id}")
    {:ok, datapath_id, {:continue, :init}}
  end

  @impl GenServer
  def handle_continue(:init, datapath_id) do
    :ok = l2_learning_flow(datapath_id)
    :ok = l2_flooding_flows(datapath_id)
    {:noreply, datapath_id}
  end

  @impl GenServer
  def handle_call(_request, _from, state) do
    {:reply, :ok, state}
  end

  @impl GenServer
  def handle_cast(_request, state) do
    {:noreply, state}
  end

  @impl GenServer
  def handle_info({:switch_disconnected, reason}, datapath_id) do
    :ok = warn("Disconnected: datapath_id: #{datapath_id} by #{inspect(reason)}")
    {:stop, :normal, datapath_id}
  end

  @impl GenServer
  def handle_info(_info, state) do
    {:noreply, state}
  end

  ## private functions

  defp l2_learning_flow(datapath_id) do
    send_flow_mod_add(
      datapath_id,
      table_id: 0,
      instructions: l2_learning_instr()
    )
  end

  defp l2_flooding_flows(datapath_id) do
    send_flow_mod_add(
      datapath_id,
      table_id: 1,
      priority: 0,
      instructions: ApplyActions.new(Output.new(:flood))
    )
  end

  defp l2_learning_instr do
    ApplyActions.new([
      l2_learning_action(),
      NxResubmitTable.new(1)
    ])
  end

  defp l2_learning_action do
    NxLearn.new(
      table_id: 1,
      priority: 2,
      hard_timeout: 10,
      flow_specs: l2_learning_flow_specs()
    )
  end

  defp l2_learning_flow_specs do
    [
      NxFlowSpecMatch.new(src: :eth_src, dst: :eth_dst),
      NxFlowSpecMatch.new(src: :vlan_vid, n_bits: 12),
      NxFlowSpecOutput.new(src: :nx_in_port)
    ]
  end
end
