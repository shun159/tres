defmodule LeaderExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :leader_example,
      version: "0.1.0",
      elixir: "~> 1.6",
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :libcluster, :locks, :tres],
      mod: {LeaderExample.Application, []}
    ]
  end

  defp deps do
    [{:locks, "~> 0.2.0"},
     {:libcluster, "~> 2.3.0"},
     {:tres, path: "../../../tres"}]
  end
end
