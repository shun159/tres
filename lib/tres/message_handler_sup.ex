defmodule Tres.MessageHandlerSup do
  use DynamicSupervisor

  def start_link(cb_mod) do
    DynamicSupervisor.start_link(__MODULE__, [cb_mod], name: __MODULE__)
  end

  def init([_cb_mod]) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child({dpid, aux_id}) do
    {cb_mod, cb_args} = Tres.Utils.get_callback_module()
    DynamicSupervisor.start_child(__MODULE__, {cb_mod, [{dpid, aux_id}, cb_args]})
  end
end
