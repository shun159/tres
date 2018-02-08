defmodule LeaderExample.Leader do
  use Tres.Controller

  @behaviour :locks_leader

  require Logger

  def start_link(datapath_id, args) do
    :locks_leader.start_link(__MODULE__, [datapath_id, args], [])
  end

  def init([{datapath_id, _aux_id}, _args]) do
    :ok = Logger.debug("Switch Ready: datapath_id: #{inspect(datapath_id)}")
    :ok = role_request(datapath_id, role: :slave, generation_id: 0)
    {:ok, %{am_leader: false, gen_id: 0, datapath_id: datapath_id}}
  end

  def elected(state, _info, _cand) do
    :ok = Logger.info("Elected: #{inspect(Node.self)} for #{state.datapath_id} gen_id: #{state.gen_id}")
    :ok = role_request(state.datapath_id, role: :master, generation_id: state.gen_id)
    {:ok, {:elected, {Node.self(), state.gen_id + 1}}, %{state|am_leader: true}}
  end

  def surrendered(%{am_leader: true} = state, {:elected, {_node, next_gen_id}}, _info) do
    :ok = Logger.info("network split possible detected")
    :ok = role_request(state.datapath_id, role: :slave, generation_id: state.gen_id)
    {:ok, %{state|am_leader: false, gen_id: next_gen_id}}
  end

  def surrendered(state, {:elected, {node, next_gen_id}}, _info) do
    :ok = Logger.info("Surrendered: elected node is #{node} for #{state.datapath_id}")
    :ok = role_request(state.datapath_id, role: :slave, generation_id: state.gen_id)
    {:ok, %{state|am_leader: false, gen_id: next_gen_id}}
  end

  def handle_DOWN(_pid, state, _info) do
    :ok = Logger.warn("DOWN detected")
    {:ok, state}
  end

  def handle_leader_call(msg, from, state, _info) do
    :ok = Logger.info("leader call with: #{inspect(msg)} from: #{inspect(from)} on #{Node.self()}")
    {:reply, :ok, state}
  end

  def handle_leader_cast(_msg, state, _info) do
    {:ok, state}
  end

  def from_leader(_from_leader, state, _info) do
    {:ok, state}
  end

  def handle_call(_msg, _from, state, _info) do
    {:reply, :ok, state}
  end

  def handle_cast(_msg, state, _info) do
    {:noreply, state}
  end

  def handle_info(%Role.Reply{datapath_id: dpid} = role, %{datapath_id: dpid} = state, _info) do
    :ok = Logger.info("#{Node.self()} is on #{role.role} for #{dpid}")
    {:noreply, state}
  end
  def handle_info(_msg, state, _info) do
    {:noreply, state}
  end

  def code_change(_from_vsn, state, _info, _extra) do
    {:ok, state}
  end

  def terminate(_reason, _state) do
    :ok
  end
end
