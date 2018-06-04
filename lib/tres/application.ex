defmodule Tres.Application do
  @moduledoc false

  use Application

  alias Tres.SwitchRegistry

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Registry, [[keys: :unique, name: SwitchRegistry]], id: SwitchRegistry),
      supervisor(Tres.MessageHandlerSup, [], id: MessageHandlerSup),
      supervisor(OVSDB, [], id: OVSDB)
    ]

    opts = [strategy: :one_for_one, name: Tres.Supervisor]
    {:ok, _connection_pid} = Tres.Utils.start_openflow_listener()
    Supervisor.start_link(children, opts)
  end
end
