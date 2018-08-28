defmodule Tres.MessageHandlerSup do
  use Supervisor

  def start_link() do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_init_args) do
    children = []

    Supervisor.init(
      children,
      strategy: :one_for_one,
      max_restarts: 5,
      max_seconds: 10
    )
  end

  def start_child(dpid) do
    {cb_mod, _cb_args} = Tres.Utils.get_callback_module()
    child_spec = cb_mod.handler_spec(dpid)
    Supervisor.start_child(__MODULE__, child_spec)
  end

  def terminate_child(dpid) do
    {cb_mod, _cb_args} = Tres.Utils.get_callback_module()
    child_spec = cb_mod.handler_spec(dpid)
    _ = Supervisor.terminate_child(__MODULE__, child_spec[:id])
    _ = Supervisor.delete_child(__MODULE__, child_spec[:id])
  end

  @spec count_handlers() :: non_neg_integer()
  def count_handlers do
    count_value = Supervisor.count_children(__MODULE__)
    count_value[:active]
  end
end
