defmodule Tres.ExampleHandler do
  use GenServer
  use Tres.Controller

  import Logger

  defmodule State do
    defstruct datapath_id: nil,
              aux_id: nil,
              queue: :queue.new(),
              client: nil
  end

  # API functions

  @spec send(String.t(), map()) :: :ok
  def send(datapath_id, msg), do: send_message(msg, datapath_id)

  @spec get(datapath_id :: String.t()) :: map() | nil
  def get(datapath_id) do
    datapath_id
    |> lookup_handler_pid()
    |> GenServer.call(:get)
  end

  def start_link(datapath, args) do
    GenServer.start_link(__MODULE__, [datapath, args])
  end

  # GenServer callbacks

  def init([{datapath_id, aux_id}, _args]) do
    :ok = info("datapath connected: #{datapath_id}")
    :ok = send_flow_mod_add(datapath_id, priority: 0)
    {:ok, %State{datapath_id: datapath_id, aux_id: aux_id}}
  end

  def handle_call(:get, from, %State{queue: {[], []}} = state) do
    {:noreply, %{state | client: from}}
  end

  def handle_call(:get, _from, %State{} = state) do
    {{:value, msg}, new_queue} = :queue.out(state.queue)
    {:reply, msg, %{state | queue: new_queue}}
  end

  def handle_info(%{datapath_id: _datapath_id} = msg, %State{client: nil} = state) do
    {:noreply, %{state | queue: :queue.in(msg, state.queue)}}
  end

  def handle_info(%{datapath_id: _datapath_id} = msg, state) do
    GenServer.reply(state.client, msg)
    {:noreply, %{state | client: nil}}
  end

  def handle_info({:switch_disconnected, _reason}, state) do
    :ok = warn("Switch disconnected")
    {:stop, :normal, state}
  end

  def handle_info(info, state) do
    :ok = warn("unhandled message #{inspect(info)}: #{state.datapath_id}")
    {:noreply, state}
  end

  # private functions
end
