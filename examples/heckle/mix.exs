defmodule Heckle.Mixfile do
  use Mix.Project

  @tres_path "../../../tres"

  def project do
    [app: :heckle,
     version: "0.1.0",
     elixir: "~> 1.5",
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [extra_applications: [:logger, :tres],
     mod: {Heckle.Application, []}]
  end

  defp deps do
    [{:tres, path: @tres_path},
     {:pkt,  github: "msantos/pkt", branch: "master"}]
  end
end
