defmodule Tres.Messages do
  defmacro __using__(_) do
    quote do
      alias Openflow.ErrorMsg
      alias Openflow.Echo
      alias Openflow.Features
      alias Openflow.GetConfig
      alias Openflow.SetConfig
      alias Openflow.PacketIn
      alias Openflow.FlowRemoved
      alias Openflow.PortStatus
      alias Openflow.PacketOut
      alias Openflow.FlowMod
      alias Openflow.GroupMod
      alias Openflow.PortMod
      alias Openflow.TableMod
      alias Openflow.Multipart
      alias Openflow.Barrier
      alias Openflow.Role
      alias Openflow.GetAsync
      alias Openflow.SetAsync
      alias Openflow.MeterMod

      alias Openflow.Match
      alias Openflow.Port

      alias Openflow.NxSetPacketInFormat
      alias Openflow.NxSetControllerId
      alias Openflow.NxPacketIn2

      alias Openflow.Multipart.Desc
      alias Openflow.Multipart.Flow
      alias Openflow.Multipart.Aggregate
      alias Openflow.Multipart.Table
      alias Openflow.Multipart.PortStats
      alias Openflow.Multipart.Queue
      alias Openflow.Multipart.Group
      alias Openflow.Multipart.GroupDesc
      alias Openflow.Multipart.GroupFeatures
      alias Openflow.Multipart.Meter
      alias Openflow.Multipart.MeterConfig
      alias Openflow.Multipart.MeterFeatures
      alias Openflow.Multipart.TableFeatures
      alias Openflow.Multipart.PortDesc

      alias Tres.SwitchRegistry
    end
  end
end
