defmodule PatchPanel.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias PatchPanel.Openflow

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(Registry, [[keys: :unique, name: Openflow.Registry]], id: Openflow.Registry),
    ]

    opts = [strategy: :one_for_one, name: PatchPanel.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
