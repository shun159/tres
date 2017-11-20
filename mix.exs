defmodule Tres.Mixfile do
  use Mix.Project

  def project do
    [app: :tres,
     version: "0.1.0",
     elixir: "~> 1.5",
     start_permanent: Mix.env == :prod,
     compilers: [:erlang] ++ Mix.compilers,
     deps: deps(),
     aliases: [test: "test --no-start"]]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:logger, :ranch],
     mod: {Tres.Application, []}]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:ranch, "~> 1.4.0"},
     {:binpp, github: "jtendo/binpp", branch: "master"},
     {:pkt, github: "msantos/pkt", ref: "3afb196", only: :test, override: true},
     {:epcap, github: "msantos/epcap", branch: "master", only: :test}]
  end
end
