defmodule OfpInstructionTest do
  use ExUnit.Case
  doctest Openflow

  alias Openflow.Instruction.{
    ApplyActions,
    WriteActions,
    ClearActions,
    GotoTable,
    WriteMetadata,
    Meter,
    Experimenter
  }

  describe "Openflow.Instruction" do
    test "with all instructions parse and generate" do
      instructions = [
        ApplyActions.new([Openflow.Action.Output.new(:controller)]),
        WriteActions.new([Openflow.Action.Output.new(5)]),
        ClearActions.new(),
        GotoTable.new(10),
        WriteMetadata.new(value: 100, mask: 0xFFFFFFFFFFFFFFFF),
        Meter.new(100),
        Experimenter.new(0xCAFEBABE, "hogehoge"),
        Experimenter.new(0xCAFEBABE)
      ]

      instructions
      |> Openflow.Instruction.to_binary()
      |> Openflow.Instruction.read()
      |> Kernel.==(instructions)
      |> assert()
    end
  end
end
