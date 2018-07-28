defmodule Tres.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tres,
      version: "0.1.0",
      elixir: "~> 1.5",
      start_permanent: Mix.env() == :prod,
      escript: [main_module: Openflow.EnumGen, name: :enum_gen, path: "bin/enum_gen"],
      compilers: [:erlang] ++ Mix.compilers(),
      deps: deps(),
      aliases: [test: "test --no-start", compile: ["escript.build"]]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:logger, :ranch, :eovsdb], mod: {Tres.Application, []}]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ranch, "~> 1.4.0"},
      {:eovsdb, github: "shun159/eovsdb", branch: "master"},
      {:jsone, github: "sile/jsone", tag: "1.4.6", override: true},
      {:epcap, github: "msantos/epcap", branch: "master", only: :test}
    ]
  end
end
