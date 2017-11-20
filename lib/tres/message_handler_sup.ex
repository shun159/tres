defmodule Tres.MessageHandlerSup do
  use Supervisor

  def start_link(cb_mod) do
    Supervisor.start_link(__MODULE__, [cb_mod], name: __MODULE__)
  end

  def init([cb_mod]) do
    children = [worker(cb_mod, [], restart: :temporary, shutdown: 5000)]
    supervise(children, strategy: :simple_one_for_one)
  end

  def start_child({dpid, aux_id}) do
    {_cb_mod, cb_args} = Tres.Utils.get_callback_module
    Supervisor.start_child(__MODULE__, [{dpid, aux_id}, cb_args])
  end
end
