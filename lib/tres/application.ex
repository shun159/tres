defmodule Tres.Application do
  @moduledoc false

  use Application

  alias Tres.SwitchRegistry

  def start(_type, _args) do
    import Supervisor.Spec

    {cb_mod, _cb_args} = Tres.Utils.get_callback_module
    children = [worker(Registry, [[keys: :unique, name: SwitchRegistry]], id: SwitchRegistry),
                supervisor(Tres.MessageHandlerSup, [cb_mod], id: MessageHandlerSup),
                supervisor(OVSDB, [], id: OVSDB)]
    opts = [strategy: :one_for_one, name: Tres.Supervisor]
    {:ok, _connection_pid} = Tres.Utils.start_openflow_listener
    Supervisor.start_link(children, opts)
  end
end
