defmodule OVSDB do
  @moduledoc false

  @behaviour :supervisor

  def start_link do
    :supervisor.start_link({:local, __MODULE__}, __MODULE__, [])
  end

  def init([]) do
    child = OVSDB.OpenvSwitch
    strategy = :simple_one_for_one
    max_r = 1000
    intensity = 3600
    sup_flags = {strategy, max_r, intensity}
    {:ok, {sup_flags, [{child, {child, :start_link, []}, :temporary, 1000, :worker, [child]}]}}
  end

  def start_child(server) do
    :supervisor.start_child(__MODULE__, [server])
  end
end
