defmodule SimpleRouter.MixProject do
  use Mix.Project

  def project do
    [
      app: :simple_router,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :tres, :pkt],
      mod: {SimpleRouter.Application, []}
    ]
  end

  defp deps do
    [
      {:tres, path: "../../../tres"},
      {:pkt, github: "msantos/pkt"}
    ]
  end
end
