defmodule Tres.Mixfile do
  use Mix.Project

  @description """
  OpenFlow controller library for Elixir
  """

  def project do
    [
      app: :tres,
      version: "0.1.3",
      description: @description,
      elixir: "~> 1.8",
      package: package(),
      start_permanent: Mix.env() == :prod,
      compilers: [:erlang] ++ Mix.compilers(),
      deps: deps(),
      aliases: [
        test: [
          "test"
        ],
        generate_enum: [
          "run priv/openflow_enum_gen.exs",
          "format"
        ]
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
      ],
      OpenflowStandardMessages: [
        Openflow.Hello,
        Openflow.ErrorMsg,
        Openflow.Echo.Request,
        Openflow.Echo.Reply,
        Openflow.Experimenter,
        Openflow.Features.Request,
        Openflow.Features.Reply,
        Openflow.GetConfig.Request,
        Openflow.GetConfig.Reply,
        Openflow.SetConfig,
        Openflow.PacketIn,
        Openflow.FlowRemoved,
        Openflow.PortStatus,
        Openflow.PacketOut,
        Openflow.FlowMod,
        Openflow.GroupMod,
        Openflow.PortMod,
        Openflow.TableMod,
        Openflow.Multipart.Request,
        Openflow.Multipart.Reply,
        Openflow.Barrier.Request,
        Openflow.Barrier.Reply,
        Openflow.Role.Request,
        Openflow.Role.Reply,
        Openflow.GetAsync.Request,
        Openflow.GetAsync.Reply,
        Openflow.SetAsync,
        Openflow.MeterMod
      ],
      ExtendedOpenflowMessages: [
        Openflow.NxSetPacketInFormat,
        Openflow.NxSetControllerId,
        Openflow.NxFlowMonitor.Cancel,
        Openflow.NxFlowMonitor.Paused,
        Openflow.NxFlowMonitor.Resumed,
        Openflow.NxTLVTableMod,
        Openflow.NxTLVTable.Request,
        Openflow.NxTLVTable.Reply,
        Openflow.NxSetAsyncConfig2,
        Openflow.NxResume,
        Openflow.NxCtFlushZone,
        Openflow.NxPacketIn2,
        Openflow.OnfBundleControl,
        Openflow.OnfBundleAddMessage
      ]
    ]
  end

  defp package do
    [
      maintainers: ["Eishun Kondoh"],
      licenses: ["SUSHI-WARE", "Apache 2.0"],
      links: %{"GitHub" => "https://github.com/shun159/tres"},
      files: ~w(.formatter.exs mix.exs README.md lib priv src)
    ]
  end
end
