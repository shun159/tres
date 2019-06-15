defmodule SimpleRouter.Supervisor do
  @moduledoc """
  Top Level supervisor
  """

  use Supervisor

  @children []

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_args) do
    Supervisor.init(@children, strategy: :one_for_one)
  end
end
