defmodule Openflow.Action do
  @moduledoc """
  Openflow parser handler
  """

  @type type ::
          Openflow.Action.Output.t()
          | Openflow.Action.CopyTtlOut.t()
          | Openflow.Action.CopyTtlIn.t()
          | Openflow.Action.SetMplsTtl.t()
          | Openflow.Action.DecMplsTtl.t()
          | Openflow.Action.PushVlan.t()
          | Openflow.Action.PopVlan.t()
          | Openflow.Action.PushMpls.t()
          | Openflow.Action.PopMpls.t()
          | Openflow.Action.SetQueue.t()
          | Openflow.Action.Group.t()
          | Openflow.Action.SetNwTtl.t()
          | Openflow.Action.DecNwTtl.t()
          | Openflow.Action.SetField.t()
          | Openflow.Action.PushPbb.t()
          | Openflow.Action.PopPbb.t()
          | Openflow.Action.NxResubmit.t()
          | Openflow.Action.NxSetTunnel.t()
          | Openflow.Action.NxRegMove.t()
          | Openflow.Action.NxRegLoad.t()
          | Openflow.Action.NxNote.t()
          | Openflow.Action.NxSetTunnel64.t()
          | Openflow.Action.NxMultipath.t()
          | Openflow.Action.NxBundle.t()
          | Openflow.Action.NxBundleLoad.t()
          | Openflow.Action.NxResubmitTable.t()
          | Openflow.Action.NxOutputReg.t()
          | Openflow.Action.NxLearn.t()
          | Openflow.Action.NxExit.t()
          | Openflow.Action.NxDecTtl.t()
          | Openflow.Action.NxFinTimeout.t()
          | Openflow.Action.NxController.t()
          | Openflow.Action.NxDecTtlCntIds.t()
          | Openflow.Action.NxWriteMetadata.t()
          | Openflow.Action.NxPushMpls.t()
          | Openflow.Action.NxPopMpls.t()
          | Openflow.Action.NxStackPush.t()
          | Openflow.Action.NxStackPop.t()
          | Openflow.Action.NxSample.t()
          | Openflow.Action.NxOutputReg2.t()
          | Openflow.Action.NxRegLoad2.t()
          | Openflow.Action.NxConjunction.t()
          | Openflow.Action.NxConntrack.t()
          | Openflow.Action.NxNat.t()
          | Openflow.Action.NxController2.t()
          | Openflow.Action.NxSample2.t()
          | Openflow.Action.NxOutputTrunc.t()
          | Openflow.Action.NxGroup.t()
          | Openflow.Action.NxSample3.t()
          | Openflow.Action.NxClone.t()
          | Openflow.Action.NxCtClear.t()
          | Openflow.Action.NxResubmitTableCt.t()
          | Openflow.Action.NxLearn2.t()

  def read(action_bin) do
    do_read([], action_bin)
  end

  def to_binary(actions) when is_list(actions) do
    to_binary(<<>>, actions)
  end

  def to_binary(action) do
    to_binary([action])
  end

  # private functions

  defp do_read(acc, <<>>), do: Enum.reverse(acc)
  defp do_read(acc, <<0::32, _::bytes>>), do: Enum.reverse(acc)

  defp do_read(acc, <<type::16, length::16, _::bytes>> = binary) do
    <<action_bin::size(length)-bytes, rest::bytes>> = binary
    codec = Openflow.Enums.to_atom(type, :action_type)
    do_read([codec.read(action_bin) | acc], rest)
  end

  defp to_binary(acc, []), do: acc

  defp to_binary(acc, [action | rest]) do
    codec = action.__struct__
    to_binary(<<acc::bytes, codec.to_binary(action)::bytes>>, rest)
  end
end
