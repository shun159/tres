defmodule Tres.Instructions do
  @moduledoc """
  Instruction Aliases
  """

  defmacro __using__(_) do
    quote do
      alias Openflow.Instruction.GotoTable
      alias Openflow.Instruction.WriteMetadata
      alias Openflow.Instruction.WriteActions
      alias Openflow.Instruction.ApplyActions
      alias Openflow.Instruction.ClearActions
      alias Openflow.Instruction.Meter
    end
  end
end
