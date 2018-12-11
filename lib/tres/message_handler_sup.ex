defmodule Tres.MessageHandlerSup do
  use Supervisor

  # API functions

  def start_child(dpid) do
    {_cb_mod, cb_args} = Tres.Utils.get_callback_module()
    {:ok, pid} = Supervisor.start_child(__MODULE__, [dpid, cb_args])
    :ok = Tres.SwitchRegistry.register_handler_pid(dpid, pid)
    {:ok, pid}
  end

  def terminate_child(dpid) do
    {cb_mod, _cb_args} = Tres.Utils.get_callback_module()
    _ = Supervisor.terminate_child(__MODULE__, {cb_mod, dpid})
    _ = Supervisor.delete_child(__MODULE__, {cb_mod, dpid})
  end

  @spec count_handlers() :: non_neg_integer()
  def count_handlers do
    count_value = Supervisor.count_children(__MODULE__)
    count_value[:active]
  end

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  # supervisor callback functions

  @impl Supervisor
  def init(_init_args) do
    children = [handler_spec()]

    Supervisor.init(
      children,
      strategy: :simple_one_for_one,
      max_restarts: 10,
      max_seconds: 10
    )
  end

  # private functions

  defp handler_spec do
    {cb_mod, _cb_args} = Tres.Utils.get_callback_module()

    %{
      id: :undefined,
      start: {cb_mod, :start_link, []},
      restart: :temporary,
      shutdown: 5000,
      type: :worker,
      modules: [cb_mod]
    }
  end
end
