defmodule Tres.MessageHandlerSup do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    children = [worker(Tres.MessageHandler, [], restart: :temporary)]
    supervise(children, strategy: :simple_one_for_one)
  end

  def start_child({ip_addr, port}) do
    Supervisor.start_child(__MODULE__, [{ip_addr, port}, self()])
  end
end
