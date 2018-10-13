defmodule EvpnRouter.MixProject do
  use Mix.Project

  def project do
    [
      app: :evpn_router,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      compilers: [:rustler] ++ Mix.compilers,
      rustler_crates: rustler_crates(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger, :grpc, :tres],
      mod: {EvpnRouter.Application, []}
    ]
  end

  defp deps do
    [
      {:tres, path: "../../../tres"},
      {:rustler, github: "hansihe/rustler", sparse: "rustler_mix"},
      {:grpc, github: "tony612/grpc-elixir"},
      {:ranch, "~> 1.6.0", override: true},
    ]
  end

  defp rustler_crates do
    [evpn_router: [path: "native/evpn_router", mode: rustc_mode(Mix.env)]]
  end

  defp rustc_mode(:prod), do: :release
  defp rustc_mode(_), do: :debug
end
