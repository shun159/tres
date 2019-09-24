defmodule Tres.Actions do
  @moduledoc """
  Action aliases
  """

  defmacro __using__(_) do
    quote do
      alias Openflow.Action.Output
      alias Openflow.Action.CopyTtlOut
      alias Openflow.Action.CopyTtlIn
      alias Openflow.Action.SetMplsTtl
      alias Openflow.Action.DecMplsTtl
      alias Openflow.Action.PushVlan
      alias Openflow.Action.PopVlan
      alias Openflow.Action.PushMpls
      alias Openflow.Action.PopMpls
      alias Openflow.Action.SetQueue
      alias Openflow.Action.Group
      alias Openflow.Action.SetNwTtl
      alias Openflow.Action.DecNwTtl
      alias Openflow.Action.SetField
      alias Openflow.Action.PushPbb
      alias Openflow.Action.PopPbb
      alias Openflow.Action.Encap
      alias Openflow.Action.Decap
      alias Openflow.Action.SetSequence
      alias Openflow.Action.ValidateSequence

      alias Openflow.Action.NxResubmit
      alias Openflow.Action.NxSetTunnel
      alias Openflow.Action.NxSetQueue
      alias Openflow.Action.NxPopQueue
      alias Openflow.Action.NxRegMove
      alias Openflow.Action.NxRegLoad
      alias Openflow.Action.NxNote
      alias Openflow.Action.NxSetTunnel64
      alias Openflow.Action.NxMultipath
      alias Openflow.Action.NxBundle
      alias Openflow.Action.NxBundleLoad
      alias Openflow.Action.NxResubmitTable
      alias Openflow.Action.NxOutputReg
      alias Openflow.Action.NxLearn
      alias Openflow.Action.NxExit
      alias Openflow.Action.NxDecTtl
      alias Openflow.Action.NxFinTimeout
      alias Openflow.Action.NxController
      alias Openflow.Action.NxDecTtlCntIds
      alias Openflow.Action.NxWriteMetadata
      alias Openflow.Action.NxPushMpls
      alias Openflow.Action.NxPopMpls
      alias Openflow.Action.NxSetMplsTtl
      alias Openflow.Action.NxDecMplsTtl
      alias Openflow.Action.NxStackPush
      alias Openflow.Action.NxStackPop
      alias Openflow.Action.NxSample
      alias Openflow.Action.NxSetMplsLabel
      alias Openflow.Action.NxSetMplsTc
      alias Openflow.Action.NxOutputReg2
      alias Openflow.Action.NxRegLoad2
      alias Openflow.Action.NxConjunction
      alias Openflow.Action.NxConntrack
      alias Openflow.Action.NxNat
      alias Openflow.Action.NxController2
      alias Openflow.Action.NxSample2
      alias Openflow.Action.NxOutputTrunc
      alias Openflow.Action.NxGroup
      alias Openflow.Action.NxSample3
      alias Openflow.Action.NxClone
      alias Openflow.Action.NxCtClear
      alias Openflow.Action.NxResubmitTableCt
      alias Openflow.Action.NxLearn2
      alias Openflow.Action.NxEncap
      alias Openflow.Action.NxDecap
      alias Openflow.Action.NxDebugRecirc
      alias Openflow.Action.NxCheckPktLarger

      alias Openflow.Action.NxFlowSpecMatch
      alias Openflow.Action.NxFlowSpecLoad
      alias Openflow.Action.NxFlowSpecOutput
    end
  end
end
