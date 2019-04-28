defmodule Tres.Mixfile do
  use Mix.Project

  def project do
    [
      app: :tres,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      compilers: [:erlang] ++ Mix.compilers(),
      deps: deps(),
      aliases: [
        test: "test --no-start",
        compile: ["run priv/openflow_enum_gen.exs"]
      ],
      docs: docs(),
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [extra_applications: [:logger], mod: {Tres.Application, []}]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ranch, "~> 1.7.1"},
      {:eovsdb, github: "shun159/eovsdb", branch: "master"},
      {:jsone, github: "sile/jsone", tag: "1.4.6", override: true},
      {:excoveralls, "~> 0.10", only: :test},
      # Document
      {:earmark, "~> 1.2.6", only: :dev, runtime: false},
      {:ex_doc, "~> 0.19", only: :dev, runtime: false}
    ]
  end

  defp docs do
    [
      groups_for_modules: groups_for_modules(),
      formatters: ["html"]
    ]
  end

  defp groups_for_modules do
    [
      Actions: [
        Openflow.Action.Output,
        Openflow.Action.CopyTtlOut,
        Openflow.Action.CopyTtlIn,
        Openflow.Action.SetMplsTtl,
        Openflow.Action.DecMplsTtl,
        Openflow.Action.PushVlan,
        Openflow.Action.PopVlan,
        Openflow.Action.PushMpls,
        Openflow.Action.PopMpls,
        Openflow.Action.SetQueue,
        Openflow.Action.Group,
        Openflow.Action.SetNwTtl,
        Openflow.Action.DecNwTtl,
        Openflow.Action.SetField,
        Openflow.Action.PushPbb,
        Openflow.Action.PopPbb,
        Openflow.Action.NxResubmit,
        Openflow.Action.NxSetTunnel,
        Openflow.Action.NxRegMove,
        Openflow.Action.NxRegLoad,
        Openflow.Action.NxNote,
        Openflow.Action.NxSetTunnel64,
        Openflow.Action.NxMultipath,
        Openflow.Action.NxBundle,
        Openflow.Action.NxBundleLoad,
        Openflow.Action.NxResubmitTable,
        Openflow.Action.NxOutputReg,
        Openflow.Action.NxLearn,
        Openflow.Action.NxExit,
        Openflow.Action.NxDecTtl,
        Openflow.Action.NxFinTimeout,
        Openflow.Action.NxController,
        Openflow.Action.NxDecTtlCntIds,
        Openflow.Action.NxWriteMetadata,
        Openflow.Action.NxPushMpls,
        Openflow.Action.NxPopMpls,
        Openflow.Action.NxStackPush,
        Openflow.Action.NxStackPop,
        Openflow.Action.NxSample,
        Openflow.Action.NxOutputReg2,
        Openflow.Action.NxRegLoad2,
        Openflow.Action.NxConjunction,
        Openflow.Action.NxConntrack,
        Openflow.Action.NxNat,
        Openflow.Action.NxController2,
        Openflow.Action.NxSample2,
        Openflow.Action.NxOutputTrunc,
        Openflow.Action.NxGroup,
        Openflow.Action.NxSample3,
        Openflow.Action.NxClone,
        Openflow.Action.NxCtClear,
        Openflow.Action.NxResubmitTableCt,
        Openflow.Action.NxLearn2
      ]
    ]
  end
end
