defmodule Tres.MessageHandlerSup do
  use DynamicSupervisor

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_init_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  def start_child({dpid, aux_id}) do
    {cb_mod, cb_args} = Tres.Utils.get_callback_module()
    DynamicSupervisor.start_child(__MODULE__, {cb_mod, [{dpid, aux_id}, cb_args]})
  end

  @spec count_handlers() :: non_neg_integer()
  def count_handlers do
    count_value = DynamicSupervisor.count_children(__MODULE__)
    count_value[:active]
  end
end
