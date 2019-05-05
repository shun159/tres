defmodule Openflow.Enums do
  @moduledoc "auto generated code"

  def to_int(Openflow.Hello, :openflow_codec) do
    openflow_codec_to_int(Openflow.Hello)
  catch
    _class, _reason -> Openflow.Hello
  end

  def to_int(Openflow.ErrorMsg, :openflow_codec) do
    openflow_codec_to_int(Openflow.ErrorMsg)
  catch
    _class, _reason -> Openflow.ErrorMsg
  end

  def to_int(Openflow.Echo.Request, :openflow_codec) do
    openflow_codec_to_int(Openflow.Echo.Request)
  catch
    _class, _reason -> Openflow.Echo.Request
  end

  def to_int(Openflow.Echo.Reply, :openflow_codec) do
    openflow_codec_to_int(Openflow.Echo.Reply)
  catch
    _class, _reason -> Openflow.Echo.Reply
  end

  def to_int(Openflow.Experimenter, :openflow_codec) do
    openflow_codec_to_int(Openflow.Experimenter)
  catch
    _class, _reason -> Openflow.Experimenter
  end

  def to_int(Openflow.Features.Request, :openflow_codec) do
    openflow_codec_to_int(Openflow.Features.Request)
  catch
    _class, _reason -> Openflow.Features.Request
  end

  def to_int(Openflow.Features.Reply, :openflow_codec) do
    openflow_codec_to_int(Openflow.Features.Reply)
  catch
    _class, _reason -> Openflow.Features.Reply
  end

  def to_int(Openflow.GetConfig.Request, :openflow_codec) do
    openflow_codec_to_int(Openflow.GetConfig.Request)
  catch
    _class, _reason -> Openflow.GetConfig.Request
  end

  def to_int(Openflow.GetConfig.Reply, :openflow_codec) do
    openflow_codec_to_int(Openflow.GetConfig.Reply)
  catch
    _class, _reason -> Openflow.GetConfig.Reply
  end

  def to_int(Openflow.SetConfig, :openflow_codec) do
    openflow_codec_to_int(Openflow.SetConfig)
  catch
    _class, _reason -> Openflow.SetConfig
  end

  def to_int(Openflow.PacketIn, :openflow_codec) do
    openflow_codec_to_int(Openflow.PacketIn)
  catch
    _class, _reason -> Openflow.PacketIn
  end

  def to_int(Openflow.FlowRemoved, :openflow_codec) do
    openflow_codec_to_int(Openflow.FlowRemoved)
  catch
    _class, _reason -> Openflow.FlowRemoved
  end

  def to_int(Openflow.PortStatus, :openflow_codec) do
    openflow_codec_to_int(Openflow.PortStatus)
  catch
    _class, _reason -> Openflow.PortStatus
  end

  def to_int(Openflow.PacketOut, :openflow_codec) do
    openflow_codec_to_int(Openflow.PacketOut)
  catch
    _class, _reason -> Openflow.PacketOut
  end

  def to_int(Openflow.FlowMod, :openflow_codec) do
    openflow_codec_to_int(Openflow.FlowMod)
  catch
    _class, _reason -> Openflow.FlowMod
  end

  def to_int(Openflow.GroupMod, :openflow_codec) do
    openflow_codec_to_int(Openflow.GroupMod)
  catch
    _class, _reason -> Openflow.GroupMod
  end

  def to_int(Openflow.PortMod, :openflow_codec) do
    openflow_codec_to_int(Openflow.PortMod)
  catch
    _class, _reason -> Openflow.PortMod
  end

  def to_int(Openflow.TableMod, :openflow_codec) do
    openflow_codec_to_int(Openflow.TableMod)
  catch
    _class, _reason -> Openflow.TableMod
  end

  def to_int(Openflow.Multipart.Request, :openflow_codec) do
    openflow_codec_to_int(Openflow.Multipart.Request)
  catch
    _class, _reason -> Openflow.Multipart.Request
  end

  def to_int(Openflow.Multipart.Reply, :openflow_codec) do
    openflow_codec_to_int(Openflow.Multipart.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Reply
  end

  def to_int(Openflow.Barrier.Request, :openflow_codec) do
    openflow_codec_to_int(Openflow.Barrier.Request)
  catch
    _class, _reason -> Openflow.Barrier.Request
  end

  def to_int(Openflow.Barrier.Reply, :openflow_codec) do
    openflow_codec_to_int(Openflow.Barrier.Reply)
  catch
    _class, _reason -> Openflow.Barrier.Reply
  end

  def to_int(Openflow.Role.Request, :openflow_codec) do
    openflow_codec_to_int(Openflow.Role.Request)
  catch
    _class, _reason -> Openflow.Role.Request
  end

  def to_int(Openflow.Role.Reply, :openflow_codec) do
    openflow_codec_to_int(Openflow.Role.Reply)
  catch
    _class, _reason -> Openflow.Role.Reply
  end

  def to_int(Openflow.GetAsync.Request, :openflow_codec) do
    openflow_codec_to_int(Openflow.GetAsync.Request)
  catch
    _class, _reason -> Openflow.GetAsync.Request
  end

  def to_int(Openflow.GetAsync.Reply, :openflow_codec) do
    openflow_codec_to_int(Openflow.GetAsync.Reply)
  catch
    _class, _reason -> Openflow.GetAsync.Reply
  end

  def to_int(Openflow.SetAsync, :openflow_codec) do
    openflow_codec_to_int(Openflow.SetAsync)
  catch
    _class, _reason -> Openflow.SetAsync
  end

  def to_int(Openflow.MeterMod, :openflow_codec) do
    openflow_codec_to_int(Openflow.MeterMod)
  catch
    _class, _reason -> Openflow.MeterMod
  end

  def to_int(_int, :openflow_codec) do
    throw(:bad_enum)
  end

  def to_int(:nicira_ext_message, :experimenter_id) do
    experimenter_id_to_int(:nicira_ext_message)
  catch
    _class, _reason -> :nicira_ext_message
  end

  def to_int(:onf_ext_message, :experimenter_id) do
    experimenter_id_to_int(:onf_ext_message)
  catch
    _class, _reason -> :onf_ext_message
  end

  def to_int(_int, :experimenter_id) do
    throw(:bad_enum)
  end

  def to_int(Openflow.NxSetPacketInFormat, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxSetPacketInFormat)
  catch
    _class, _reason -> Openflow.NxSetPacketInFormat
  end

  def to_int(Openflow.NxSetControllerId, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxSetControllerId)
  catch
    _class, _reason -> Openflow.NxSetControllerId
  end

  def to_int(Openflow.NxFlowMonitor.Cancel, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxFlowMonitor.Cancel)
  catch
    _class, _reason -> Openflow.NxFlowMonitor.Cancel
  end

  def to_int(Openflow.NxFlowMonitor.Paused, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxFlowMonitor.Paused)
  catch
    _class, _reason -> Openflow.NxFlowMonitor.Paused
  end

  def to_int(Openflow.NxFlowMonitor.Resumed, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxFlowMonitor.Resumed)
  catch
    _class, _reason -> Openflow.NxFlowMonitor.Resumed
  end

  def to_int(Openflow.NxTLVTableMod, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxTLVTableMod)
  catch
    _class, _reason -> Openflow.NxTLVTableMod
  end

  def to_int(Openflow.NxTLVTable.Request, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxTLVTable.Request)
  catch
    _class, _reason -> Openflow.NxTLVTable.Request
  end

  def to_int(Openflow.NxTLVTable.Reply, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxTLVTable.Reply)
  catch
    _class, _reason -> Openflow.NxTLVTable.Reply
  end

  def to_int(Openflow.NxSetAsyncConfig2, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxSetAsyncConfig2)
  catch
    _class, _reason -> Openflow.NxSetAsyncConfig2
  end

  def to_int(Openflow.NxResume, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxResume)
  catch
    _class, _reason -> Openflow.NxResume
  end

  def to_int(Openflow.NxCtFlushZone, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxCtFlushZone)
  catch
    _class, _reason -> Openflow.NxCtFlushZone
  end

  def to_int(Openflow.NxPacketIn2, :nicira_ext_message) do
    nicira_ext_message_to_int(Openflow.NxPacketIn2)
  catch
    _class, _reason -> Openflow.NxPacketIn2
  end

  def to_int(_int, :nicira_ext_message) do
    throw(:bad_enum)
  end

  def to_int(Openflow.OnfBundleControl, :onf_ext_message) do
    onf_ext_message_to_int(Openflow.OnfBundleControl)
  catch
    _class, _reason -> Openflow.OnfBundleControl
  end

  def to_int(Openflow.OnfBundleAddMessage, :onf_ext_message) do
    onf_ext_message_to_int(Openflow.OnfBundleAddMessage)
  catch
    _class, _reason -> Openflow.OnfBundleAddMessage
  end

  def to_int(_int, :onf_ext_message) do
    throw(:bad_enum)
  end

  def to_int(:more, :multipart_request_flags) do
    multipart_request_flags_to_int(:more)
  catch
    _class, _reason -> :more
  end

  def to_int(_int, :multipart_request_flags) do
    throw(:bad_enum)
  end

  def to_int(:more, :multipart_reply_flags) do
    multipart_reply_flags_to_int(:more)
  catch
    _class, _reason -> :more
  end

  def to_int(_int, :multipart_reply_flags) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Multipart.Desc.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.Desc.Request)
  catch
    _class, _reason -> Openflow.Multipart.Desc.Request
  end

  def to_int(Openflow.Multipart.Flow.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.Flow.Request)
  catch
    _class, _reason -> Openflow.Multipart.Flow.Request
  end

  def to_int(Openflow.Multipart.Aggregate.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.Aggregate.Request)
  catch
    _class, _reason -> Openflow.Multipart.Aggregate.Request
  end

  def to_int(Openflow.Multipart.Table.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.Table.Request)
  catch
    _class, _reason -> Openflow.Multipart.Table.Request
  end

  def to_int(Openflow.Multipart.PortStats.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.PortStats.Request)
  catch
    _class, _reason -> Openflow.Multipart.PortStats.Request
  end

  def to_int(Openflow.Multipart.Queue.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.Queue.Request)
  catch
    _class, _reason -> Openflow.Multipart.Queue.Request
  end

  def to_int(Openflow.Multipart.Group.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.Group.Request)
  catch
    _class, _reason -> Openflow.Multipart.Group.Request
  end

  def to_int(Openflow.Multipart.GroupDesc.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.GroupDesc.Request)
  catch
    _class, _reason -> Openflow.Multipart.GroupDesc.Request
  end

  def to_int(Openflow.Multipart.GroupFeatures.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.GroupFeatures.Request)
  catch
    _class, _reason -> Openflow.Multipart.GroupFeatures.Request
  end

  def to_int(Openflow.Multipart.Meter.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.Meter.Request)
  catch
    _class, _reason -> Openflow.Multipart.Meter.Request
  end

  def to_int(Openflow.Multipart.MeterConfig.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.MeterConfig.Request)
  catch
    _class, _reason -> Openflow.Multipart.MeterConfig.Request
  end

  def to_int(Openflow.Multipart.MeterFeatures.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.MeterFeatures.Request)
  catch
    _class, _reason -> Openflow.Multipart.MeterFeatures.Request
  end

  def to_int(Openflow.Multipart.TableFeatures.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.TableFeatures.Request)
  catch
    _class, _reason -> Openflow.Multipart.TableFeatures.Request
  end

  def to_int(Openflow.Multipart.PortDesc.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.PortDesc.Request)
  catch
    _class, _reason -> Openflow.Multipart.PortDesc.Request
  end

  def to_int(Openflow.Multipart.Experimenter.Request, :multipart_request_codec) do
    multipart_request_codec_to_int(Openflow.Multipart.Experimenter.Request)
  catch
    _class, _reason -> Openflow.Multipart.Experimenter.Request
  end

  def to_int(_int, :multipart_request_codec) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Multipart.Desc.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.Desc.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Desc.Reply
  end

  def to_int(Openflow.Multipart.Flow.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.Flow.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Flow.Reply
  end

  def to_int(Openflow.Multipart.Aggregate.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.Aggregate.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Aggregate.Reply
  end

  def to_int(Openflow.Multipart.Table.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.Table.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Table.Reply
  end

  def to_int(Openflow.Multipart.PortStats.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.PortStats.Reply)
  catch
    _class, _reason -> Openflow.Multipart.PortStats.Reply
  end

  def to_int(Openflow.Multipart.Queue.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.Queue.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Queue.Reply
  end

  def to_int(Openflow.Multipart.Group.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.Group.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Group.Reply
  end

  def to_int(Openflow.Multipart.GroupDesc.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.GroupDesc.Reply)
  catch
    _class, _reason -> Openflow.Multipart.GroupDesc.Reply
  end

  def to_int(Openflow.Multipart.GroupFeatures.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.GroupFeatures.Reply)
  catch
    _class, _reason -> Openflow.Multipart.GroupFeatures.Reply
  end

  def to_int(Openflow.Multipart.Meter.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.Meter.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Meter.Reply
  end

  def to_int(Openflow.Multipart.MeterConfig.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.MeterConfig.Reply)
  catch
    _class, _reason -> Openflow.Multipart.MeterConfig.Reply
  end

  def to_int(Openflow.Multipart.MeterFeatures.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.MeterFeatures.Reply)
  catch
    _class, _reason -> Openflow.Multipart.MeterFeatures.Reply
  end

  def to_int(Openflow.Multipart.TableFeatures.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.TableFeatures.Reply)
  catch
    _class, _reason -> Openflow.Multipart.TableFeatures.Reply
  end

  def to_int(Openflow.Multipart.PortDesc.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.PortDesc.Reply)
  catch
    _class, _reason -> Openflow.Multipart.PortDesc.Reply
  end

  def to_int(Openflow.Multipart.Experimenter.Reply, :multipart_reply_codec) do
    multipart_reply_codec_to_int(Openflow.Multipart.Experimenter.Reply)
  catch
    _class, _reason -> Openflow.Multipart.Experimenter.Reply
  end

  def to_int(_int, :multipart_reply_codec) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Multipart.NxFlow, :nicira_ext_stats) do
    nicira_ext_stats_to_int(Openflow.Multipart.NxFlow)
  catch
    _class, _reason -> Openflow.Multipart.NxFlow
  end

  def to_int(Openflow.Multipart.NxAggregate, :nicira_ext_stats) do
    nicira_ext_stats_to_int(Openflow.Multipart.NxAggregate)
  catch
    _class, _reason -> Openflow.Multipart.NxAggregate
  end

  def to_int(Openflow.Multipart.NxFlowMonitor, :nicira_ext_stats) do
    nicira_ext_stats_to_int(Openflow.Multipart.NxFlowMonitor)
  catch
    _class, _reason -> Openflow.Multipart.NxFlowMonitor
  end

  def to_int(Openflow.Multipart.NxIPFIXBridge, :nicira_ext_stats) do
    nicira_ext_stats_to_int(Openflow.Multipart.NxIPFIXBridge)
  catch
    _class, _reason -> Openflow.Multipart.NxIPFIXBridge
  end

  def to_int(Openflow.Multipart.NxIPFIXFlow, :nicira_ext_stats) do
    nicira_ext_stats_to_int(Openflow.Multipart.NxIPFIXFlow)
  catch
    _class, _reason -> Openflow.Multipart.NxIPFIXFlow
  end

  def to_int(_int, :nicira_ext_stats) do
    throw(:bad_enum)
  end

  def to_int(:versionbitmap, :hello_elem) do
    hello_elem_to_int(:versionbitmap)
  catch
    _class, _reason -> :versionbitmap
  end

  def to_int(_int, :hello_elem) do
    throw(:bad_enum)
  end

  def to_int(:hello_failed, :error_type) do
    error_type_to_int(:hello_failed)
  catch
    _class, _reason -> :hello_failed
  end

  def to_int(:bad_request, :error_type) do
    error_type_to_int(:bad_request)
  catch
    _class, _reason -> :bad_request
  end

  def to_int(:bad_action, :error_type) do
    error_type_to_int(:bad_action)
  catch
    _class, _reason -> :bad_action
  end

  def to_int(:bad_instruction, :error_type) do
    error_type_to_int(:bad_instruction)
  catch
    _class, _reason -> :bad_instruction
  end

  def to_int(:bad_match, :error_type) do
    error_type_to_int(:bad_match)
  catch
    _class, _reason -> :bad_match
  end

  def to_int(:flow_mod_failed, :error_type) do
    error_type_to_int(:flow_mod_failed)
  catch
    _class, _reason -> :flow_mod_failed
  end

  def to_int(:group_mod_failed, :error_type) do
    error_type_to_int(:group_mod_failed)
  catch
    _class, _reason -> :group_mod_failed
  end

  def to_int(:port_mod_failed, :error_type) do
    error_type_to_int(:port_mod_failed)
  catch
    _class, _reason -> :port_mod_failed
  end

  def to_int(:table_mod_failed, :error_type) do
    error_type_to_int(:table_mod_failed)
  catch
    _class, _reason -> :table_mod_failed
  end

  def to_int(:queue_op_failed, :error_type) do
    error_type_to_int(:queue_op_failed)
  catch
    _class, _reason -> :queue_op_failed
  end

  def to_int(:switch_config_failed, :error_type) do
    error_type_to_int(:switch_config_failed)
  catch
    _class, _reason -> :switch_config_failed
  end

  def to_int(:role_request_failed, :error_type) do
    error_type_to_int(:role_request_failed)
  catch
    _class, _reason -> :role_request_failed
  end

  def to_int(:meter_mod_failed, :error_type) do
    error_type_to_int(:meter_mod_failed)
  catch
    _class, _reason -> :meter_mod_failed
  end

  def to_int(:table_features_failed, :error_type) do
    error_type_to_int(:table_features_failed)
  catch
    _class, _reason -> :table_features_failed
  end

  def to_int(:experimenter, :error_type) do
    error_type_to_int(:experimenter)
  catch
    _class, _reason -> :experimenter
  end

  def to_int(_int, :error_type) do
    throw(:bad_enum)
  end

  def to_int(:inconpatible, :hello_failed) do
    hello_failed_to_int(:inconpatible)
  catch
    _class, _reason -> :inconpatible
  end

  def to_int(:eperm, :hello_failed) do
    hello_failed_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(_int, :hello_failed) do
    throw(:bad_enum)
  end

  def to_int(:bad_version, :bad_request) do
    bad_request_to_int(:bad_version)
  catch
    _class, _reason -> :bad_version
  end

  def to_int(:bad_type, :bad_request) do
    bad_request_to_int(:bad_type)
  catch
    _class, _reason -> :bad_type
  end

  def to_int(:bad_multipart, :bad_request) do
    bad_request_to_int(:bad_multipart)
  catch
    _class, _reason -> :bad_multipart
  end

  def to_int(:bad_experimeter, :bad_request) do
    bad_request_to_int(:bad_experimeter)
  catch
    _class, _reason -> :bad_experimeter
  end

  def to_int(:bad_exp_type, :bad_request) do
    bad_request_to_int(:bad_exp_type)
  catch
    _class, _reason -> :bad_exp_type
  end

  def to_int(:eperm, :bad_request) do
    bad_request_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(:bad_len, :bad_request) do
    bad_request_to_int(:bad_len)
  catch
    _class, _reason -> :bad_len
  end

  def to_int(:buffer_empty, :bad_request) do
    bad_request_to_int(:buffer_empty)
  catch
    _class, _reason -> :buffer_empty
  end

  def to_int(:buffer_unknown, :bad_request) do
    bad_request_to_int(:buffer_unknown)
  catch
    _class, _reason -> :buffer_unknown
  end

  def to_int(:bad_table_id, :bad_request) do
    bad_request_to_int(:bad_table_id)
  catch
    _class, _reason -> :bad_table_id
  end

  def to_int(:is_slave, :bad_request) do
    bad_request_to_int(:is_slave)
  catch
    _class, _reason -> :is_slave
  end

  def to_int(:bad_port, :bad_request) do
    bad_request_to_int(:bad_port)
  catch
    _class, _reason -> :bad_port
  end

  def to_int(:bad_packet, :bad_request) do
    bad_request_to_int(:bad_packet)
  catch
    _class, _reason -> :bad_packet
  end

  def to_int(:multipart_buffer_overflow, :bad_request) do
    bad_request_to_int(:multipart_buffer_overflow)
  catch
    _class, _reason -> :multipart_buffer_overflow
  end

  def to_int(:multipart_request_timeout, :bad_request) do
    bad_request_to_int(:multipart_request_timeout)
  catch
    _class, _reason -> :multipart_request_timeout
  end

  def to_int(:multipart_reply_timeout, :bad_request) do
    bad_request_to_int(:multipart_reply_timeout)
  catch
    _class, _reason -> :multipart_reply_timeout
  end

  def to_int(:nxm_invalid, :bad_request) do
    bad_request_to_int(:nxm_invalid)
  catch
    _class, _reason -> :nxm_invalid
  end

  def to_int(:nxm_bad_type, :bad_request) do
    bad_request_to_int(:nxm_bad_type)
  catch
    _class, _reason -> :nxm_bad_type
  end

  def to_int(:must_be_zero, :bad_request) do
    bad_request_to_int(:must_be_zero)
  catch
    _class, _reason -> :must_be_zero
  end

  def to_int(:bad_reason, :bad_request) do
    bad_request_to_int(:bad_reason)
  catch
    _class, _reason -> :bad_reason
  end

  def to_int(:flow_monitor_bad_event, :bad_request) do
    bad_request_to_int(:flow_monitor_bad_event)
  catch
    _class, _reason -> :flow_monitor_bad_event
  end

  def to_int(:undecodable_error, :bad_request) do
    bad_request_to_int(:undecodable_error)
  catch
    _class, _reason -> :undecodable_error
  end

  def to_int(:resume_not_supported, :bad_request) do
    bad_request_to_int(:resume_not_supported)
  catch
    _class, _reason -> :resume_not_supported
  end

  def to_int(:resume_stale, :bad_request) do
    bad_request_to_int(:resume_stale)
  catch
    _class, _reason -> :resume_stale
  end

  def to_int(_int, :bad_request) do
    throw(:bad_enum)
  end

  def to_int(:bad_type, :bad_action) do
    bad_action_to_int(:bad_type)
  catch
    _class, _reason -> :bad_type
  end

  def to_int(:bad_len, :bad_action) do
    bad_action_to_int(:bad_len)
  catch
    _class, _reason -> :bad_len
  end

  def to_int(:bad_experimeter, :bad_action) do
    bad_action_to_int(:bad_experimeter)
  catch
    _class, _reason -> :bad_experimeter
  end

  def to_int(:bad_exp_type, :bad_action) do
    bad_action_to_int(:bad_exp_type)
  catch
    _class, _reason -> :bad_exp_type
  end

  def to_int(:bad_out_port, :bad_action) do
    bad_action_to_int(:bad_out_port)
  catch
    _class, _reason -> :bad_out_port
  end

  def to_int(:bad_argument, :bad_action) do
    bad_action_to_int(:bad_argument)
  catch
    _class, _reason -> :bad_argument
  end

  def to_int(:eperm, :bad_action) do
    bad_action_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(:too_many, :bad_action) do
    bad_action_to_int(:too_many)
  catch
    _class, _reason -> :too_many
  end

  def to_int(:bad_queue, :bad_action) do
    bad_action_to_int(:bad_queue)
  catch
    _class, _reason -> :bad_queue
  end

  def to_int(:bad_out_group, :bad_action) do
    bad_action_to_int(:bad_out_group)
  catch
    _class, _reason -> :bad_out_group
  end

  def to_int(:match_inconsistent, :bad_action) do
    bad_action_to_int(:match_inconsistent)
  catch
    _class, _reason -> :match_inconsistent
  end

  def to_int(:unsupported_order, :bad_action) do
    bad_action_to_int(:unsupported_order)
  catch
    _class, _reason -> :unsupported_order
  end

  def to_int(:bad_tag, :bad_action) do
    bad_action_to_int(:bad_tag)
  catch
    _class, _reason -> :bad_tag
  end

  def to_int(:bad_set_type, :bad_action) do
    bad_action_to_int(:bad_set_type)
  catch
    _class, _reason -> :bad_set_type
  end

  def to_int(:bad_set_len, :bad_action) do
    bad_action_to_int(:bad_set_len)
  catch
    _class, _reason -> :bad_set_len
  end

  def to_int(:bad_set_argument, :bad_action) do
    bad_action_to_int(:bad_set_argument)
  catch
    _class, _reason -> :bad_set_argument
  end

  def to_int(:must_be_zero, :bad_action) do
    bad_action_to_int(:must_be_zero)
  catch
    _class, _reason -> :must_be_zero
  end

  def to_int(:conntrack_datapath_support, :bad_action) do
    bad_action_to_int(:conntrack_datapath_support)
  catch
    _class, _reason -> :conntrack_datapath_support
  end

  def to_int(:bad_conjunction, :bad_action) do
    bad_action_to_int(:bad_conjunction)
  catch
    _class, _reason -> :bad_conjunction
  end

  def to_int(_int, :bad_action) do
    throw(:bad_enum)
  end

  def to_int(:unknown_instruction, :bad_instruction) do
    bad_instruction_to_int(:unknown_instruction)
  catch
    _class, _reason -> :unknown_instruction
  end

  def to_int(:unsupported_instruction, :bad_instruction) do
    bad_instruction_to_int(:unsupported_instruction)
  catch
    _class, _reason -> :unsupported_instruction
  end

  def to_int(:bad_table_id, :bad_instruction) do
    bad_instruction_to_int(:bad_table_id)
  catch
    _class, _reason -> :bad_table_id
  end

  def to_int(:unsupported_metadata, :bad_instruction) do
    bad_instruction_to_int(:unsupported_metadata)
  catch
    _class, _reason -> :unsupported_metadata
  end

  def to_int(:unsupported_metadata_mask, :bad_instruction) do
    bad_instruction_to_int(:unsupported_metadata_mask)
  catch
    _class, _reason -> :unsupported_metadata_mask
  end

  def to_int(:bad_experimeter, :bad_instruction) do
    bad_instruction_to_int(:bad_experimeter)
  catch
    _class, _reason -> :bad_experimeter
  end

  def to_int(:bad_exp_type, :bad_instruction) do
    bad_instruction_to_int(:bad_exp_type)
  catch
    _class, _reason -> :bad_exp_type
  end

  def to_int(:bad_len, :bad_instruction) do
    bad_instruction_to_int(:bad_len)
  catch
    _class, _reason -> :bad_len
  end

  def to_int(:eperm, :bad_instruction) do
    bad_instruction_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(:dup_inst, :bad_instruction) do
    bad_instruction_to_int(:dup_inst)
  catch
    _class, _reason -> :dup_inst
  end

  def to_int(_int, :bad_instruction) do
    throw(:bad_enum)
  end

  def to_int(:bad_type, :bad_match) do
    bad_match_to_int(:bad_type)
  catch
    _class, _reason -> :bad_type
  end

  def to_int(:bad_len, :bad_match) do
    bad_match_to_int(:bad_len)
  catch
    _class, _reason -> :bad_len
  end

  def to_int(:bad_tag, :bad_match) do
    bad_match_to_int(:bad_tag)
  catch
    _class, _reason -> :bad_tag
  end

  def to_int(:bad_dl_addr_mask, :bad_match) do
    bad_match_to_int(:bad_dl_addr_mask)
  catch
    _class, _reason -> :bad_dl_addr_mask
  end

  def to_int(:bad_nw_addr_mask, :bad_match) do
    bad_match_to_int(:bad_nw_addr_mask)
  catch
    _class, _reason -> :bad_nw_addr_mask
  end

  def to_int(:bad_wildcards, :bad_match) do
    bad_match_to_int(:bad_wildcards)
  catch
    _class, _reason -> :bad_wildcards
  end

  def to_int(:bad_field, :bad_match) do
    bad_match_to_int(:bad_field)
  catch
    _class, _reason -> :bad_field
  end

  def to_int(:bad_value, :bad_match) do
    bad_match_to_int(:bad_value)
  catch
    _class, _reason -> :bad_value
  end

  def to_int(:bad_mask, :bad_match) do
    bad_match_to_int(:bad_mask)
  catch
    _class, _reason -> :bad_mask
  end

  def to_int(:bad_prereq, :bad_match) do
    bad_match_to_int(:bad_prereq)
  catch
    _class, _reason -> :bad_prereq
  end

  def to_int(:dup_field, :bad_match) do
    bad_match_to_int(:dup_field)
  catch
    _class, _reason -> :dup_field
  end

  def to_int(:eperm, :bad_match) do
    bad_match_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(:conntrack_datapath_support, :bad_match) do
    bad_match_to_int(:conntrack_datapath_support)
  catch
    _class, _reason -> :conntrack_datapath_support
  end

  def to_int(_int, :bad_match) do
    throw(:bad_enum)
  end

  def to_int(:unknown, :flow_mod_failed) do
    flow_mod_failed_to_int(:unknown)
  catch
    _class, _reason -> :unknown
  end

  def to_int(:table_full, :flow_mod_failed) do
    flow_mod_failed_to_int(:table_full)
  catch
    _class, _reason -> :table_full
  end

  def to_int(:bad_table_id, :flow_mod_failed) do
    flow_mod_failed_to_int(:bad_table_id)
  catch
    _class, _reason -> :bad_table_id
  end

  def to_int(:overlap, :flow_mod_failed) do
    flow_mod_failed_to_int(:overlap)
  catch
    _class, _reason -> :overlap
  end

  def to_int(:eperm, :flow_mod_failed) do
    flow_mod_failed_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(:bad_timeout, :flow_mod_failed) do
    flow_mod_failed_to_int(:bad_timeout)
  catch
    _class, _reason -> :bad_timeout
  end

  def to_int(:bad_command, :flow_mod_failed) do
    flow_mod_failed_to_int(:bad_command)
  catch
    _class, _reason -> :bad_command
  end

  def to_int(:bad_flags, :flow_mod_failed) do
    flow_mod_failed_to_int(:bad_flags)
  catch
    _class, _reason -> :bad_flags
  end

  def to_int(_int, :flow_mod_failed) do
    throw(:bad_enum)
  end

  def to_int(:group_exists, :group_mod_failed) do
    group_mod_failed_to_int(:group_exists)
  catch
    _class, _reason -> :group_exists
  end

  def to_int(:invalid_group, :group_mod_failed) do
    group_mod_failed_to_int(:invalid_group)
  catch
    _class, _reason -> :invalid_group
  end

  def to_int(:weight_unsupported, :group_mod_failed) do
    group_mod_failed_to_int(:weight_unsupported)
  catch
    _class, _reason -> :weight_unsupported
  end

  def to_int(:out_of_groups, :group_mod_failed) do
    group_mod_failed_to_int(:out_of_groups)
  catch
    _class, _reason -> :out_of_groups
  end

  def to_int(:ouf_of_buckets, :group_mod_failed) do
    group_mod_failed_to_int(:ouf_of_buckets)
  catch
    _class, _reason -> :ouf_of_buckets
  end

  def to_int(:chaining_unsupported, :group_mod_failed) do
    group_mod_failed_to_int(:chaining_unsupported)
  catch
    _class, _reason -> :chaining_unsupported
  end

  def to_int(:watch_unsupported, :group_mod_failed) do
    group_mod_failed_to_int(:watch_unsupported)
  catch
    _class, _reason -> :watch_unsupported
  end

  def to_int(:loop, :group_mod_failed) do
    group_mod_failed_to_int(:loop)
  catch
    _class, _reason -> :loop
  end

  def to_int(:unknown_group, :group_mod_failed) do
    group_mod_failed_to_int(:unknown_group)
  catch
    _class, _reason -> :unknown_group
  end

  def to_int(:chained_group, :group_mod_failed) do
    group_mod_failed_to_int(:chained_group)
  catch
    _class, _reason -> :chained_group
  end

  def to_int(:bad_type, :group_mod_failed) do
    group_mod_failed_to_int(:bad_type)
  catch
    _class, _reason -> :bad_type
  end

  def to_int(:bad_command, :group_mod_failed) do
    group_mod_failed_to_int(:bad_command)
  catch
    _class, _reason -> :bad_command
  end

  def to_int(:bad_bucket, :group_mod_failed) do
    group_mod_failed_to_int(:bad_bucket)
  catch
    _class, _reason -> :bad_bucket
  end

  def to_int(:bad_watch, :group_mod_failed) do
    group_mod_failed_to_int(:bad_watch)
  catch
    _class, _reason -> :bad_watch
  end

  def to_int(:eperm, :group_mod_failed) do
    group_mod_failed_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(:unknown_bucket, :group_mod_failed) do
    group_mod_failed_to_int(:unknown_bucket)
  catch
    _class, _reason -> :unknown_bucket
  end

  def to_int(:bucket_exists, :group_mod_failed) do
    group_mod_failed_to_int(:bucket_exists)
  catch
    _class, _reason -> :bucket_exists
  end

  def to_int(_int, :group_mod_failed) do
    throw(:bad_enum)
  end

  def to_int(:bad_port, :port_mod_failed) do
    port_mod_failed_to_int(:bad_port)
  catch
    _class, _reason -> :bad_port
  end

  def to_int(:bad_hw_addr, :port_mod_failed) do
    port_mod_failed_to_int(:bad_hw_addr)
  catch
    _class, _reason -> :bad_hw_addr
  end

  def to_int(:bad_config, :port_mod_failed) do
    port_mod_failed_to_int(:bad_config)
  catch
    _class, _reason -> :bad_config
  end

  def to_int(:bad_advertise, :port_mod_failed) do
    port_mod_failed_to_int(:bad_advertise)
  catch
    _class, _reason -> :bad_advertise
  end

  def to_int(:eperm, :port_mod_failed) do
    port_mod_failed_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(_int, :port_mod_failed) do
    throw(:bad_enum)
  end

  def to_int(:bad_table, :table_mod_failed) do
    table_mod_failed_to_int(:bad_table)
  catch
    _class, _reason -> :bad_table
  end

  def to_int(:bad_config, :table_mod_failed) do
    table_mod_failed_to_int(:bad_config)
  catch
    _class, _reason -> :bad_config
  end

  def to_int(:eperm, :table_mod_failed) do
    table_mod_failed_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(_int, :table_mod_failed) do
    throw(:bad_enum)
  end

  def to_int(:bad_port, :queue_op_failed) do
    queue_op_failed_to_int(:bad_port)
  catch
    _class, _reason -> :bad_port
  end

  def to_int(:bad_queue, :queue_op_failed) do
    queue_op_failed_to_int(:bad_queue)
  catch
    _class, _reason -> :bad_queue
  end

  def to_int(:eperm, :queue_op_failed) do
    queue_op_failed_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(_int, :queue_op_failed) do
    throw(:bad_enum)
  end

  def to_int(:bad_flags, :switch_config_failed) do
    switch_config_failed_to_int(:bad_flags)
  catch
    _class, _reason -> :bad_flags
  end

  def to_int(:bad_len, :switch_config_failed) do
    switch_config_failed_to_int(:bad_len)
  catch
    _class, _reason -> :bad_len
  end

  def to_int(:eperm, :switch_config_failed) do
    switch_config_failed_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(_int, :switch_config_failed) do
    throw(:bad_enum)
  end

  def to_int(:stale, :role_request_failed) do
    role_request_failed_to_int(:stale)
  catch
    _class, _reason -> :stale
  end

  def to_int(:unsup, :role_request_failed) do
    role_request_failed_to_int(:unsup)
  catch
    _class, _reason -> :unsup
  end

  def to_int(:bad_role, :role_request_failed) do
    role_request_failed_to_int(:bad_role)
  catch
    _class, _reason -> :bad_role
  end

  def to_int(_int, :role_request_failed) do
    throw(:bad_enum)
  end

  def to_int(:unknown, :meter_mod_failed) do
    meter_mod_failed_to_int(:unknown)
  catch
    _class, _reason -> :unknown
  end

  def to_int(:meter_exists, :meter_mod_failed) do
    meter_mod_failed_to_int(:meter_exists)
  catch
    _class, _reason -> :meter_exists
  end

  def to_int(:invalid_meter, :meter_mod_failed) do
    meter_mod_failed_to_int(:invalid_meter)
  catch
    _class, _reason -> :invalid_meter
  end

  def to_int(:unknown_meter, :meter_mod_failed) do
    meter_mod_failed_to_int(:unknown_meter)
  catch
    _class, _reason -> :unknown_meter
  end

  def to_int(:bad_command, :meter_mod_failed) do
    meter_mod_failed_to_int(:bad_command)
  catch
    _class, _reason -> :bad_command
  end

  def to_int(:bad_flags, :meter_mod_failed) do
    meter_mod_failed_to_int(:bad_flags)
  catch
    _class, _reason -> :bad_flags
  end

  def to_int(:bad_rate, :meter_mod_failed) do
    meter_mod_failed_to_int(:bad_rate)
  catch
    _class, _reason -> :bad_rate
  end

  def to_int(:bad_burst, :meter_mod_failed) do
    meter_mod_failed_to_int(:bad_burst)
  catch
    _class, _reason -> :bad_burst
  end

  def to_int(:bad_band, :meter_mod_failed) do
    meter_mod_failed_to_int(:bad_band)
  catch
    _class, _reason -> :bad_band
  end

  def to_int(:bad_band_value, :meter_mod_failed) do
    meter_mod_failed_to_int(:bad_band_value)
  catch
    _class, _reason -> :bad_band_value
  end

  def to_int(:out_of_meters, :meter_mod_failed) do
    meter_mod_failed_to_int(:out_of_meters)
  catch
    _class, _reason -> :out_of_meters
  end

  def to_int(:out_of_bands, :meter_mod_failed) do
    meter_mod_failed_to_int(:out_of_bands)
  catch
    _class, _reason -> :out_of_bands
  end

  def to_int(_int, :meter_mod_failed) do
    throw(:bad_enum)
  end

  def to_int(:bad_table, :table_features_failed) do
    table_features_failed_to_int(:bad_table)
  catch
    _class, _reason -> :bad_table
  end

  def to_int(:bad_metadata, :table_features_failed) do
    table_features_failed_to_int(:bad_metadata)
  catch
    _class, _reason -> :bad_metadata
  end

  def to_int(:bad_type, :table_features_failed) do
    table_features_failed_to_int(:bad_type)
  catch
    _class, _reason -> :bad_type
  end

  def to_int(:bad_len, :table_features_failed) do
    table_features_failed_to_int(:bad_len)
  catch
    _class, _reason -> :bad_len
  end

  def to_int(:bad_argument, :table_features_failed) do
    table_features_failed_to_int(:bad_argument)
  catch
    _class, _reason -> :bad_argument
  end

  def to_int(:eperm, :table_features_failed) do
    table_features_failed_to_int(:eperm)
  catch
    _class, _reason -> :eperm
  end

  def to_int(_int, :table_features_failed) do
    throw(:bad_enum)
  end

  def to_int(:flow_stats, :switch_capabilities) do
    switch_capabilities_to_int(:flow_stats)
  catch
    _class, _reason -> :flow_stats
  end

  def to_int(:table_stats, :switch_capabilities) do
    switch_capabilities_to_int(:table_stats)
  catch
    _class, _reason -> :table_stats
  end

  def to_int(:port_stats, :switch_capabilities) do
    switch_capabilities_to_int(:port_stats)
  catch
    _class, _reason -> :port_stats
  end

  def to_int(:group_stats, :switch_capabilities) do
    switch_capabilities_to_int(:group_stats)
  catch
    _class, _reason -> :group_stats
  end

  def to_int(:ip_reasm, :switch_capabilities) do
    switch_capabilities_to_int(:ip_reasm)
  catch
    _class, _reason -> :ip_reasm
  end

  def to_int(:queue_stats, :switch_capabilities) do
    switch_capabilities_to_int(:queue_stats)
  catch
    _class, _reason -> :queue_stats
  end

  def to_int(:arp_match_ip, :switch_capabilities) do
    switch_capabilities_to_int(:arp_match_ip)
  catch
    _class, _reason -> :arp_match_ip
  end

  def to_int(:port_blocked, :switch_capabilities) do
    switch_capabilities_to_int(:port_blocked)
  catch
    _class, _reason -> :port_blocked
  end

  def to_int(_int, :switch_capabilities) do
    throw(:bad_enum)
  end

  def to_int(:drop, :config_flags) do
    config_flags_to_int(:drop)
  catch
    _class, _reason -> :drop
  end

  def to_int(:reasm, :config_flags) do
    config_flags_to_int(:reasm)
  catch
    _class, _reason -> :reasm
  end

  def to_int(_int, :config_flags) do
    throw(:bad_enum)
  end

  def to_int(:max, :controller_max_len) do
    controller_max_len_to_int(:max)
  catch
    _class, _reason -> :max
  end

  def to_int(:no_buffer, :controller_max_len) do
    controller_max_len_to_int(:no_buffer)
  catch
    _class, _reason -> :no_buffer
  end

  def to_int(_int, :controller_max_len) do
    throw(:bad_enum)
  end

  def to_int(:nicira_ext_match, :experimenter_oxm_vendors) do
    experimenter_oxm_vendors_to_int(:nicira_ext_match)
  catch
    _class, _reason -> :nicira_ext_match
  end

  def to_int(:hp_ext_match, :experimenter_oxm_vendors) do
    experimenter_oxm_vendors_to_int(:hp_ext_match)
  catch
    _class, _reason -> :hp_ext_match
  end

  def to_int(:onf_ext_match, :experimenter_oxm_vendors) do
    experimenter_oxm_vendors_to_int(:onf_ext_match)
  catch
    _class, _reason -> :onf_ext_match
  end

  def to_int(_int, :experimenter_oxm_vendors) do
    throw(:bad_enum)
  end

  def to_int(:standard, :match_type) do
    match_type_to_int(:standard)
  catch
    _class, _reason -> :standard
  end

  def to_int(:oxm, :match_type) do
    match_type_to_int(:oxm)
  catch
    _class, _reason -> :oxm
  end

  def to_int(_int, :match_type) do
    throw(:bad_enum)
  end

  def to_int(:nxm_0, :oxm_class) do
    oxm_class_to_int(:nxm_0)
  catch
    _class, _reason -> :nxm_0
  end

  def to_int(:nxm_1, :oxm_class) do
    oxm_class_to_int(:nxm_1)
  catch
    _class, _reason -> :nxm_1
  end

  def to_int(:openflow_basic, :oxm_class) do
    oxm_class_to_int(:openflow_basic)
  catch
    _class, _reason -> :openflow_basic
  end

  def to_int(:packet_register, :oxm_class) do
    oxm_class_to_int(:packet_register)
  catch
    _class, _reason -> :packet_register
  end

  def to_int(:experimenter, :oxm_class) do
    oxm_class_to_int(:experimenter)
  catch
    _class, _reason -> :experimenter
  end

  def to_int(_int, :oxm_class) do
    throw(:bad_enum)
  end

  def to_int(:nx_in_port, :nxm_0) do
    nxm_0_to_int(:nx_in_port)
  catch
    _class, _reason -> :nx_in_port
  end

  def to_int(:nx_eth_dst, :nxm_0) do
    nxm_0_to_int(:nx_eth_dst)
  catch
    _class, _reason -> :nx_eth_dst
  end

  def to_int(:nx_eth_src, :nxm_0) do
    nxm_0_to_int(:nx_eth_src)
  catch
    _class, _reason -> :nx_eth_src
  end

  def to_int(:nx_eth_type, :nxm_0) do
    nxm_0_to_int(:nx_eth_type)
  catch
    _class, _reason -> :nx_eth_type
  end

  def to_int(:nx_vlan_tci, :nxm_0) do
    nxm_0_to_int(:nx_vlan_tci)
  catch
    _class, _reason -> :nx_vlan_tci
  end

  def to_int(:nx_ip_tos, :nxm_0) do
    nxm_0_to_int(:nx_ip_tos)
  catch
    _class, _reason -> :nx_ip_tos
  end

  def to_int(:nx_ip_proto, :nxm_0) do
    nxm_0_to_int(:nx_ip_proto)
  catch
    _class, _reason -> :nx_ip_proto
  end

  def to_int(:nx_ipv4_src, :nxm_0) do
    nxm_0_to_int(:nx_ipv4_src)
  catch
    _class, _reason -> :nx_ipv4_src
  end

  def to_int(:nx_ipv4_dst, :nxm_0) do
    nxm_0_to_int(:nx_ipv4_dst)
  catch
    _class, _reason -> :nx_ipv4_dst
  end

  def to_int(:nx_tcp_src, :nxm_0) do
    nxm_0_to_int(:nx_tcp_src)
  catch
    _class, _reason -> :nx_tcp_src
  end

  def to_int(:nx_tcp_dst, :nxm_0) do
    nxm_0_to_int(:nx_tcp_dst)
  catch
    _class, _reason -> :nx_tcp_dst
  end

  def to_int(:nx_udp_src, :nxm_0) do
    nxm_0_to_int(:nx_udp_src)
  catch
    _class, _reason -> :nx_udp_src
  end

  def to_int(:nx_udp_dst, :nxm_0) do
    nxm_0_to_int(:nx_udp_dst)
  catch
    _class, _reason -> :nx_udp_dst
  end

  def to_int(:nx_icmpv4_type, :nxm_0) do
    nxm_0_to_int(:nx_icmpv4_type)
  catch
    _class, _reason -> :nx_icmpv4_type
  end

  def to_int(:nx_icmpv4_code, :nxm_0) do
    nxm_0_to_int(:nx_icmpv4_code)
  catch
    _class, _reason -> :nx_icmpv4_code
  end

  def to_int(:nx_arp_op, :nxm_0) do
    nxm_0_to_int(:nx_arp_op)
  catch
    _class, _reason -> :nx_arp_op
  end

  def to_int(:nx_arp_spa, :nxm_0) do
    nxm_0_to_int(:nx_arp_spa)
  catch
    _class, _reason -> :nx_arp_spa
  end

  def to_int(:nx_arp_tpa, :nxm_0) do
    nxm_0_to_int(:nx_arp_tpa)
  catch
    _class, _reason -> :nx_arp_tpa
  end

  def to_int(:nx_tcp_flags, :nxm_0) do
    nxm_0_to_int(:nx_tcp_flags)
  catch
    _class, _reason -> :nx_tcp_flags
  end

  def to_int(_int, :nxm_0) do
    throw(:bad_enum)
  end

  def to_int(:reg0, :nxm_1) do
    nxm_1_to_int(:reg0)
  catch
    _class, _reason -> :reg0
  end

  def to_int(:reg1, :nxm_1) do
    nxm_1_to_int(:reg1)
  catch
    _class, _reason -> :reg1
  end

  def to_int(:reg2, :nxm_1) do
    nxm_1_to_int(:reg2)
  catch
    _class, _reason -> :reg2
  end

  def to_int(:reg3, :nxm_1) do
    nxm_1_to_int(:reg3)
  catch
    _class, _reason -> :reg3
  end

  def to_int(:reg4, :nxm_1) do
    nxm_1_to_int(:reg4)
  catch
    _class, _reason -> :reg4
  end

  def to_int(:reg5, :nxm_1) do
    nxm_1_to_int(:reg5)
  catch
    _class, _reason -> :reg5
  end

  def to_int(:reg6, :nxm_1) do
    nxm_1_to_int(:reg6)
  catch
    _class, _reason -> :reg6
  end

  def to_int(:reg7, :nxm_1) do
    nxm_1_to_int(:reg7)
  catch
    _class, _reason -> :reg7
  end

  def to_int(:reg8, :nxm_1) do
    nxm_1_to_int(:reg8)
  catch
    _class, _reason -> :reg8
  end

  def to_int(:reg9, :nxm_1) do
    nxm_1_to_int(:reg9)
  catch
    _class, _reason -> :reg9
  end

  def to_int(:reg10, :nxm_1) do
    nxm_1_to_int(:reg10)
  catch
    _class, _reason -> :reg10
  end

  def to_int(:reg11, :nxm_1) do
    nxm_1_to_int(:reg11)
  catch
    _class, _reason -> :reg11
  end

  def to_int(:reg12, :nxm_1) do
    nxm_1_to_int(:reg12)
  catch
    _class, _reason -> :reg12
  end

  def to_int(:reg13, :nxm_1) do
    nxm_1_to_int(:reg13)
  catch
    _class, _reason -> :reg13
  end

  def to_int(:reg14, :nxm_1) do
    nxm_1_to_int(:reg14)
  catch
    _class, _reason -> :reg14
  end

  def to_int(:reg15, :nxm_1) do
    nxm_1_to_int(:reg15)
  catch
    _class, _reason -> :reg15
  end

  def to_int(:tun_id, :nxm_1) do
    nxm_1_to_int(:tun_id)
  catch
    _class, _reason -> :tun_id
  end

  def to_int(:nx_arp_sha, :nxm_1) do
    nxm_1_to_int(:nx_arp_sha)
  catch
    _class, _reason -> :nx_arp_sha
  end

  def to_int(:nx_arp_tha, :nxm_1) do
    nxm_1_to_int(:nx_arp_tha)
  catch
    _class, _reason -> :nx_arp_tha
  end

  def to_int(:nx_ipv6_src, :nxm_1) do
    nxm_1_to_int(:nx_ipv6_src)
  catch
    _class, _reason -> :nx_ipv6_src
  end

  def to_int(:nx_ipv6_dst, :nxm_1) do
    nxm_1_to_int(:nx_ipv6_dst)
  catch
    _class, _reason -> :nx_ipv6_dst
  end

  def to_int(:nx_icmpv6_type, :nxm_1) do
    nxm_1_to_int(:nx_icmpv6_type)
  catch
    _class, _reason -> :nx_icmpv6_type
  end

  def to_int(:nx_icmpv6_code, :nxm_1) do
    nxm_1_to_int(:nx_icmpv6_code)
  catch
    _class, _reason -> :nx_icmpv6_code
  end

  def to_int(:nx_ipv6_nd_target, :nxm_1) do
    nxm_1_to_int(:nx_ipv6_nd_target)
  catch
    _class, _reason -> :nx_ipv6_nd_target
  end

  def to_int(:nx_ipv6_nd_sll, :nxm_1) do
    nxm_1_to_int(:nx_ipv6_nd_sll)
  catch
    _class, _reason -> :nx_ipv6_nd_sll
  end

  def to_int(:nx_ipv6_nd_tll, :nxm_1) do
    nxm_1_to_int(:nx_ipv6_nd_tll)
  catch
    _class, _reason -> :nx_ipv6_nd_tll
  end

  def to_int(:nx_ip_frag, :nxm_1) do
    nxm_1_to_int(:nx_ip_frag)
  catch
    _class, _reason -> :nx_ip_frag
  end

  def to_int(:nx_ipv6_label, :nxm_1) do
    nxm_1_to_int(:nx_ipv6_label)
  catch
    _class, _reason -> :nx_ipv6_label
  end

  def to_int(:nx_ip_ecn, :nxm_1) do
    nxm_1_to_int(:nx_ip_ecn)
  catch
    _class, _reason -> :nx_ip_ecn
  end

  def to_int(:nx_ip_ttl, :nxm_1) do
    nxm_1_to_int(:nx_ip_ttl)
  catch
    _class, _reason -> :nx_ip_ttl
  end

  def to_int(:nx_mpls_ttl, :nxm_1) do
    nxm_1_to_int(:nx_mpls_ttl)
  catch
    _class, _reason -> :nx_mpls_ttl
  end

  def to_int(:tun_src, :nxm_1) do
    nxm_1_to_int(:tun_src)
  catch
    _class, _reason -> :tun_src
  end

  def to_int(:tun_dst, :nxm_1) do
    nxm_1_to_int(:tun_dst)
  catch
    _class, _reason -> :tun_dst
  end

  def to_int(:pkt_mark, :nxm_1) do
    nxm_1_to_int(:pkt_mark)
  catch
    _class, _reason -> :pkt_mark
  end

  def to_int(:dp_hash, :nxm_1) do
    nxm_1_to_int(:dp_hash)
  catch
    _class, _reason -> :dp_hash
  end

  def to_int(:recirc_id, :nxm_1) do
    nxm_1_to_int(:recirc_id)
  catch
    _class, _reason -> :recirc_id
  end

  def to_int(:conj_id, :nxm_1) do
    nxm_1_to_int(:conj_id)
  catch
    _class, _reason -> :conj_id
  end

  def to_int(:tun_gbp_id, :nxm_1) do
    nxm_1_to_int(:tun_gbp_id)
  catch
    _class, _reason -> :tun_gbp_id
  end

  def to_int(:tun_gbp_flags, :nxm_1) do
    nxm_1_to_int(:tun_gbp_flags)
  catch
    _class, _reason -> :tun_gbp_flags
  end

  def to_int(:tun_metadata0, :nxm_1) do
    nxm_1_to_int(:tun_metadata0)
  catch
    _class, _reason -> :tun_metadata0
  end

  def to_int(:tun_metadata1, :nxm_1) do
    nxm_1_to_int(:tun_metadata1)
  catch
    _class, _reason -> :tun_metadata1
  end

  def to_int(:tun_metadata2, :nxm_1) do
    nxm_1_to_int(:tun_metadata2)
  catch
    _class, _reason -> :tun_metadata2
  end

  def to_int(:tun_metadata3, :nxm_1) do
    nxm_1_to_int(:tun_metadata3)
  catch
    _class, _reason -> :tun_metadata3
  end

  def to_int(:tun_metadata4, :nxm_1) do
    nxm_1_to_int(:tun_metadata4)
  catch
    _class, _reason -> :tun_metadata4
  end

  def to_int(:tun_metadata5, :nxm_1) do
    nxm_1_to_int(:tun_metadata5)
  catch
    _class, _reason -> :tun_metadata5
  end

  def to_int(:tun_metadata6, :nxm_1) do
    nxm_1_to_int(:tun_metadata6)
  catch
    _class, _reason -> :tun_metadata6
  end

  def to_int(:tun_metadata7, :nxm_1) do
    nxm_1_to_int(:tun_metadata7)
  catch
    _class, _reason -> :tun_metadata7
  end

  def to_int(:tun_metadata8, :nxm_1) do
    nxm_1_to_int(:tun_metadata8)
  catch
    _class, _reason -> :tun_metadata8
  end

  def to_int(:tun_metadata9, :nxm_1) do
    nxm_1_to_int(:tun_metadata9)
  catch
    _class, _reason -> :tun_metadata9
  end

  def to_int(:tun_metadata10, :nxm_1) do
    nxm_1_to_int(:tun_metadata10)
  catch
    _class, _reason -> :tun_metadata10
  end

  def to_int(:tun_metadata11, :nxm_1) do
    nxm_1_to_int(:tun_metadata11)
  catch
    _class, _reason -> :tun_metadata11
  end

  def to_int(:tun_metadata12, :nxm_1) do
    nxm_1_to_int(:tun_metadata12)
  catch
    _class, _reason -> :tun_metadata12
  end

  def to_int(:tun_metadata13, :nxm_1) do
    nxm_1_to_int(:tun_metadata13)
  catch
    _class, _reason -> :tun_metadata13
  end

  def to_int(:tun_metadata14, :nxm_1) do
    nxm_1_to_int(:tun_metadata14)
  catch
    _class, _reason -> :tun_metadata14
  end

  def to_int(:tun_metadata15, :nxm_1) do
    nxm_1_to_int(:tun_metadata15)
  catch
    _class, _reason -> :tun_metadata15
  end

  def to_int(:tun_metadata16, :nxm_1) do
    nxm_1_to_int(:tun_metadata16)
  catch
    _class, _reason -> :tun_metadata16
  end

  def to_int(:tun_metadata17, :nxm_1) do
    nxm_1_to_int(:tun_metadata17)
  catch
    _class, _reason -> :tun_metadata17
  end

  def to_int(:tun_metadata18, :nxm_1) do
    nxm_1_to_int(:tun_metadata18)
  catch
    _class, _reason -> :tun_metadata18
  end

  def to_int(:tun_metadata19, :nxm_1) do
    nxm_1_to_int(:tun_metadata19)
  catch
    _class, _reason -> :tun_metadata19
  end

  def to_int(:tun_metadata20, :nxm_1) do
    nxm_1_to_int(:tun_metadata20)
  catch
    _class, _reason -> :tun_metadata20
  end

  def to_int(:tun_metadata21, :nxm_1) do
    nxm_1_to_int(:tun_metadata21)
  catch
    _class, _reason -> :tun_metadata21
  end

  def to_int(:tun_metadata22, :nxm_1) do
    nxm_1_to_int(:tun_metadata22)
  catch
    _class, _reason -> :tun_metadata22
  end

  def to_int(:tun_metadata23, :nxm_1) do
    nxm_1_to_int(:tun_metadata23)
  catch
    _class, _reason -> :tun_metadata23
  end

  def to_int(:tun_metadata24, :nxm_1) do
    nxm_1_to_int(:tun_metadata24)
  catch
    _class, _reason -> :tun_metadata24
  end

  def to_int(:tun_metadata25, :nxm_1) do
    nxm_1_to_int(:tun_metadata25)
  catch
    _class, _reason -> :tun_metadata25
  end

  def to_int(:tun_metadata26, :nxm_1) do
    nxm_1_to_int(:tun_metadata26)
  catch
    _class, _reason -> :tun_metadata26
  end

  def to_int(:tun_metadata27, :nxm_1) do
    nxm_1_to_int(:tun_metadata27)
  catch
    _class, _reason -> :tun_metadata27
  end

  def to_int(:tun_metadata28, :nxm_1) do
    nxm_1_to_int(:tun_metadata28)
  catch
    _class, _reason -> :tun_metadata28
  end

  def to_int(:tun_metadata29, :nxm_1) do
    nxm_1_to_int(:tun_metadata29)
  catch
    _class, _reason -> :tun_metadata29
  end

  def to_int(:tun_metadata30, :nxm_1) do
    nxm_1_to_int(:tun_metadata30)
  catch
    _class, _reason -> :tun_metadata30
  end

  def to_int(:tun_metadata31, :nxm_1) do
    nxm_1_to_int(:tun_metadata31)
  catch
    _class, _reason -> :tun_metadata31
  end

  def to_int(:tun_metadata32, :nxm_1) do
    nxm_1_to_int(:tun_metadata32)
  catch
    _class, _reason -> :tun_metadata32
  end

  def to_int(:tun_metadata33, :nxm_1) do
    nxm_1_to_int(:tun_metadata33)
  catch
    _class, _reason -> :tun_metadata33
  end

  def to_int(:tun_metadata34, :nxm_1) do
    nxm_1_to_int(:tun_metadata34)
  catch
    _class, _reason -> :tun_metadata34
  end

  def to_int(:tun_metadata35, :nxm_1) do
    nxm_1_to_int(:tun_metadata35)
  catch
    _class, _reason -> :tun_metadata35
  end

  def to_int(:tun_metadata36, :nxm_1) do
    nxm_1_to_int(:tun_metadata36)
  catch
    _class, _reason -> :tun_metadata36
  end

  def to_int(:tun_metadata37, :nxm_1) do
    nxm_1_to_int(:tun_metadata37)
  catch
    _class, _reason -> :tun_metadata37
  end

  def to_int(:tun_metadata38, :nxm_1) do
    nxm_1_to_int(:tun_metadata38)
  catch
    _class, _reason -> :tun_metadata38
  end

  def to_int(:tun_metadata39, :nxm_1) do
    nxm_1_to_int(:tun_metadata39)
  catch
    _class, _reason -> :tun_metadata39
  end

  def to_int(:tun_metadata40, :nxm_1) do
    nxm_1_to_int(:tun_metadata40)
  catch
    _class, _reason -> :tun_metadata40
  end

  def to_int(:tun_metadata41, :nxm_1) do
    nxm_1_to_int(:tun_metadata41)
  catch
    _class, _reason -> :tun_metadata41
  end

  def to_int(:tun_metadata42, :nxm_1) do
    nxm_1_to_int(:tun_metadata42)
  catch
    _class, _reason -> :tun_metadata42
  end

  def to_int(:tun_metadata43, :nxm_1) do
    nxm_1_to_int(:tun_metadata43)
  catch
    _class, _reason -> :tun_metadata43
  end

  def to_int(:tun_metadata44, :nxm_1) do
    nxm_1_to_int(:tun_metadata44)
  catch
    _class, _reason -> :tun_metadata44
  end

  def to_int(:tun_metadata45, :nxm_1) do
    nxm_1_to_int(:tun_metadata45)
  catch
    _class, _reason -> :tun_metadata45
  end

  def to_int(:tun_metadata46, :nxm_1) do
    nxm_1_to_int(:tun_metadata46)
  catch
    _class, _reason -> :tun_metadata46
  end

  def to_int(:tun_metadata47, :nxm_1) do
    nxm_1_to_int(:tun_metadata47)
  catch
    _class, _reason -> :tun_metadata47
  end

  def to_int(:tun_metadata48, :nxm_1) do
    nxm_1_to_int(:tun_metadata48)
  catch
    _class, _reason -> :tun_metadata48
  end

  def to_int(:tun_metadata49, :nxm_1) do
    nxm_1_to_int(:tun_metadata49)
  catch
    _class, _reason -> :tun_metadata49
  end

  def to_int(:tun_metadata50, :nxm_1) do
    nxm_1_to_int(:tun_metadata50)
  catch
    _class, _reason -> :tun_metadata50
  end

  def to_int(:tun_metadata51, :nxm_1) do
    nxm_1_to_int(:tun_metadata51)
  catch
    _class, _reason -> :tun_metadata51
  end

  def to_int(:tun_metadata52, :nxm_1) do
    nxm_1_to_int(:tun_metadata52)
  catch
    _class, _reason -> :tun_metadata52
  end

  def to_int(:tun_metadata53, :nxm_1) do
    nxm_1_to_int(:tun_metadata53)
  catch
    _class, _reason -> :tun_metadata53
  end

  def to_int(:tun_metadata54, :nxm_1) do
    nxm_1_to_int(:tun_metadata54)
  catch
    _class, _reason -> :tun_metadata54
  end

  def to_int(:tun_metadata55, :nxm_1) do
    nxm_1_to_int(:tun_metadata55)
  catch
    _class, _reason -> :tun_metadata55
  end

  def to_int(:tun_metadata56, :nxm_1) do
    nxm_1_to_int(:tun_metadata56)
  catch
    _class, _reason -> :tun_metadata56
  end

  def to_int(:tun_metadata57, :nxm_1) do
    nxm_1_to_int(:tun_metadata57)
  catch
    _class, _reason -> :tun_metadata57
  end

  def to_int(:tun_metadata58, :nxm_1) do
    nxm_1_to_int(:tun_metadata58)
  catch
    _class, _reason -> :tun_metadata58
  end

  def to_int(:tun_metadata59, :nxm_1) do
    nxm_1_to_int(:tun_metadata59)
  catch
    _class, _reason -> :tun_metadata59
  end

  def to_int(:tun_metadata60, :nxm_1) do
    nxm_1_to_int(:tun_metadata60)
  catch
    _class, _reason -> :tun_metadata60
  end

  def to_int(:tun_metadata61, :nxm_1) do
    nxm_1_to_int(:tun_metadata61)
  catch
    _class, _reason -> :tun_metadata61
  end

  def to_int(:tun_metadata62, :nxm_1) do
    nxm_1_to_int(:tun_metadata62)
  catch
    _class, _reason -> :tun_metadata62
  end

  def to_int(:tun_metadata63, :nxm_1) do
    nxm_1_to_int(:tun_metadata63)
  catch
    _class, _reason -> :tun_metadata63
  end

  def to_int(:tun_flags, :nxm_1) do
    nxm_1_to_int(:tun_flags)
  catch
    _class, _reason -> :tun_flags
  end

  def to_int(:ct_state, :nxm_1) do
    nxm_1_to_int(:ct_state)
  catch
    _class, _reason -> :ct_state
  end

  def to_int(:ct_zone, :nxm_1) do
    nxm_1_to_int(:ct_zone)
  catch
    _class, _reason -> :ct_zone
  end

  def to_int(:ct_mark, :nxm_1) do
    nxm_1_to_int(:ct_mark)
  catch
    _class, _reason -> :ct_mark
  end

  def to_int(:ct_label, :nxm_1) do
    nxm_1_to_int(:ct_label)
  catch
    _class, _reason -> :ct_label
  end

  def to_int(:tun_ipv6_src, :nxm_1) do
    nxm_1_to_int(:tun_ipv6_src)
  catch
    _class, _reason -> :tun_ipv6_src
  end

  def to_int(:tun_ipv6_dst, :nxm_1) do
    nxm_1_to_int(:tun_ipv6_dst)
  catch
    _class, _reason -> :tun_ipv6_dst
  end

  def to_int(:xxreg0, :nxm_1) do
    nxm_1_to_int(:xxreg0)
  catch
    _class, _reason -> :xxreg0
  end

  def to_int(:xxreg1, :nxm_1) do
    nxm_1_to_int(:xxreg1)
  catch
    _class, _reason -> :xxreg1
  end

  def to_int(:xxreg2, :nxm_1) do
    nxm_1_to_int(:xxreg2)
  catch
    _class, _reason -> :xxreg2
  end

  def to_int(:xxreg3, :nxm_1) do
    nxm_1_to_int(:xxreg3)
  catch
    _class, _reason -> :xxreg3
  end

  def to_int(:xxreg4, :nxm_1) do
    nxm_1_to_int(:xxreg4)
  catch
    _class, _reason -> :xxreg4
  end

  def to_int(:xxreg5, :nxm_1) do
    nxm_1_to_int(:xxreg5)
  catch
    _class, _reason -> :xxreg5
  end

  def to_int(:xxreg6, :nxm_1) do
    nxm_1_to_int(:xxreg6)
  catch
    _class, _reason -> :xxreg6
  end

  def to_int(:xxreg7, :nxm_1) do
    nxm_1_to_int(:xxreg7)
  catch
    _class, _reason -> :xxreg7
  end

  def to_int(:ct_nw_proto, :nxm_1) do
    nxm_1_to_int(:ct_nw_proto)
  catch
    _class, _reason -> :ct_nw_proto
  end

  def to_int(:ct_nw_src, :nxm_1) do
    nxm_1_to_int(:ct_nw_src)
  catch
    _class, _reason -> :ct_nw_src
  end

  def to_int(:ct_nw_dst, :nxm_1) do
    nxm_1_to_int(:ct_nw_dst)
  catch
    _class, _reason -> :ct_nw_dst
  end

  def to_int(:ct_ipv6_src, :nxm_1) do
    nxm_1_to_int(:ct_ipv6_src)
  catch
    _class, _reason -> :ct_ipv6_src
  end

  def to_int(:ct_ipv6_dst, :nxm_1) do
    nxm_1_to_int(:ct_ipv6_dst)
  catch
    _class, _reason -> :ct_ipv6_dst
  end

  def to_int(:ct_tp_src, :nxm_1) do
    nxm_1_to_int(:ct_tp_src)
  catch
    _class, _reason -> :ct_tp_src
  end

  def to_int(:ct_tp_dst, :nxm_1) do
    nxm_1_to_int(:ct_tp_dst)
  catch
    _class, _reason -> :ct_tp_dst
  end

  def to_int(_int, :nxm_1) do
    throw(:bad_enum)
  end

  def to_int(:in_port, :openflow_basic) do
    openflow_basic_to_int(:in_port)
  catch
    _class, _reason -> :in_port
  end

  def to_int(:in_phy_port, :openflow_basic) do
    openflow_basic_to_int(:in_phy_port)
  catch
    _class, _reason -> :in_phy_port
  end

  def to_int(:metadata, :openflow_basic) do
    openflow_basic_to_int(:metadata)
  catch
    _class, _reason -> :metadata
  end

  def to_int(:eth_dst, :openflow_basic) do
    openflow_basic_to_int(:eth_dst)
  catch
    _class, _reason -> :eth_dst
  end

  def to_int(:eth_src, :openflow_basic) do
    openflow_basic_to_int(:eth_src)
  catch
    _class, _reason -> :eth_src
  end

  def to_int(:eth_type, :openflow_basic) do
    openflow_basic_to_int(:eth_type)
  catch
    _class, _reason -> :eth_type
  end

  def to_int(:vlan_vid, :openflow_basic) do
    openflow_basic_to_int(:vlan_vid)
  catch
    _class, _reason -> :vlan_vid
  end

  def to_int(:vlan_pcp, :openflow_basic) do
    openflow_basic_to_int(:vlan_pcp)
  catch
    _class, _reason -> :vlan_pcp
  end

  def to_int(:ip_dscp, :openflow_basic) do
    openflow_basic_to_int(:ip_dscp)
  catch
    _class, _reason -> :ip_dscp
  end

  def to_int(:ip_ecn, :openflow_basic) do
    openflow_basic_to_int(:ip_ecn)
  catch
    _class, _reason -> :ip_ecn
  end

  def to_int(:ip_proto, :openflow_basic) do
    openflow_basic_to_int(:ip_proto)
  catch
    _class, _reason -> :ip_proto
  end

  def to_int(:ipv4_src, :openflow_basic) do
    openflow_basic_to_int(:ipv4_src)
  catch
    _class, _reason -> :ipv4_src
  end

  def to_int(:ipv4_dst, :openflow_basic) do
    openflow_basic_to_int(:ipv4_dst)
  catch
    _class, _reason -> :ipv4_dst
  end

  def to_int(:tcp_src, :openflow_basic) do
    openflow_basic_to_int(:tcp_src)
  catch
    _class, _reason -> :tcp_src
  end

  def to_int(:tcp_dst, :openflow_basic) do
    openflow_basic_to_int(:tcp_dst)
  catch
    _class, _reason -> :tcp_dst
  end

  def to_int(:udp_src, :openflow_basic) do
    openflow_basic_to_int(:udp_src)
  catch
    _class, _reason -> :udp_src
  end

  def to_int(:udp_dst, :openflow_basic) do
    openflow_basic_to_int(:udp_dst)
  catch
    _class, _reason -> :udp_dst
  end

  def to_int(:sctp_src, :openflow_basic) do
    openflow_basic_to_int(:sctp_src)
  catch
    _class, _reason -> :sctp_src
  end

  def to_int(:sctp_dst, :openflow_basic) do
    openflow_basic_to_int(:sctp_dst)
  catch
    _class, _reason -> :sctp_dst
  end

  def to_int(:icmpv4_type, :openflow_basic) do
    openflow_basic_to_int(:icmpv4_type)
  catch
    _class, _reason -> :icmpv4_type
  end

  def to_int(:icmpv4_code, :openflow_basic) do
    openflow_basic_to_int(:icmpv4_code)
  catch
    _class, _reason -> :icmpv4_code
  end

  def to_int(:arp_op, :openflow_basic) do
    openflow_basic_to_int(:arp_op)
  catch
    _class, _reason -> :arp_op
  end

  def to_int(:arp_spa, :openflow_basic) do
    openflow_basic_to_int(:arp_spa)
  catch
    _class, _reason -> :arp_spa
  end

  def to_int(:arp_tpa, :openflow_basic) do
    openflow_basic_to_int(:arp_tpa)
  catch
    _class, _reason -> :arp_tpa
  end

  def to_int(:arp_sha, :openflow_basic) do
    openflow_basic_to_int(:arp_sha)
  catch
    _class, _reason -> :arp_sha
  end

  def to_int(:arp_tha, :openflow_basic) do
    openflow_basic_to_int(:arp_tha)
  catch
    _class, _reason -> :arp_tha
  end

  def to_int(:ipv6_src, :openflow_basic) do
    openflow_basic_to_int(:ipv6_src)
  catch
    _class, _reason -> :ipv6_src
  end

  def to_int(:ipv6_dst, :openflow_basic) do
    openflow_basic_to_int(:ipv6_dst)
  catch
    _class, _reason -> :ipv6_dst
  end

  def to_int(:ipv6_flabel, :openflow_basic) do
    openflow_basic_to_int(:ipv6_flabel)
  catch
    _class, _reason -> :ipv6_flabel
  end

  def to_int(:icmpv6_type, :openflow_basic) do
    openflow_basic_to_int(:icmpv6_type)
  catch
    _class, _reason -> :icmpv6_type
  end

  def to_int(:icmpv6_code, :openflow_basic) do
    openflow_basic_to_int(:icmpv6_code)
  catch
    _class, _reason -> :icmpv6_code
  end

  def to_int(:ipv6_nd_target, :openflow_basic) do
    openflow_basic_to_int(:ipv6_nd_target)
  catch
    _class, _reason -> :ipv6_nd_target
  end

  def to_int(:ipv6_nd_sll, :openflow_basic) do
    openflow_basic_to_int(:ipv6_nd_sll)
  catch
    _class, _reason -> :ipv6_nd_sll
  end

  def to_int(:ipv6_nd_tll, :openflow_basic) do
    openflow_basic_to_int(:ipv6_nd_tll)
  catch
    _class, _reason -> :ipv6_nd_tll
  end

  def to_int(:mpls_label, :openflow_basic) do
    openflow_basic_to_int(:mpls_label)
  catch
    _class, _reason -> :mpls_label
  end

  def to_int(:mpls_tc, :openflow_basic) do
    openflow_basic_to_int(:mpls_tc)
  catch
    _class, _reason -> :mpls_tc
  end

  def to_int(:mpls_bos, :openflow_basic) do
    openflow_basic_to_int(:mpls_bos)
  catch
    _class, _reason -> :mpls_bos
  end

  def to_int(:pbb_isid, :openflow_basic) do
    openflow_basic_to_int(:pbb_isid)
  catch
    _class, _reason -> :pbb_isid
  end

  def to_int(:tunnel_id, :openflow_basic) do
    openflow_basic_to_int(:tunnel_id)
  catch
    _class, _reason -> :tunnel_id
  end

  def to_int(:ipv6_exthdr, :openflow_basic) do
    openflow_basic_to_int(:ipv6_exthdr)
  catch
    _class, _reason -> :ipv6_exthdr
  end

  def to_int(:pbb_uca, :openflow_basic) do
    openflow_basic_to_int(:pbb_uca)
  catch
    _class, _reason -> :pbb_uca
  end

  def to_int(:packet_type, :openflow_basic) do
    openflow_basic_to_int(:packet_type)
  catch
    _class, _reason -> :packet_type
  end

  def to_int(:gre_flags, :openflow_basic) do
    openflow_basic_to_int(:gre_flags)
  catch
    _class, _reason -> :gre_flags
  end

  def to_int(:gre_ver, :openflow_basic) do
    openflow_basic_to_int(:gre_ver)
  catch
    _class, _reason -> :gre_ver
  end

  def to_int(:gre_protocol, :openflow_basic) do
    openflow_basic_to_int(:gre_protocol)
  catch
    _class, _reason -> :gre_protocol
  end

  def to_int(:gre_key, :openflow_basic) do
    openflow_basic_to_int(:gre_key)
  catch
    _class, _reason -> :gre_key
  end

  def to_int(:gre_seqnum, :openflow_basic) do
    openflow_basic_to_int(:gre_seqnum)
  catch
    _class, _reason -> :gre_seqnum
  end

  def to_int(:lisp_flags, :openflow_basic) do
    openflow_basic_to_int(:lisp_flags)
  catch
    _class, _reason -> :lisp_flags
  end

  def to_int(:lisp_nonce, :openflow_basic) do
    openflow_basic_to_int(:lisp_nonce)
  catch
    _class, _reason -> :lisp_nonce
  end

  def to_int(:lisp_id, :openflow_basic) do
    openflow_basic_to_int(:lisp_id)
  catch
    _class, _reason -> :lisp_id
  end

  def to_int(:vxlan_flags, :openflow_basic) do
    openflow_basic_to_int(:vxlan_flags)
  catch
    _class, _reason -> :vxlan_flags
  end

  def to_int(:vxlan_vni, :openflow_basic) do
    openflow_basic_to_int(:vxlan_vni)
  catch
    _class, _reason -> :vxlan_vni
  end

  def to_int(:mpls_data_first_nibble, :openflow_basic) do
    openflow_basic_to_int(:mpls_data_first_nibble)
  catch
    _class, _reason -> :mpls_data_first_nibble
  end

  def to_int(:mpls_ach_version, :openflow_basic) do
    openflow_basic_to_int(:mpls_ach_version)
  catch
    _class, _reason -> :mpls_ach_version
  end

  def to_int(:mpls_ach_channel, :openflow_basic) do
    openflow_basic_to_int(:mpls_ach_channel)
  catch
    _class, _reason -> :mpls_ach_channel
  end

  def to_int(:mpls_pw_metadata, :openflow_basic) do
    openflow_basic_to_int(:mpls_pw_metadata)
  catch
    _class, _reason -> :mpls_pw_metadata
  end

  def to_int(:mpls_cw_flags, :openflow_basic) do
    openflow_basic_to_int(:mpls_cw_flags)
  catch
    _class, _reason -> :mpls_cw_flags
  end

  def to_int(:mpls_cw_fragment, :openflow_basic) do
    openflow_basic_to_int(:mpls_cw_fragment)
  catch
    _class, _reason -> :mpls_cw_fragment
  end

  def to_int(:mpls_cw_len, :openflow_basic) do
    openflow_basic_to_int(:mpls_cw_len)
  catch
    _class, _reason -> :mpls_cw_len
  end

  def to_int(:mpls_cw_seq_num, :openflow_basic) do
    openflow_basic_to_int(:mpls_cw_seq_num)
  catch
    _class, _reason -> :mpls_cw_seq_num
  end

  def to_int(:gtpu_flags, :openflow_basic) do
    openflow_basic_to_int(:gtpu_flags)
  catch
    _class, _reason -> :gtpu_flags
  end

  def to_int(:gtpu_ver, :openflow_basic) do
    openflow_basic_to_int(:gtpu_ver)
  catch
    _class, _reason -> :gtpu_ver
  end

  def to_int(:gtpu_msg_type, :openflow_basic) do
    openflow_basic_to_int(:gtpu_msg_type)
  catch
    _class, _reason -> :gtpu_msg_type
  end

  def to_int(:gtpu_teid, :openflow_basic) do
    openflow_basic_to_int(:gtpu_teid)
  catch
    _class, _reason -> :gtpu_teid
  end

  def to_int(:gtpu_extn_hdr, :openflow_basic) do
    openflow_basic_to_int(:gtpu_extn_hdr)
  catch
    _class, _reason -> :gtpu_extn_hdr
  end

  def to_int(:gtpu_extn_udp_port, :openflow_basic) do
    openflow_basic_to_int(:gtpu_extn_udp_port)
  catch
    _class, _reason -> :gtpu_extn_udp_port
  end

  def to_int(:gtpu_extn_sci, :openflow_basic) do
    openflow_basic_to_int(:gtpu_extn_sci)
  catch
    _class, _reason -> :gtpu_extn_sci
  end

  def to_int(_int, :openflow_basic) do
    throw(:bad_enum)
  end

  def to_int(:present, :vlan_id) do
    vlan_id_to_int(:present)
  catch
    _class, _reason -> :present
  end

  def to_int(:none, :vlan_id) do
    vlan_id_to_int(:none)
  catch
    _class, _reason -> :none
  end

  def to_int(_int, :vlan_id) do
    throw(:bad_enum)
  end

  def to_int(:nonext, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:nonext)
  catch
    _class, _reason -> :nonext
  end

  def to_int(:esp, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:esp)
  catch
    _class, _reason -> :esp
  end

  def to_int(:auth, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:auth)
  catch
    _class, _reason -> :auth
  end

  def to_int(:dest, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:dest)
  catch
    _class, _reason -> :dest
  end

  def to_int(:frag, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:frag)
  catch
    _class, _reason -> :frag
  end

  def to_int(:router, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:router)
  catch
    _class, _reason -> :router
  end

  def to_int(:hop, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:hop)
  catch
    _class, _reason -> :hop
  end

  def to_int(:unrep, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:unrep)
  catch
    _class, _reason -> :unrep
  end

  def to_int(:unseq, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_int(:unseq)
  catch
    _class, _reason -> :unseq
  end

  def to_int(_int, :ipv6exthdr_flags) do
    throw(:bad_enum)
  end

  def to_int(:fin, :tcp_flags) do
    tcp_flags_to_int(:fin)
  catch
    _class, _reason -> :fin
  end

  def to_int(:syn, :tcp_flags) do
    tcp_flags_to_int(:syn)
  catch
    _class, _reason -> :syn
  end

  def to_int(:rst, :tcp_flags) do
    tcp_flags_to_int(:rst)
  catch
    _class, _reason -> :rst
  end

  def to_int(:psh, :tcp_flags) do
    tcp_flags_to_int(:psh)
  catch
    _class, _reason -> :psh
  end

  def to_int(:ack, :tcp_flags) do
    tcp_flags_to_int(:ack)
  catch
    _class, _reason -> :ack
  end

  def to_int(:urg, :tcp_flags) do
    tcp_flags_to_int(:urg)
  catch
    _class, _reason -> :urg
  end

  def to_int(:ece, :tcp_flags) do
    tcp_flags_to_int(:ece)
  catch
    _class, _reason -> :ece
  end

  def to_int(:cwr, :tcp_flags) do
    tcp_flags_to_int(:cwr)
  catch
    _class, _reason -> :cwr
  end

  def to_int(:ns, :tcp_flags) do
    tcp_flags_to_int(:ns)
  catch
    _class, _reason -> :ns
  end

  def to_int(_int, :tcp_flags) do
    throw(:bad_enum)
  end

  def to_int(:new, :ct_state_flags) do
    ct_state_flags_to_int(:new)
  catch
    _class, _reason -> :new
  end

  def to_int(:est, :ct_state_flags) do
    ct_state_flags_to_int(:est)
  catch
    _class, _reason -> :est
  end

  def to_int(:rel, :ct_state_flags) do
    ct_state_flags_to_int(:rel)
  catch
    _class, _reason -> :rel
  end

  def to_int(:rep, :ct_state_flags) do
    ct_state_flags_to_int(:rep)
  catch
    _class, _reason -> :rep
  end

  def to_int(:inv, :ct_state_flags) do
    ct_state_flags_to_int(:inv)
  catch
    _class, _reason -> :inv
  end

  def to_int(:trk, :ct_state_flags) do
    ct_state_flags_to_int(:trk)
  catch
    _class, _reason -> :trk
  end

  def to_int(:snat, :ct_state_flags) do
    ct_state_flags_to_int(:snat)
  catch
    _class, _reason -> :snat
  end

  def to_int(:dnat, :ct_state_flags) do
    ct_state_flags_to_int(:dnat)
  catch
    _class, _reason -> :dnat
  end

  def to_int(_int, :ct_state_flags) do
    throw(:bad_enum)
  end

  def to_int(:xreg0, :packet_register) do
    packet_register_to_int(:xreg0)
  catch
    _class, _reason -> :xreg0
  end

  def to_int(:xreg1, :packet_register) do
    packet_register_to_int(:xreg1)
  catch
    _class, _reason -> :xreg1
  end

  def to_int(:xreg2, :packet_register) do
    packet_register_to_int(:xreg2)
  catch
    _class, _reason -> :xreg2
  end

  def to_int(:xreg3, :packet_register) do
    packet_register_to_int(:xreg3)
  catch
    _class, _reason -> :xreg3
  end

  def to_int(:xreg4, :packet_register) do
    packet_register_to_int(:xreg4)
  catch
    _class, _reason -> :xreg4
  end

  def to_int(:xreg5, :packet_register) do
    packet_register_to_int(:xreg5)
  catch
    _class, _reason -> :xreg5
  end

  def to_int(:xreg6, :packet_register) do
    packet_register_to_int(:xreg6)
  catch
    _class, _reason -> :xreg6
  end

  def to_int(:xreg7, :packet_register) do
    packet_register_to_int(:xreg7)
  catch
    _class, _reason -> :xreg7
  end

  def to_int(_int, :packet_register) do
    throw(:bad_enum)
  end

  def to_int(:nsh_flags, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_flags)
  catch
    _class, _reason -> :nsh_flags
  end

  def to_int(:nsh_mdtype, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_mdtype)
  catch
    _class, _reason -> :nsh_mdtype
  end

  def to_int(:nsh_np, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_np)
  catch
    _class, _reason -> :nsh_np
  end

  def to_int(:nsh_spi, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_spi)
  catch
    _class, _reason -> :nsh_spi
  end

  def to_int(:nsh_si, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_si)
  catch
    _class, _reason -> :nsh_si
  end

  def to_int(:nsh_c1, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_c1)
  catch
    _class, _reason -> :nsh_c1
  end

  def to_int(:nsh_c2, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_c2)
  catch
    _class, _reason -> :nsh_c2
  end

  def to_int(:nsh_c3, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_c3)
  catch
    _class, _reason -> :nsh_c3
  end

  def to_int(:nsh_c4, :nicira_ext_match) do
    nicira_ext_match_to_int(:nsh_c4)
  catch
    _class, _reason -> :nsh_c4
  end

  def to_int(_int, :nicira_ext_match) do
    throw(:bad_enum)
  end

  def to_int(:hp_udp_src_port_range, :hp_ext_match) do
    hp_ext_match_to_int(:hp_udp_src_port_range)
  catch
    _class, _reason -> :hp_udp_src_port_range
  end

  def to_int(:hp_udp_dst_port_range, :hp_ext_match) do
    hp_ext_match_to_int(:hp_udp_dst_port_range)
  catch
    _class, _reason -> :hp_udp_dst_port_range
  end

  def to_int(:hp_tcp_src_port_range, :hp_ext_match) do
    hp_ext_match_to_int(:hp_tcp_src_port_range)
  catch
    _class, _reason -> :hp_tcp_src_port_range
  end

  def to_int(:hp_tcp_dst_port_range, :hp_ext_match) do
    hp_ext_match_to_int(:hp_tcp_dst_port_range)
  catch
    _class, _reason -> :hp_tcp_dst_port_range
  end

  def to_int(:hp_tcp_flags, :hp_ext_match) do
    hp_ext_match_to_int(:hp_tcp_flags)
  catch
    _class, _reason -> :hp_tcp_flags
  end

  def to_int(:hp_custom_1, :hp_ext_match) do
    hp_ext_match_to_int(:hp_custom_1)
  catch
    _class, _reason -> :hp_custom_1
  end

  def to_int(:hp_custom_2, :hp_ext_match) do
    hp_ext_match_to_int(:hp_custom_2)
  catch
    _class, _reason -> :hp_custom_2
  end

  def to_int(:hp_custom_3, :hp_ext_match) do
    hp_ext_match_to_int(:hp_custom_3)
  catch
    _class, _reason -> :hp_custom_3
  end

  def to_int(:hp_custom_4, :hp_ext_match) do
    hp_ext_match_to_int(:hp_custom_4)
  catch
    _class, _reason -> :hp_custom_4
  end

  def to_int(_int, :hp_ext_match) do
    throw(:bad_enum)
  end

  def to_int(:l2_start, :hp_custom_match_type) do
    hp_custom_match_type_to_int(:l2_start)
  catch
    _class, _reason -> :l2_start
  end

  def to_int(:l3_start, :hp_custom_match_type) do
    hp_custom_match_type_to_int(:l3_start)
  catch
    _class, _reason -> :l3_start
  end

  def to_int(:l4_start, :hp_custom_match_type) do
    hp_custom_match_type_to_int(:l4_start)
  catch
    _class, _reason -> :l4_start
  end

  def to_int(_int, :hp_custom_match_type) do
    throw(:bad_enum)
  end

  def to_int(:onf_tcp_flags, :onf_ext_match) do
    onf_ext_match_to_int(:onf_tcp_flags)
  catch
    _class, _reason -> :onf_tcp_flags
  end

  def to_int(:onf_actset_output, :onf_ext_match) do
    onf_ext_match_to_int(:onf_actset_output)
  catch
    _class, _reason -> :onf_actset_output
  end

  def to_int(:onf_pbb_uca, :onf_ext_match) do
    onf_ext_match_to_int(:onf_pbb_uca)
  catch
    _class, _reason -> :onf_pbb_uca
  end

  def to_int(_int, :onf_ext_match) do
    throw(:bad_enum)
  end

  def to_int(:no_buffer, :buffer_id) do
    buffer_id_to_int(:no_buffer)
  catch
    _class, _reason -> :no_buffer
  end

  def to_int(_int, :buffer_id) do
    throw(:bad_enum)
  end

  def to_int(:port_down, :port_config) do
    port_config_to_int(:port_down)
  catch
    _class, _reason -> :port_down
  end

  def to_int(:no_receive, :port_config) do
    port_config_to_int(:no_receive)
  catch
    _class, _reason -> :no_receive
  end

  def to_int(:no_forward, :port_config) do
    port_config_to_int(:no_forward)
  catch
    _class, _reason -> :no_forward
  end

  def to_int(:no_packet_in, :port_config) do
    port_config_to_int(:no_packet_in)
  catch
    _class, _reason -> :no_packet_in
  end

  def to_int(_int, :port_config) do
    throw(:bad_enum)
  end

  def to_int(:link_down, :port_state) do
    port_state_to_int(:link_down)
  catch
    _class, _reason -> :link_down
  end

  def to_int(:blocked, :port_state) do
    port_state_to_int(:blocked)
  catch
    _class, _reason -> :blocked
  end

  def to_int(:live, :port_state) do
    port_state_to_int(:live)
  catch
    _class, _reason -> :live
  end

  def to_int(_int, :port_state) do
    throw(:bad_enum)
  end

  def to_int(:"10mb_hd", :port_features) do
    port_features_to_int(:"10mb_hd")
  catch
    _class, _reason -> :"10mb_hd"
  end

  def to_int(:"10mb_fd", :port_features) do
    port_features_to_int(:"10mb_fd")
  catch
    _class, _reason -> :"10mb_fd"
  end

  def to_int(:"100mb_hd", :port_features) do
    port_features_to_int(:"100mb_hd")
  catch
    _class, _reason -> :"100mb_hd"
  end

  def to_int(:"100mb_fd", :port_features) do
    port_features_to_int(:"100mb_fd")
  catch
    _class, _reason -> :"100mb_fd"
  end

  def to_int(:"1gb_hd", :port_features) do
    port_features_to_int(:"1gb_hd")
  catch
    _class, _reason -> :"1gb_hd"
  end

  def to_int(:"1gb_fd", :port_features) do
    port_features_to_int(:"1gb_fd")
  catch
    _class, _reason -> :"1gb_fd"
  end

  def to_int(:"10gb_fd", :port_features) do
    port_features_to_int(:"10gb_fd")
  catch
    _class, _reason -> :"10gb_fd"
  end

  def to_int(:"40gb_fd", :port_features) do
    port_features_to_int(:"40gb_fd")
  catch
    _class, _reason -> :"40gb_fd"
  end

  def to_int(:"100gb_fd", :port_features) do
    port_features_to_int(:"100gb_fd")
  catch
    _class, _reason -> :"100gb_fd"
  end

  def to_int(:"1tb_fd", :port_features) do
    port_features_to_int(:"1tb_fd")
  catch
    _class, _reason -> :"1tb_fd"
  end

  def to_int(:other, :port_features) do
    port_features_to_int(:other)
  catch
    _class, _reason -> :other
  end

  def to_int(:copper, :port_features) do
    port_features_to_int(:copper)
  catch
    _class, _reason -> :copper
  end

  def to_int(:fiber, :port_features) do
    port_features_to_int(:fiber)
  catch
    _class, _reason -> :fiber
  end

  def to_int(:autoneg, :port_features) do
    port_features_to_int(:autoneg)
  catch
    _class, _reason -> :autoneg
  end

  def to_int(:pause, :port_features) do
    port_features_to_int(:pause)
  catch
    _class, _reason -> :pause
  end

  def to_int(:pause_asym, :port_features) do
    port_features_to_int(:pause_asym)
  catch
    _class, _reason -> :pause_asym
  end

  def to_int(_int, :port_features) do
    throw(:bad_enum)
  end

  def to_int(:max, :openflow10_port_no) do
    openflow10_port_no_to_int(:max)
  catch
    _class, _reason -> :max
  end

  def to_int(:in_port, :openflow10_port_no) do
    openflow10_port_no_to_int(:in_port)
  catch
    _class, _reason -> :in_port
  end

  def to_int(:table, :openflow10_port_no) do
    openflow10_port_no_to_int(:table)
  catch
    _class, _reason -> :table
  end

  def to_int(:normal, :openflow10_port_no) do
    openflow10_port_no_to_int(:normal)
  catch
    _class, _reason -> :normal
  end

  def to_int(:flood, :openflow10_port_no) do
    openflow10_port_no_to_int(:flood)
  catch
    _class, _reason -> :flood
  end

  def to_int(:all, :openflow10_port_no) do
    openflow10_port_no_to_int(:all)
  catch
    _class, _reason -> :all
  end

  def to_int(:controller, :openflow10_port_no) do
    openflow10_port_no_to_int(:controller)
  catch
    _class, _reason -> :controller
  end

  def to_int(:local, :openflow10_port_no) do
    openflow10_port_no_to_int(:local)
  catch
    _class, _reason -> :local
  end

  def to_int(:none, :openflow10_port_no) do
    openflow10_port_no_to_int(:none)
  catch
    _class, _reason -> :none
  end

  def to_int(_int, :openflow10_port_no) do
    throw(:bad_enum)
  end

  def to_int(:max, :openflow13_port_no) do
    openflow13_port_no_to_int(:max)
  catch
    _class, _reason -> :max
  end

  def to_int(:in_port, :openflow13_port_no) do
    openflow13_port_no_to_int(:in_port)
  catch
    _class, _reason -> :in_port
  end

  def to_int(:table, :openflow13_port_no) do
    openflow13_port_no_to_int(:table)
  catch
    _class, _reason -> :table
  end

  def to_int(:normal, :openflow13_port_no) do
    openflow13_port_no_to_int(:normal)
  catch
    _class, _reason -> :normal
  end

  def to_int(:flood, :openflow13_port_no) do
    openflow13_port_no_to_int(:flood)
  catch
    _class, _reason -> :flood
  end

  def to_int(:all, :openflow13_port_no) do
    openflow13_port_no_to_int(:all)
  catch
    _class, _reason -> :all
  end

  def to_int(:controller, :openflow13_port_no) do
    openflow13_port_no_to_int(:controller)
  catch
    _class, _reason -> :controller
  end

  def to_int(:local, :openflow13_port_no) do
    openflow13_port_no_to_int(:local)
  catch
    _class, _reason -> :local
  end

  def to_int(:any, :openflow13_port_no) do
    openflow13_port_no_to_int(:any)
  catch
    _class, _reason -> :any
  end

  def to_int(_int, :openflow13_port_no) do
    throw(:bad_enum)
  end

  def to_int(:no_match, :packet_in_reason) do
    packet_in_reason_to_int(:no_match)
  catch
    _class, _reason -> :no_match
  end

  def to_int(:action, :packet_in_reason) do
    packet_in_reason_to_int(:action)
  catch
    _class, _reason -> :action
  end

  def to_int(:invalid_ttl, :packet_in_reason) do
    packet_in_reason_to_int(:invalid_ttl)
  catch
    _class, _reason -> :invalid_ttl
  end

  def to_int(:action_set, :packet_in_reason) do
    packet_in_reason_to_int(:action_set)
  catch
    _class, _reason -> :action_set
  end

  def to_int(:group, :packet_in_reason) do
    packet_in_reason_to_int(:group)
  catch
    _class, _reason -> :group
  end

  def to_int(:packet_out, :packet_in_reason) do
    packet_in_reason_to_int(:packet_out)
  catch
    _class, _reason -> :packet_out
  end

  def to_int(_int, :packet_in_reason) do
    throw(:bad_enum)
  end

  def to_int(:no_match, :packet_in_reason_mask) do
    packet_in_reason_mask_to_int(:no_match)
  catch
    _class, _reason -> :no_match
  end

  def to_int(:action, :packet_in_reason_mask) do
    packet_in_reason_mask_to_int(:action)
  catch
    _class, _reason -> :action
  end

  def to_int(:invalid_ttl, :packet_in_reason_mask) do
    packet_in_reason_mask_to_int(:invalid_ttl)
  catch
    _class, _reason -> :invalid_ttl
  end

  def to_int(:action_set, :packet_in_reason_mask) do
    packet_in_reason_mask_to_int(:action_set)
  catch
    _class, _reason -> :action_set
  end

  def to_int(:group, :packet_in_reason_mask) do
    packet_in_reason_mask_to_int(:group)
  catch
    _class, _reason -> :group
  end

  def to_int(:packet_out, :packet_in_reason_mask) do
    packet_in_reason_mask_to_int(:packet_out)
  catch
    _class, _reason -> :packet_out
  end

  def to_int(_int, :packet_in_reason_mask) do
    throw(:bad_enum)
  end

  def to_int(:add, :flow_mod_command) do
    flow_mod_command_to_int(:add)
  catch
    _class, _reason -> :add
  end

  def to_int(:modify, :flow_mod_command) do
    flow_mod_command_to_int(:modify)
  catch
    _class, _reason -> :modify
  end

  def to_int(:modify_strict, :flow_mod_command) do
    flow_mod_command_to_int(:modify_strict)
  catch
    _class, _reason -> :modify_strict
  end

  def to_int(:delete, :flow_mod_command) do
    flow_mod_command_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(:delete_strict, :flow_mod_command) do
    flow_mod_command_to_int(:delete_strict)
  catch
    _class, _reason -> :delete_strict
  end

  def to_int(_int, :flow_mod_command) do
    throw(:bad_enum)
  end

  def to_int(:send_flow_rem, :flow_mod_flags) do
    flow_mod_flags_to_int(:send_flow_rem)
  catch
    _class, _reason -> :send_flow_rem
  end

  def to_int(:check_overlap, :flow_mod_flags) do
    flow_mod_flags_to_int(:check_overlap)
  catch
    _class, _reason -> :check_overlap
  end

  def to_int(:reset_counts, :flow_mod_flags) do
    flow_mod_flags_to_int(:reset_counts)
  catch
    _class, _reason -> :reset_counts
  end

  def to_int(:no_packet_counts, :flow_mod_flags) do
    flow_mod_flags_to_int(:no_packet_counts)
  catch
    _class, _reason -> :no_packet_counts
  end

  def to_int(:no_byte_counts, :flow_mod_flags) do
    flow_mod_flags_to_int(:no_byte_counts)
  catch
    _class, _reason -> :no_byte_counts
  end

  def to_int(_int, :flow_mod_flags) do
    throw(:bad_enum)
  end

  def to_int(:idle_timeout, :flow_removed_reason) do
    flow_removed_reason_to_int(:idle_timeout)
  catch
    _class, _reason -> :idle_timeout
  end

  def to_int(:hard_timeout, :flow_removed_reason) do
    flow_removed_reason_to_int(:hard_timeout)
  catch
    _class, _reason -> :hard_timeout
  end

  def to_int(:delete, :flow_removed_reason) do
    flow_removed_reason_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(:group_delete, :flow_removed_reason) do
    flow_removed_reason_to_int(:group_delete)
  catch
    _class, _reason -> :group_delete
  end

  def to_int(:meter_delete, :flow_removed_reason) do
    flow_removed_reason_to_int(:meter_delete)
  catch
    _class, _reason -> :meter_delete
  end

  def to_int(:eviction, :flow_removed_reason) do
    flow_removed_reason_to_int(:eviction)
  catch
    _class, _reason -> :eviction
  end

  def to_int(_int, :flow_removed_reason) do
    throw(:bad_enum)
  end

  def to_int(:idle_timeout, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_int(:idle_timeout)
  catch
    _class, _reason -> :idle_timeout
  end

  def to_int(:hard_timeout, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_int(:hard_timeout)
  catch
    _class, _reason -> :hard_timeout
  end

  def to_int(:delete, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(:group_delete, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_int(:group_delete)
  catch
    _class, _reason -> :group_delete
  end

  def to_int(:meter_delete, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_int(:meter_delete)
  catch
    _class, _reason -> :meter_delete
  end

  def to_int(:eviction, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_int(:eviction)
  catch
    _class, _reason -> :eviction
  end

  def to_int(_int, :flow_removed_reason_mask) do
    throw(:bad_enum)
  end

  def to_int(:add, :port_reason) do
    port_reason_to_int(:add)
  catch
    _class, _reason -> :add
  end

  def to_int(:delete, :port_reason) do
    port_reason_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(:modify, :port_reason) do
    port_reason_to_int(:modify)
  catch
    _class, _reason -> :modify
  end

  def to_int(_int, :port_reason) do
    throw(:bad_enum)
  end

  def to_int(:add, :port_reason_mask) do
    port_reason_mask_to_int(:add)
  catch
    _class, _reason -> :add
  end

  def to_int(:delete, :port_reason_mask) do
    port_reason_mask_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(:modify, :port_reason_mask) do
    port_reason_mask_to_int(:modify)
  catch
    _class, _reason -> :modify
  end

  def to_int(_int, :port_reason_mask) do
    throw(:bad_enum)
  end

  def to_int(:add, :group_mod_command) do
    group_mod_command_to_int(:add)
  catch
    _class, _reason -> :add
  end

  def to_int(:modify, :group_mod_command) do
    group_mod_command_to_int(:modify)
  catch
    _class, _reason -> :modify
  end

  def to_int(:delete, :group_mod_command) do
    group_mod_command_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(_int, :group_mod_command) do
    throw(:bad_enum)
  end

  def to_int(:all, :group_type) do
    group_type_to_int(:all)
  catch
    _class, _reason -> :all
  end

  def to_int(:select, :group_type) do
    group_type_to_int(:select)
  catch
    _class, _reason -> :select
  end

  def to_int(:indirect, :group_type) do
    group_type_to_int(:indirect)
  catch
    _class, _reason -> :indirect
  end

  def to_int(:fast_failover, :group_type) do
    group_type_to_int(:fast_failover)
  catch
    _class, _reason -> :fast_failover
  end

  def to_int(_int, :group_type) do
    throw(:bad_enum)
  end

  def to_int(:all, :group_type_flags) do
    group_type_flags_to_int(:all)
  catch
    _class, _reason -> :all
  end

  def to_int(:select, :group_type_flags) do
    group_type_flags_to_int(:select)
  catch
    _class, _reason -> :select
  end

  def to_int(:indirect, :group_type_flags) do
    group_type_flags_to_int(:indirect)
  catch
    _class, _reason -> :indirect
  end

  def to_int(:fast_failover, :group_type_flags) do
    group_type_flags_to_int(:fast_failover)
  catch
    _class, _reason -> :fast_failover
  end

  def to_int(_int, :group_type_flags) do
    throw(:bad_enum)
  end

  def to_int(:max, :group_id) do
    group_id_to_int(:max)
  catch
    _class, _reason -> :max
  end

  def to_int(:all, :group_id) do
    group_id_to_int(:all)
  catch
    _class, _reason -> :all
  end

  def to_int(:any, :group_id) do
    group_id_to_int(:any)
  catch
    _class, _reason -> :any
  end

  def to_int(_int, :group_id) do
    throw(:bad_enum)
  end

  def to_int(:select_weight, :group_capabilities) do
    group_capabilities_to_int(:select_weight)
  catch
    _class, _reason -> :select_weight
  end

  def to_int(:select_liveness, :group_capabilities) do
    group_capabilities_to_int(:select_liveness)
  catch
    _class, _reason -> :select_liveness
  end

  def to_int(:chaining, :group_capabilities) do
    group_capabilities_to_int(:chaining)
  catch
    _class, _reason -> :chaining
  end

  def to_int(:chaining_checks, :group_capabilities) do
    group_capabilities_to_int(:chaining_checks)
  catch
    _class, _reason -> :chaining_checks
  end

  def to_int(_int, :group_capabilities) do
    throw(:bad_enum)
  end

  def to_int(:max, :table_id) do
    table_id_to_int(:max)
  catch
    _class, _reason -> :max
  end

  def to_int(:all, :table_id) do
    table_id_to_int(:all)
  catch
    _class, _reason -> :all
  end

  def to_int(_int, :table_id) do
    throw(:bad_enum)
  end

  def to_int(:all, :queue_id) do
    queue_id_to_int(:all)
  catch
    _class, _reason -> :all
  end

  def to_int(_int, :queue_id) do
    throw(:bad_enum)
  end

  def to_int(:add, :meter_mod_command) do
    meter_mod_command_to_int(:add)
  catch
    _class, _reason -> :add
  end

  def to_int(:modify, :meter_mod_command) do
    meter_mod_command_to_int(:modify)
  catch
    _class, _reason -> :modify
  end

  def to_int(:delete, :meter_mod_command) do
    meter_mod_command_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(_int, :meter_mod_command) do
    throw(:bad_enum)
  end

  def to_int(:max, :meter_id) do
    meter_id_to_int(:max)
  catch
    _class, _reason -> :max
  end

  def to_int(:slowpath, :meter_id) do
    meter_id_to_int(:slowpath)
  catch
    _class, _reason -> :slowpath
  end

  def to_int(:controller, :meter_id) do
    meter_id_to_int(:controller)
  catch
    _class, _reason -> :controller
  end

  def to_int(:all, :meter_id) do
    meter_id_to_int(:all)
  catch
    _class, _reason -> :all
  end

  def to_int(_int, :meter_id) do
    throw(:bad_enum)
  end

  def to_int(:kbps, :meter_flags) do
    meter_flags_to_int(:kbps)
  catch
    _class, _reason -> :kbps
  end

  def to_int(:pktps, :meter_flags) do
    meter_flags_to_int(:pktps)
  catch
    _class, _reason -> :pktps
  end

  def to_int(:burst, :meter_flags) do
    meter_flags_to_int(:burst)
  catch
    _class, _reason -> :burst
  end

  def to_int(:stats, :meter_flags) do
    meter_flags_to_int(:stats)
  catch
    _class, _reason -> :stats
  end

  def to_int(_int, :meter_flags) do
    throw(:bad_enum)
  end

  def to_int(Openflow.MeterBand.Drop, :meter_band_type) do
    meter_band_type_to_int(Openflow.MeterBand.Drop)
  catch
    _class, _reason -> Openflow.MeterBand.Drop
  end

  def to_int(Openflow.MeterBand.Remark, :meter_band_type) do
    meter_band_type_to_int(Openflow.MeterBand.Remark)
  catch
    _class, _reason -> Openflow.MeterBand.Remark
  end

  def to_int(Openflow.MeterBand.Experimenter, :meter_band_type) do
    meter_band_type_to_int(Openflow.MeterBand.Experimenter)
  catch
    _class, _reason -> Openflow.MeterBand.Experimenter
  end

  def to_int(_int, :meter_band_type) do
    throw(:bad_enum)
  end

  def to_int(:table_miss_controller, :table_config) do
    table_config_to_int(:table_miss_controller)
  catch
    _class, _reason -> :table_miss_controller
  end

  def to_int(:table_miss_continue, :table_config) do
    table_config_to_int(:table_miss_continue)
  catch
    _class, _reason -> :table_miss_continue
  end

  def to_int(:table_miss_drop, :table_config) do
    table_config_to_int(:table_miss_drop)
  catch
    _class, _reason -> :table_miss_drop
  end

  def to_int(:table_miss_mask, :table_config) do
    table_config_to_int(:table_miss_mask)
  catch
    _class, _reason -> :table_miss_mask
  end

  def to_int(:eviction, :table_config) do
    table_config_to_int(:eviction)
  catch
    _class, _reason -> :eviction
  end

  def to_int(:vacancy_events, :table_config) do
    table_config_to_int(:vacancy_events)
  catch
    _class, _reason -> :vacancy_events
  end

  def to_int(_int, :table_config) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Action.Output, :action_type) do
    action_type_to_int(Openflow.Action.Output)
  catch
    _class, _reason -> Openflow.Action.Output
  end

  def to_int(Openflow.Action.CopyTtlOut, :action_type) do
    action_type_to_int(Openflow.Action.CopyTtlOut)
  catch
    _class, _reason -> Openflow.Action.CopyTtlOut
  end

  def to_int(Openflow.Action.CopyTtlIn, :action_type) do
    action_type_to_int(Openflow.Action.CopyTtlIn)
  catch
    _class, _reason -> Openflow.Action.CopyTtlIn
  end

  def to_int(Openflow.Action.SetMplsTtl, :action_type) do
    action_type_to_int(Openflow.Action.SetMplsTtl)
  catch
    _class, _reason -> Openflow.Action.SetMplsTtl
  end

  def to_int(Openflow.Action.DecMplsTtl, :action_type) do
    action_type_to_int(Openflow.Action.DecMplsTtl)
  catch
    _class, _reason -> Openflow.Action.DecMplsTtl
  end

  def to_int(Openflow.Action.PushVlan, :action_type) do
    action_type_to_int(Openflow.Action.PushVlan)
  catch
    _class, _reason -> Openflow.Action.PushVlan
  end

  def to_int(Openflow.Action.PopVlan, :action_type) do
    action_type_to_int(Openflow.Action.PopVlan)
  catch
    _class, _reason -> Openflow.Action.PopVlan
  end

  def to_int(Openflow.Action.PushMpls, :action_type) do
    action_type_to_int(Openflow.Action.PushMpls)
  catch
    _class, _reason -> Openflow.Action.PushMpls
  end

  def to_int(Openflow.Action.PopMpls, :action_type) do
    action_type_to_int(Openflow.Action.PopMpls)
  catch
    _class, _reason -> Openflow.Action.PopMpls
  end

  def to_int(Openflow.Action.SetQueue, :action_type) do
    action_type_to_int(Openflow.Action.SetQueue)
  catch
    _class, _reason -> Openflow.Action.SetQueue
  end

  def to_int(Openflow.Action.Group, :action_type) do
    action_type_to_int(Openflow.Action.Group)
  catch
    _class, _reason -> Openflow.Action.Group
  end

  def to_int(Openflow.Action.SetNwTtl, :action_type) do
    action_type_to_int(Openflow.Action.SetNwTtl)
  catch
    _class, _reason -> Openflow.Action.SetNwTtl
  end

  def to_int(Openflow.Action.DecNwTtl, :action_type) do
    action_type_to_int(Openflow.Action.DecNwTtl)
  catch
    _class, _reason -> Openflow.Action.DecNwTtl
  end

  def to_int(Openflow.Action.SetField, :action_type) do
    action_type_to_int(Openflow.Action.SetField)
  catch
    _class, _reason -> Openflow.Action.SetField
  end

  def to_int(Openflow.Action.PushPbb, :action_type) do
    action_type_to_int(Openflow.Action.PushPbb)
  catch
    _class, _reason -> Openflow.Action.PushPbb
  end

  def to_int(Openflow.Action.PopPbb, :action_type) do
    action_type_to_int(Openflow.Action.PopPbb)
  catch
    _class, _reason -> Openflow.Action.PopPbb
  end

  def to_int(Openflow.Action.Encap, :action_type) do
    action_type_to_int(Openflow.Action.Encap)
  catch
    _class, _reason -> Openflow.Action.Encap
  end

  def to_int(Openflow.Action.Decap, :action_type) do
    action_type_to_int(Openflow.Action.Decap)
  catch
    _class, _reason -> Openflow.Action.Decap
  end

  def to_int(Openflow.Action.SetSequence, :action_type) do
    action_type_to_int(Openflow.Action.SetSequence)
  catch
    _class, _reason -> Openflow.Action.SetSequence
  end

  def to_int(Openflow.Action.ValidateSequence, :action_type) do
    action_type_to_int(Openflow.Action.ValidateSequence)
  catch
    _class, _reason -> Openflow.Action.ValidateSequence
  end

  def to_int(Openflow.Action.Experimenter, :action_type) do
    action_type_to_int(Openflow.Action.Experimenter)
  catch
    _class, _reason -> Openflow.Action.Experimenter
  end

  def to_int(_int, :action_type) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Action.Output, :action_flags) do
    action_flags_to_int(Openflow.Action.Output)
  catch
    _class, _reason -> Openflow.Action.Output
  end

  def to_int(Openflow.Action.CopyTtlOut, :action_flags) do
    action_flags_to_int(Openflow.Action.CopyTtlOut)
  catch
    _class, _reason -> Openflow.Action.CopyTtlOut
  end

  def to_int(Openflow.Action.CopyTtlIn, :action_flags) do
    action_flags_to_int(Openflow.Action.CopyTtlIn)
  catch
    _class, _reason -> Openflow.Action.CopyTtlIn
  end

  def to_int(Openflow.Action.SetMplsTtl, :action_flags) do
    action_flags_to_int(Openflow.Action.SetMplsTtl)
  catch
    _class, _reason -> Openflow.Action.SetMplsTtl
  end

  def to_int(Openflow.Action.DecMplsTtl, :action_flags) do
    action_flags_to_int(Openflow.Action.DecMplsTtl)
  catch
    _class, _reason -> Openflow.Action.DecMplsTtl
  end

  def to_int(Openflow.Action.PushVlan, :action_flags) do
    action_flags_to_int(Openflow.Action.PushVlan)
  catch
    _class, _reason -> Openflow.Action.PushVlan
  end

  def to_int(Openflow.Action.PopVlan, :action_flags) do
    action_flags_to_int(Openflow.Action.PopVlan)
  catch
    _class, _reason -> Openflow.Action.PopVlan
  end

  def to_int(Openflow.Action.PushMpls, :action_flags) do
    action_flags_to_int(Openflow.Action.PushMpls)
  catch
    _class, _reason -> Openflow.Action.PushMpls
  end

  def to_int(Openflow.Action.PopMpls, :action_flags) do
    action_flags_to_int(Openflow.Action.PopMpls)
  catch
    _class, _reason -> Openflow.Action.PopMpls
  end

  def to_int(Openflow.Action.SetQueue, :action_flags) do
    action_flags_to_int(Openflow.Action.SetQueue)
  catch
    _class, _reason -> Openflow.Action.SetQueue
  end

  def to_int(Openflow.Action.Group, :action_flags) do
    action_flags_to_int(Openflow.Action.Group)
  catch
    _class, _reason -> Openflow.Action.Group
  end

  def to_int(Openflow.Action.SetNwTtl, :action_flags) do
    action_flags_to_int(Openflow.Action.SetNwTtl)
  catch
    _class, _reason -> Openflow.Action.SetNwTtl
  end

  def to_int(Openflow.Action.DecNwTtl, :action_flags) do
    action_flags_to_int(Openflow.Action.DecNwTtl)
  catch
    _class, _reason -> Openflow.Action.DecNwTtl
  end

  def to_int(Openflow.Action.SetField, :action_flags) do
    action_flags_to_int(Openflow.Action.SetField)
  catch
    _class, _reason -> Openflow.Action.SetField
  end

  def to_int(Openflow.Action.PushPbb, :action_flags) do
    action_flags_to_int(Openflow.Action.PushPbb)
  catch
    _class, _reason -> Openflow.Action.PushPbb
  end

  def to_int(Openflow.Action.PopPbb, :action_flags) do
    action_flags_to_int(Openflow.Action.PopPbb)
  catch
    _class, _reason -> Openflow.Action.PopPbb
  end

  def to_int(Openflow.Action.Encap, :action_flags) do
    action_flags_to_int(Openflow.Action.Encap)
  catch
    _class, _reason -> Openflow.Action.Encap
  end

  def to_int(Openflow.Action.Decap, :action_flags) do
    action_flags_to_int(Openflow.Action.Decap)
  catch
    _class, _reason -> Openflow.Action.Decap
  end

  def to_int(Openflow.Action.SetSequence, :action_flags) do
    action_flags_to_int(Openflow.Action.SetSequence)
  catch
    _class, _reason -> Openflow.Action.SetSequence
  end

  def to_int(Openflow.Action.ValidateSequence, :action_flags) do
    action_flags_to_int(Openflow.Action.ValidateSequence)
  catch
    _class, _reason -> Openflow.Action.ValidateSequence
  end

  def to_int(Openflow.Action.Experimenter, :action_flags) do
    action_flags_to_int(Openflow.Action.Experimenter)
  catch
    _class, _reason -> Openflow.Action.Experimenter
  end

  def to_int(_int, :action_flags) do
    throw(:bad_enum)
  end

  def to_int(:nicira_ext_action, :action_vendor) do
    action_vendor_to_int(:nicira_ext_action)
  catch
    _class, _reason -> :nicira_ext_action
  end

  def to_int(:onf_ext_action, :action_vendor) do
    action_vendor_to_int(:onf_ext_action)
  catch
    _class, _reason -> :onf_ext_action
  end

  def to_int(_int, :action_vendor) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Action.OnfCopyField, :onf_ext_action) do
    onf_ext_action_to_int(Openflow.Action.OnfCopyField)
  catch
    _class, _reason -> Openflow.Action.OnfCopyField
  end

  def to_int(_int, :onf_ext_action) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Action.NxResubmit, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxResubmit)
  catch
    _class, _reason -> Openflow.Action.NxResubmit
  end

  def to_int(Openflow.Action.NxSetTunnel, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxSetTunnel)
  catch
    _class, _reason -> Openflow.Action.NxSetTunnel
  end

  def to_int(Openflow.Action.NxRegMove, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxRegMove)
  catch
    _class, _reason -> Openflow.Action.NxRegMove
  end

  def to_int(Openflow.Action.NxRegLoad, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxRegLoad)
  catch
    _class, _reason -> Openflow.Action.NxRegLoad
  end

  def to_int(Openflow.Action.NxNote, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxNote)
  catch
    _class, _reason -> Openflow.Action.NxNote
  end

  def to_int(Openflow.Action.NxSetTunnel64, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxSetTunnel64)
  catch
    _class, _reason -> Openflow.Action.NxSetTunnel64
  end

  def to_int(Openflow.Action.NxMultipath, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxMultipath)
  catch
    _class, _reason -> Openflow.Action.NxMultipath
  end

  def to_int(Openflow.Action.NxBundle, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxBundle)
  catch
    _class, _reason -> Openflow.Action.NxBundle
  end

  def to_int(Openflow.Action.NxBundleLoad, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxBundleLoad)
  catch
    _class, _reason -> Openflow.Action.NxBundleLoad
  end

  def to_int(Openflow.Action.NxResubmitTable, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxResubmitTable)
  catch
    _class, _reason -> Openflow.Action.NxResubmitTable
  end

  def to_int(Openflow.Action.NxOutputReg, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxOutputReg)
  catch
    _class, _reason -> Openflow.Action.NxOutputReg
  end

  def to_int(Openflow.Action.NxLearn, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxLearn)
  catch
    _class, _reason -> Openflow.Action.NxLearn
  end

  def to_int(Openflow.Action.NxExit, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxExit)
  catch
    _class, _reason -> Openflow.Action.NxExit
  end

  def to_int(Openflow.Action.NxDecTtl, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxDecTtl)
  catch
    _class, _reason -> Openflow.Action.NxDecTtl
  end

  def to_int(Openflow.Action.NxFinTimeout, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxFinTimeout)
  catch
    _class, _reason -> Openflow.Action.NxFinTimeout
  end

  def to_int(Openflow.Action.NxController, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxController)
  catch
    _class, _reason -> Openflow.Action.NxController
  end

  def to_int(Openflow.Action.NxDecTtlCntIds, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxDecTtlCntIds)
  catch
    _class, _reason -> Openflow.Action.NxDecTtlCntIds
  end

  def to_int(Openflow.Action.NxWriteMetadata, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxWriteMetadata)
  catch
    _class, _reason -> Openflow.Action.NxWriteMetadata
  end

  def to_int(Openflow.Action.NxStackPush, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxStackPush)
  catch
    _class, _reason -> Openflow.Action.NxStackPush
  end

  def to_int(Openflow.Action.NxStackPop, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxStackPop)
  catch
    _class, _reason -> Openflow.Action.NxStackPop
  end

  def to_int(Openflow.Action.NxSample, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxSample)
  catch
    _class, _reason -> Openflow.Action.NxSample
  end

  def to_int(Openflow.Action.NxOutputReg2, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxOutputReg2)
  catch
    _class, _reason -> Openflow.Action.NxOutputReg2
  end

  def to_int(Openflow.Action.NxRegLoad2, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxRegLoad2)
  catch
    _class, _reason -> Openflow.Action.NxRegLoad2
  end

  def to_int(Openflow.Action.NxConjunction, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxConjunction)
  catch
    _class, _reason -> Openflow.Action.NxConjunction
  end

  def to_int(Openflow.Action.NxConntrack, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxConntrack)
  catch
    _class, _reason -> Openflow.Action.NxConntrack
  end

  def to_int(Openflow.Action.NxNat, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxNat)
  catch
    _class, _reason -> Openflow.Action.NxNat
  end

  def to_int(Openflow.Action.NxController2, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxController2)
  catch
    _class, _reason -> Openflow.Action.NxController2
  end

  def to_int(Openflow.Action.NxSample2, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxSample2)
  catch
    _class, _reason -> Openflow.Action.NxSample2
  end

  def to_int(Openflow.Action.NxOutputTrunc, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxOutputTrunc)
  catch
    _class, _reason -> Openflow.Action.NxOutputTrunc
  end

  def to_int(Openflow.Action.NxGroup, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxGroup)
  catch
    _class, _reason -> Openflow.Action.NxGroup
  end

  def to_int(Openflow.Action.NxSample3, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxSample3)
  catch
    _class, _reason -> Openflow.Action.NxSample3
  end

  def to_int(Openflow.Action.NxClone, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxClone)
  catch
    _class, _reason -> Openflow.Action.NxClone
  end

  def to_int(Openflow.Action.NxCtClear, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxCtClear)
  catch
    _class, _reason -> Openflow.Action.NxCtClear
  end

  def to_int(Openflow.Action.NxResubmitTableCt, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxResubmitTableCt)
  catch
    _class, _reason -> Openflow.Action.NxResubmitTableCt
  end

  def to_int(Openflow.Action.NxLearn2, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxLearn2)
  catch
    _class, _reason -> Openflow.Action.NxLearn2
  end

  def to_int(Openflow.Action.NxEncap, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxEncap)
  catch
    _class, _reason -> Openflow.Action.NxEncap
  end

  def to_int(Openflow.Action.NxDecap, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxDecap)
  catch
    _class, _reason -> Openflow.Action.NxDecap
  end

  def to_int(Openflow.Action.NxDebugRecirc, :nicira_ext_action) do
    nicira_ext_action_to_int(Openflow.Action.NxDebugRecirc)
  catch
    _class, _reason -> Openflow.Action.NxDebugRecirc
  end

  def to_int(_int, :nicira_ext_action) do
    throw(:bad_enum)
  end

  def to_int(:modulo_n, :nx_mp_algorithm) do
    nx_mp_algorithm_to_int(:modulo_n)
  catch
    _class, _reason -> :modulo_n
  end

  def to_int(:hash_threshold, :nx_mp_algorithm) do
    nx_mp_algorithm_to_int(:hash_threshold)
  catch
    _class, _reason -> :hash_threshold
  end

  def to_int(:highest_random_weight, :nx_mp_algorithm) do
    nx_mp_algorithm_to_int(:highest_random_weight)
  catch
    _class, _reason -> :highest_random_weight
  end

  def to_int(:iterative_hash, :nx_mp_algorithm) do
    nx_mp_algorithm_to_int(:iterative_hash)
  catch
    _class, _reason -> :iterative_hash
  end

  def to_int(_int, :nx_mp_algorithm) do
    throw(:bad_enum)
  end

  def to_int(:eth_src, :nx_hash_fields) do
    nx_hash_fields_to_int(:eth_src)
  catch
    _class, _reason -> :eth_src
  end

  def to_int(:symmetric_l4, :nx_hash_fields) do
    nx_hash_fields_to_int(:symmetric_l4)
  catch
    _class, _reason -> :symmetric_l4
  end

  def to_int(:symmetric_l3l4, :nx_hash_fields) do
    nx_hash_fields_to_int(:symmetric_l3l4)
  catch
    _class, _reason -> :symmetric_l3l4
  end

  def to_int(:symmetric_l3l4_udp, :nx_hash_fields) do
    nx_hash_fields_to_int(:symmetric_l3l4_udp)
  catch
    _class, _reason -> :symmetric_l3l4_udp
  end

  def to_int(:nw_src, :nx_hash_fields) do
    nx_hash_fields_to_int(:nw_src)
  catch
    _class, _reason -> :nw_src
  end

  def to_int(:nw_dst, :nx_hash_fields) do
    nx_hash_fields_to_int(:nw_dst)
  catch
    _class, _reason -> :nw_dst
  end

  def to_int(_int, :nx_hash_fields) do
    throw(:bad_enum)
  end

  def to_int(:active_backup, :nx_bd_algorithm) do
    nx_bd_algorithm_to_int(:active_backup)
  catch
    _class, _reason -> :active_backup
  end

  def to_int(:highest_random_weight, :nx_bd_algorithm) do
    nx_bd_algorithm_to_int(:highest_random_weight)
  catch
    _class, _reason -> :highest_random_weight
  end

  def to_int(_int, :nx_bd_algorithm) do
    throw(:bad_enum)
  end

  def to_int(:send_flow_rem, :nx_learn_flag) do
    nx_learn_flag_to_int(:send_flow_rem)
  catch
    _class, _reason -> :send_flow_rem
  end

  def to_int(:delete_learned, :nx_learn_flag) do
    nx_learn_flag_to_int(:delete_learned)
  catch
    _class, _reason -> :delete_learned
  end

  def to_int(:write_result, :nx_learn_flag) do
    nx_learn_flag_to_int(:write_result)
  catch
    _class, _reason -> :write_result
  end

  def to_int(_int, :nx_learn_flag) do
    throw(:bad_enum)
  end

  def to_int(:commit, :nx_conntrack_flags) do
    nx_conntrack_flags_to_int(:commit)
  catch
    _class, _reason -> :commit
  end

  def to_int(:force, :nx_conntrack_flags) do
    nx_conntrack_flags_to_int(:force)
  catch
    _class, _reason -> :force
  end

  def to_int(_int, :nx_conntrack_flags) do
    throw(:bad_enum)
  end

  def to_int(:src, :nx_nat_flags) do
    nx_nat_flags_to_int(:src)
  catch
    _class, _reason -> :src
  end

  def to_int(:dst, :nx_nat_flags) do
    nx_nat_flags_to_int(:dst)
  catch
    _class, _reason -> :dst
  end

  def to_int(:persistent, :nx_nat_flags) do
    nx_nat_flags_to_int(:persistent)
  catch
    _class, _reason -> :persistent
  end

  def to_int(:protocol_hash, :nx_nat_flags) do
    nx_nat_flags_to_int(:protocol_hash)
  catch
    _class, _reason -> :protocol_hash
  end

  def to_int(:protocol_random, :nx_nat_flags) do
    nx_nat_flags_to_int(:protocol_random)
  catch
    _class, _reason -> :protocol_random
  end

  def to_int(_int, :nx_nat_flags) do
    throw(:bad_enum)
  end

  def to_int(:ipv4_min, :nx_nat_range) do
    nx_nat_range_to_int(:ipv4_min)
  catch
    _class, _reason -> :ipv4_min
  end

  def to_int(:ipv4_max, :nx_nat_range) do
    nx_nat_range_to_int(:ipv4_max)
  catch
    _class, _reason -> :ipv4_max
  end

  def to_int(:ipv6_min, :nx_nat_range) do
    nx_nat_range_to_int(:ipv6_min)
  catch
    _class, _reason -> :ipv6_min
  end

  def to_int(:ipv6_max, :nx_nat_range) do
    nx_nat_range_to_int(:ipv6_max)
  catch
    _class, _reason -> :ipv6_max
  end

  def to_int(:proto_min, :nx_nat_range) do
    nx_nat_range_to_int(:proto_min)
  catch
    _class, _reason -> :proto_min
  end

  def to_int(:proto_max, :nx_nat_range) do
    nx_nat_range_to_int(:proto_max)
  catch
    _class, _reason -> :proto_max
  end

  def to_int(_int, :nx_nat_range) do
    throw(:bad_enum)
  end

  def to_int(:max_len, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_int(:max_len)
  catch
    _class, _reason -> :max_len
  end

  def to_int(:controller_id, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_int(:controller_id)
  catch
    _class, _reason -> :controller_id
  end

  def to_int(:reason, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_int(:reason)
  catch
    _class, _reason -> :reason
  end

  def to_int(:userdata, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_int(:userdata)
  catch
    _class, _reason -> :userdata
  end

  def to_int(:pause, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_int(:pause)
  catch
    _class, _reason -> :pause
  end

  def to_int(_int, :nx_action_controller2_prop_type) do
    throw(:bad_enum)
  end

  def to_int(:default, :nx_action_sample_direction) do
    nx_action_sample_direction_to_int(:default)
  catch
    _class, _reason -> :default
  end

  def to_int(:ingress, :nx_action_sample_direction) do
    nx_action_sample_direction_to_int(:ingress)
  catch
    _class, _reason -> :ingress
  end

  def to_int(:egress, :nx_action_sample_direction) do
    nx_action_sample_direction_to_int(:egress)
  catch
    _class, _reason -> :egress
  end

  def to_int(_int, :nx_action_sample_direction) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Action.NxFlowSpecMatch, :nx_flow_spec_type) do
    nx_flow_spec_type_to_int(Openflow.Action.NxFlowSpecMatch)
  catch
    _class, _reason -> Openflow.Action.NxFlowSpecMatch
  end

  def to_int(Openflow.Action.NxFlowSpecLoad, :nx_flow_spec_type) do
    nx_flow_spec_type_to_int(Openflow.Action.NxFlowSpecLoad)
  catch
    _class, _reason -> Openflow.Action.NxFlowSpecLoad
  end

  def to_int(Openflow.Action.NxFlowSpecOutput, :nx_flow_spec_type) do
    nx_flow_spec_type_to_int(Openflow.Action.NxFlowSpecOutput)
  catch
    _class, _reason -> Openflow.Action.NxFlowSpecOutput
  end

  def to_int(_int, :nx_flow_spec_type) do
    throw(:bad_enum)
  end

  def to_int(Openflow.Instruction.GotoTable, :instruction_type) do
    instruction_type_to_int(Openflow.Instruction.GotoTable)
  catch
    _class, _reason -> Openflow.Instruction.GotoTable
  end

  def to_int(Openflow.Instruction.WriteMetadata, :instruction_type) do
    instruction_type_to_int(Openflow.Instruction.WriteMetadata)
  catch
    _class, _reason -> Openflow.Instruction.WriteMetadata
  end

  def to_int(Openflow.Instruction.WriteActions, :instruction_type) do
    instruction_type_to_int(Openflow.Instruction.WriteActions)
  catch
    _class, _reason -> Openflow.Instruction.WriteActions
  end

  def to_int(Openflow.Instruction.ApplyActions, :instruction_type) do
    instruction_type_to_int(Openflow.Instruction.ApplyActions)
  catch
    _class, _reason -> Openflow.Instruction.ApplyActions
  end

  def to_int(Openflow.Instruction.ClearActions, :instruction_type) do
    instruction_type_to_int(Openflow.Instruction.ClearActions)
  catch
    _class, _reason -> Openflow.Instruction.ClearActions
  end

  def to_int(Openflow.Instruction.Meter, :instruction_type) do
    instruction_type_to_int(Openflow.Instruction.Meter)
  catch
    _class, _reason -> Openflow.Instruction.Meter
  end

  def to_int(Openflow.Instruction.Experimenter, :instruction_type) do
    instruction_type_to_int(Openflow.Instruction.Experimenter)
  catch
    _class, _reason -> Openflow.Instruction.Experimenter
  end

  def to_int(_int, :instruction_type) do
    throw(:bad_enum)
  end

  def to_int(:nochange, :controller_role) do
    controller_role_to_int(:nochange)
  catch
    _class, _reason -> :nochange
  end

  def to_int(:equal, :controller_role) do
    controller_role_to_int(:equal)
  catch
    _class, _reason -> :equal
  end

  def to_int(:master, :controller_role) do
    controller_role_to_int(:master)
  catch
    _class, _reason -> :master
  end

  def to_int(:slave, :controller_role) do
    controller_role_to_int(:slave)
  catch
    _class, _reason -> :slave
  end

  def to_int(_int, :controller_role) do
    throw(:bad_enum)
  end

  def to_int(:other, :nx_role) do
    nx_role_to_int(:other)
  catch
    _class, _reason -> :other
  end

  def to_int(:master, :nx_role) do
    nx_role_to_int(:master)
  catch
    _class, _reason -> :master
  end

  def to_int(:slave, :nx_role) do
    nx_role_to_int(:slave)
  catch
    _class, _reason -> :slave
  end

  def to_int(_int, :nx_role) do
    throw(:bad_enum)
  end

  def to_int(:standard, :packet_in_format) do
    packet_in_format_to_int(:standard)
  catch
    _class, _reason -> :standard
  end

  def to_int(:nxt_packet_in, :packet_in_format) do
    packet_in_format_to_int(:nxt_packet_in)
  catch
    _class, _reason -> :nxt_packet_in
  end

  def to_int(:nxt_packet_in2, :packet_in_format) do
    packet_in_format_to_int(:nxt_packet_in2)
  catch
    _class, _reason -> :nxt_packet_in2
  end

  def to_int(_int, :packet_in_format) do
    throw(:bad_enum)
  end

  def to_int(:openflow10, :flow_format) do
    flow_format_to_int(:openflow10)
  catch
    _class, _reason -> :openflow10
  end

  def to_int(:nxm, :flow_format) do
    flow_format_to_int(:nxm)
  catch
    _class, _reason -> :nxm
  end

  def to_int(_int, :flow_format) do
    throw(:bad_enum)
  end

  def to_int(:packet, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:packet)
  catch
    _class, _reason -> :packet
  end

  def to_int(:full_len, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:full_len)
  catch
    _class, _reason -> :full_len
  end

  def to_int(:buffer_id, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:buffer_id)
  catch
    _class, _reason -> :buffer_id
  end

  def to_int(:table_id, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:table_id)
  catch
    _class, _reason -> :table_id
  end

  def to_int(:cookie, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:cookie)
  catch
    _class, _reason -> :cookie
  end

  def to_int(:reason, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:reason)
  catch
    _class, _reason -> :reason
  end

  def to_int(:metadata, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:metadata)
  catch
    _class, _reason -> :metadata
  end

  def to_int(:userdata, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:userdata)
  catch
    _class, _reason -> :userdata
  end

  def to_int(:continuation, :packet_in2_prop_type) do
    packet_in2_prop_type_to_int(:continuation)
  catch
    _class, _reason -> :continuation
  end

  def to_int(_int, :packet_in2_prop_type) do
    throw(:bad_enum)
  end

  def to_int(:bridge, :continuation_prop_type) do
    continuation_prop_type_to_int(:bridge)
  catch
    _class, _reason -> :bridge
  end

  def to_int(:stack, :continuation_prop_type) do
    continuation_prop_type_to_int(:stack)
  catch
    _class, _reason -> :stack
  end

  def to_int(:mirrors, :continuation_prop_type) do
    continuation_prop_type_to_int(:mirrors)
  catch
    _class, _reason -> :mirrors
  end

  def to_int(:conntracked, :continuation_prop_type) do
    continuation_prop_type_to_int(:conntracked)
  catch
    _class, _reason -> :conntracked
  end

  def to_int(:table_id, :continuation_prop_type) do
    continuation_prop_type_to_int(:table_id)
  catch
    _class, _reason -> :table_id
  end

  def to_int(:cookie, :continuation_prop_type) do
    continuation_prop_type_to_int(:cookie)
  catch
    _class, _reason -> :cookie
  end

  def to_int(:actions, :continuation_prop_type) do
    continuation_prop_type_to_int(:actions)
  catch
    _class, _reason -> :actions
  end

  def to_int(:action_set, :continuation_prop_type) do
    continuation_prop_type_to_int(:action_set)
  catch
    _class, _reason -> :action_set
  end

  def to_int(_int, :continuation_prop_type) do
    throw(:bad_enum)
  end

  def to_int(:initial, :flow_monitor_flag) do
    flow_monitor_flag_to_int(:initial)
  catch
    _class, _reason -> :initial
  end

  def to_int(:add, :flow_monitor_flag) do
    flow_monitor_flag_to_int(:add)
  catch
    _class, _reason -> :add
  end

  def to_int(:delete, :flow_monitor_flag) do
    flow_monitor_flag_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(:modify, :flow_monitor_flag) do
    flow_monitor_flag_to_int(:modify)
  catch
    _class, _reason -> :modify
  end

  def to_int(:actions, :flow_monitor_flag) do
    flow_monitor_flag_to_int(:actions)
  catch
    _class, _reason -> :actions
  end

  def to_int(:own, :flow_monitor_flag) do
    flow_monitor_flag_to_int(:own)
  catch
    _class, _reason -> :own
  end

  def to_int(_int, :flow_monitor_flag) do
    throw(:bad_enum)
  end

  def to_int(:added, :flow_update_event) do
    flow_update_event_to_int(:added)
  catch
    _class, _reason -> :added
  end

  def to_int(:deleted, :flow_update_event) do
    flow_update_event_to_int(:deleted)
  catch
    _class, _reason -> :deleted
  end

  def to_int(:modified, :flow_update_event) do
    flow_update_event_to_int(:modified)
  catch
    _class, _reason -> :modified
  end

  def to_int(:abbrev, :flow_update_event) do
    flow_update_event_to_int(:abbrev)
  catch
    _class, _reason -> :abbrev
  end

  def to_int(_int, :flow_update_event) do
    throw(:bad_enum)
  end

  def to_int(:add, :tlv_table_mod_command) do
    tlv_table_mod_command_to_int(:add)
  catch
    _class, _reason -> :add
  end

  def to_int(:delete, :tlv_table_mod_command) do
    tlv_table_mod_command_to_int(:delete)
  catch
    _class, _reason -> :delete
  end

  def to_int(:clear, :tlv_table_mod_command) do
    tlv_table_mod_command_to_int(:clear)
  catch
    _class, _reason -> :clear
  end

  def to_int(_int, :tlv_table_mod_command) do
    throw(:bad_enum)
  end

  def to_int(:instructions, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:instructions)
  catch
    _class, _reason -> :instructions
  end

  def to_int(:instructions_miss, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:instructions_miss)
  catch
    _class, _reason -> :instructions_miss
  end

  def to_int(:next_tables, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:next_tables)
  catch
    _class, _reason -> :next_tables
  end

  def to_int(:next_tables_miss, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:next_tables_miss)
  catch
    _class, _reason -> :next_tables_miss
  end

  def to_int(:write_actions, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:write_actions)
  catch
    _class, _reason -> :write_actions
  end

  def to_int(:write_actions_miss, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:write_actions_miss)
  catch
    _class, _reason -> :write_actions_miss
  end

  def to_int(:apply_actions, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:apply_actions)
  catch
    _class, _reason -> :apply_actions
  end

  def to_int(:apply_actions_miss, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:apply_actions_miss)
  catch
    _class, _reason -> :apply_actions_miss
  end

  def to_int(:match, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:match)
  catch
    _class, _reason -> :match
  end

  def to_int(:wildcards, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:wildcards)
  catch
    _class, _reason -> :wildcards
  end

  def to_int(:write_setfield, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:write_setfield)
  catch
    _class, _reason -> :write_setfield
  end

  def to_int(:write_setfield_miss, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:write_setfield_miss)
  catch
    _class, _reason -> :write_setfield_miss
  end

  def to_int(:apply_setfield, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:apply_setfield)
  catch
    _class, _reason -> :apply_setfield
  end

  def to_int(:apply_setfield_miss, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:apply_setfield_miss)
  catch
    _class, _reason -> :apply_setfield_miss
  end

  def to_int(:experimenter, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:experimenter)
  catch
    _class, _reason -> :experimenter
  end

  def to_int(:experimenter_miss, :table_feature_prop_type) do
    table_feature_prop_type_to_int(:experimenter_miss)
  catch
    _class, _reason -> :experimenter_miss
  end

  def to_int(_int, :table_feature_prop_type) do
    throw(:bad_enum)
  end

  def to_int(:open_request, :bundle_ctrl_type) do
    bundle_ctrl_type_to_int(:open_request)
  catch
    _class, _reason -> :open_request
  end

  def to_int(:open_reply, :bundle_ctrl_type) do
    bundle_ctrl_type_to_int(:open_reply)
  catch
    _class, _reason -> :open_reply
  end

  def to_int(:close_request, :bundle_ctrl_type) do
    bundle_ctrl_type_to_int(:close_request)
  catch
    _class, _reason -> :close_request
  end

  def to_int(:close_reply, :bundle_ctrl_type) do
    bundle_ctrl_type_to_int(:close_reply)
  catch
    _class, _reason -> :close_reply
  end

  def to_int(:commit_request, :bundle_ctrl_type) do
    bundle_ctrl_type_to_int(:commit_request)
  catch
    _class, _reason -> :commit_request
  end

  def to_int(:commit_reply, :bundle_ctrl_type) do
    bundle_ctrl_type_to_int(:commit_reply)
  catch
    _class, _reason -> :commit_reply
  end

  def to_int(:discard_request, :bundle_ctrl_type) do
    bundle_ctrl_type_to_int(:discard_request)
  catch
    _class, _reason -> :discard_request
  end

  def to_int(:discard_reply, :bundle_ctrl_type) do
    bundle_ctrl_type_to_int(:discard_reply)
  catch
    _class, _reason -> :discard_reply
  end

  def to_int(_int, :bundle_ctrl_type) do
    throw(:bad_enum)
  end

  def to_int(:atomic, :bundle_flags) do
    bundle_flags_to_int(:atomic)
  catch
    _class, _reason -> :atomic
  end

  def to_int(:ordered, :bundle_flags) do
    bundle_flags_to_int(:ordered)
  catch
    _class, _reason -> :ordered
  end

  def to_int(_int, :bundle_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :openflow_codec) do
    openflow_codec_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :openflow_codec) do
    openflow_codec_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :openflow_codec) do
    openflow_codec_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :openflow_codec) do
    openflow_codec_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :openflow_codec) do
    openflow_codec_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :openflow_codec) do
    openflow_codec_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :openflow_codec) do
    openflow_codec_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :openflow_codec) do
    openflow_codec_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :openflow_codec) do
    openflow_codec_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :openflow_codec) do
    openflow_codec_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :openflow_codec) do
    openflow_codec_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :openflow_codec) do
    openflow_codec_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :openflow_codec) do
    openflow_codec_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :openflow_codec) do
    openflow_codec_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :openflow_codec) do
    openflow_codec_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :openflow_codec) do
    openflow_codec_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x10, :openflow_codec) do
    openflow_codec_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x11, :openflow_codec) do
    openflow_codec_to_atom(0x11)
  catch
    _class, _reason -> 17
  end

  def to_atom(0x12, :openflow_codec) do
    openflow_codec_to_atom(0x12)
  catch
    _class, _reason -> 18
  end

  def to_atom(0x13, :openflow_codec) do
    openflow_codec_to_atom(0x13)
  catch
    _class, _reason -> 19
  end

  def to_atom(0x14, :openflow_codec) do
    openflow_codec_to_atom(0x14)
  catch
    _class, _reason -> 20
  end

  def to_atom(0x15, :openflow_codec) do
    openflow_codec_to_atom(0x15)
  catch
    _class, _reason -> 21
  end

  def to_atom(0x18, :openflow_codec) do
    openflow_codec_to_atom(0x18)
  catch
    _class, _reason -> 24
  end

  def to_atom(0x19, :openflow_codec) do
    openflow_codec_to_atom(0x19)
  catch
    _class, _reason -> 25
  end

  def to_atom(0x1A, :openflow_codec) do
    openflow_codec_to_atom(0x1A)
  catch
    _class, _reason -> 26
  end

  def to_atom(0x1B, :openflow_codec) do
    openflow_codec_to_atom(0x1B)
  catch
    _class, _reason -> 27
  end

  def to_atom(0x1C, :openflow_codec) do
    openflow_codec_to_atom(0x1C)
  catch
    _class, _reason -> 28
  end

  def to_atom(0x1D, :openflow_codec) do
    openflow_codec_to_atom(0x1D)
  catch
    _class, _reason -> 29
  end

  def to_atom(_, :openflow_codec) do
    throw(:bad_enum)
  end

  def to_atom(0x2320, :experimenter_id) do
    experimenter_id_to_atom(0x2320)
  catch
    _class, _reason -> 8992
  end

  def to_atom(0x4F4E4600, :experimenter_id) do
    experimenter_id_to_atom(0x4F4E4600)
  catch
    _class, _reason -> 1_330_529_792
  end

  def to_atom(_, :experimenter_id) do
    throw(:bad_enum)
  end

  def to_atom(0x10, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x14, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x14)
  catch
    _class, _reason -> 20
  end

  def to_atom(0x15, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x15)
  catch
    _class, _reason -> 21
  end

  def to_atom(0x16, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x16)
  catch
    _class, _reason -> 22
  end

  def to_atom(0x17, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x17)
  catch
    _class, _reason -> 23
  end

  def to_atom(0x18, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x18)
  catch
    _class, _reason -> 24
  end

  def to_atom(0x19, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x19)
  catch
    _class, _reason -> 25
  end

  def to_atom(0x1A, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x1A)
  catch
    _class, _reason -> 26
  end

  def to_atom(0x1B, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x1B)
  catch
    _class, _reason -> 27
  end

  def to_atom(0x1C, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x1C)
  catch
    _class, _reason -> 28
  end

  def to_atom(0x1D, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x1D)
  catch
    _class, _reason -> 29
  end

  def to_atom(0x1E, :nicira_ext_message) do
    nicira_ext_message_to_atom(0x1E)
  catch
    _class, _reason -> 30
  end

  def to_atom(_, :nicira_ext_message) do
    throw(:bad_enum)
  end

  def to_atom(0x8FC, :onf_ext_message) do
    onf_ext_message_to_atom(0x8FC)
  catch
    _class, _reason -> 2300
  end

  def to_atom(0x8FD, :onf_ext_message) do
    onf_ext_message_to_atom(0x8FD)
  catch
    _class, _reason -> 2301
  end

  def to_atom(_, :onf_ext_message) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :multipart_request_flags) do
    multipart_request_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(_, :multipart_request_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :multipart_reply_flags) do
    multipart_reply_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(_, :multipart_reply_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :multipart_request_codec) do
    multipart_request_codec_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :multipart_request_codec) do
    multipart_request_codec_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :multipart_request_codec) do
    multipart_request_codec_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :multipart_request_codec) do
    multipart_request_codec_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :multipart_request_codec) do
    multipart_request_codec_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xFFFF, :multipart_request_codec) do
    multipart_request_codec_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :multipart_request_codec) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xFFFF, :multipart_reply_codec) do
    multipart_reply_codec_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :multipart_reply_codec) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nicira_ext_stats) do
    nicira_ext_stats_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nicira_ext_stats) do
    nicira_ext_stats_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nicira_ext_stats) do
    nicira_ext_stats_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :nicira_ext_stats) do
    nicira_ext_stats_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :nicira_ext_stats) do
    nicira_ext_stats_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(_, :nicira_ext_stats) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :hello_elem) do
    hello_elem_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(_, :hello_elem) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :error_type) do
    error_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :error_type) do
    error_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :error_type) do
    error_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :error_type) do
    error_type_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :error_type) do
    error_type_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :error_type) do
    error_type_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :error_type) do
    error_type_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :error_type) do
    error_type_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :error_type) do
    error_type_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :error_type) do
    error_type_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :error_type) do
    error_type_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :error_type) do
    error_type_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :error_type) do
    error_type_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :error_type) do
    error_type_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xFFFF, :error_type) do
    error_type_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :error_type) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :hello_failed) do
    hello_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :hello_failed) do
    hello_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(_, :hello_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :bad_request) do
    bad_request_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :bad_request) do
    bad_request_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :bad_request) do
    bad_request_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :bad_request) do
    bad_request_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :bad_request) do
    bad_request_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :bad_request) do
    bad_request_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :bad_request) do
    bad_request_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :bad_request) do
    bad_request_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :bad_request) do
    bad_request_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :bad_request) do
    bad_request_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :bad_request) do
    bad_request_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :bad_request) do
    bad_request_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :bad_request) do
    bad_request_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :bad_request) do
    bad_request_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :bad_request) do
    bad_request_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :bad_request) do
    bad_request_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x100, :bad_request) do
    bad_request_to_atom(0x100)
  catch
    _class, _reason -> 256
  end

  def to_atom(0x101, :bad_request) do
    bad_request_to_atom(0x101)
  catch
    _class, _reason -> 257
  end

  def to_atom(0x203, :bad_request) do
    bad_request_to_atom(0x203)
  catch
    _class, _reason -> 515
  end

  def to_atom(0x204, :bad_request) do
    bad_request_to_atom(0x204)
  catch
    _class, _reason -> 516
  end

  def to_atom(0x208, :bad_request) do
    bad_request_to_atom(0x208)
  catch
    _class, _reason -> 520
  end

  def to_atom(0x209, :bad_request) do
    bad_request_to_atom(0x209)
  catch
    _class, _reason -> 521
  end

  def to_atom(0x215, :bad_request) do
    bad_request_to_atom(0x215)
  catch
    _class, _reason -> 533
  end

  def to_atom(0x216, :bad_request) do
    bad_request_to_atom(0x216)
  catch
    _class, _reason -> 534
  end

  def to_atom(_, :bad_request) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :bad_action) do
    bad_action_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :bad_action) do
    bad_action_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :bad_action) do
    bad_action_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :bad_action) do
    bad_action_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :bad_action) do
    bad_action_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :bad_action) do
    bad_action_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :bad_action) do
    bad_action_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :bad_action) do
    bad_action_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :bad_action) do
    bad_action_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :bad_action) do
    bad_action_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :bad_action) do
    bad_action_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :bad_action) do
    bad_action_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :bad_action) do
    bad_action_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :bad_action) do
    bad_action_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :bad_action) do
    bad_action_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :bad_action) do
    bad_action_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x100, :bad_action) do
    bad_action_to_atom(0x100)
  catch
    _class, _reason -> 256
  end

  def to_atom(0x109, :bad_action) do
    bad_action_to_atom(0x109)
  catch
    _class, _reason -> 265
  end

  def to_atom(0x20E, :bad_action) do
    bad_action_to_atom(0x20E)
  catch
    _class, _reason -> 526
  end

  def to_atom(_, :bad_action) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :bad_instruction) do
    bad_instruction_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :bad_instruction) do
    bad_instruction_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :bad_instruction) do
    bad_instruction_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :bad_instruction) do
    bad_instruction_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :bad_instruction) do
    bad_instruction_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :bad_instruction) do
    bad_instruction_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :bad_instruction) do
    bad_instruction_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :bad_instruction) do
    bad_instruction_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :bad_instruction) do
    bad_instruction_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x100, :bad_instruction) do
    bad_instruction_to_atom(0x100)
  catch
    _class, _reason -> 256
  end

  def to_atom(_, :bad_instruction) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :bad_match) do
    bad_match_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :bad_match) do
    bad_match_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :bad_match) do
    bad_match_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :bad_match) do
    bad_match_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :bad_match) do
    bad_match_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :bad_match) do
    bad_match_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :bad_match) do
    bad_match_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :bad_match) do
    bad_match_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :bad_match) do
    bad_match_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :bad_match) do
    bad_match_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :bad_match) do
    bad_match_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :bad_match) do
    bad_match_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0x108, :bad_match) do
    bad_match_to_atom(0x108)
  catch
    _class, _reason -> 264
  end

  def to_atom(_, :bad_match) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :flow_mod_failed) do
    flow_mod_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :flow_mod_failed) do
    flow_mod_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :flow_mod_failed) do
    flow_mod_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :flow_mod_failed) do
    flow_mod_failed_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :flow_mod_failed) do
    flow_mod_failed_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :flow_mod_failed) do
    flow_mod_failed_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :flow_mod_failed) do
    flow_mod_failed_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :flow_mod_failed) do
    flow_mod_failed_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(_, :flow_mod_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :group_mod_failed) do
    group_mod_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :group_mod_failed) do
    group_mod_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :group_mod_failed) do
    group_mod_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :group_mod_failed) do
    group_mod_failed_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :group_mod_failed) do
    group_mod_failed_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :group_mod_failed) do
    group_mod_failed_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :group_mod_failed) do
    group_mod_failed_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :group_mod_failed) do
    group_mod_failed_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :group_mod_failed) do
    group_mod_failed_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :group_mod_failed) do
    group_mod_failed_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :group_mod_failed) do
    group_mod_failed_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :group_mod_failed) do
    group_mod_failed_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :group_mod_failed) do
    group_mod_failed_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :group_mod_failed) do
    group_mod_failed_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :group_mod_failed) do
    group_mod_failed_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :group_mod_failed) do
    group_mod_failed_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x10, :group_mod_failed) do
    group_mod_failed_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(_, :group_mod_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :port_mod_failed) do
    port_mod_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :port_mod_failed) do
    port_mod_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :port_mod_failed) do
    port_mod_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :port_mod_failed) do
    port_mod_failed_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :port_mod_failed) do
    port_mod_failed_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(_, :port_mod_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :table_mod_failed) do
    table_mod_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :table_mod_failed) do
    table_mod_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :table_mod_failed) do
    table_mod_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :table_mod_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :queue_op_failed) do
    queue_op_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :queue_op_failed) do
    queue_op_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :queue_op_failed) do
    queue_op_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :queue_op_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :switch_config_failed) do
    switch_config_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :switch_config_failed) do
    switch_config_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :switch_config_failed) do
    switch_config_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :switch_config_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :role_request_failed) do
    role_request_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :role_request_failed) do
    role_request_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :role_request_failed) do
    role_request_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :role_request_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :meter_mod_failed) do
    meter_mod_failed_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :meter_mod_failed) do
    meter_mod_failed_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :meter_mod_failed) do
    meter_mod_failed_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(_, :meter_mod_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :table_features_failed) do
    table_features_failed_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :table_features_failed) do
    table_features_failed_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :table_features_failed) do
    table_features_failed_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :table_features_failed) do
    table_features_failed_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :table_features_failed) do
    table_features_failed_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :table_features_failed) do
    table_features_failed_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(_, :table_features_failed) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :switch_capabilities) do
    switch_capabilities_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :switch_capabilities) do
    switch_capabilities_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :switch_capabilities) do
    switch_capabilities_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :switch_capabilities) do
    switch_capabilities_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x20, :switch_capabilities) do
    switch_capabilities_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x40, :switch_capabilities) do
    switch_capabilities_to_atom(0x40)
  catch
    _class, _reason -> 64
  end

  def to_atom(0x80, :switch_capabilities) do
    switch_capabilities_to_atom(0x80)
  catch
    _class, _reason -> 128
  end

  def to_atom(0x100, :switch_capabilities) do
    switch_capabilities_to_atom(0x100)
  catch
    _class, _reason -> 256
  end

  def to_atom(_, :switch_capabilities) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :config_flags) do
    config_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :config_flags) do
    config_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :config_flags) do
    throw(:bad_enum)
  end

  def to_atom(0xFFE5, :controller_max_len) do
    controller_max_len_to_atom(0xFFE5)
  catch
    _class, _reason -> 65509
  end

  def to_atom(0xFFFF, :controller_max_len) do
    controller_max_len_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :controller_max_len) do
    throw(:bad_enum)
  end

  def to_atom(0x2320, :experimenter_oxm_vendors) do
    experimenter_oxm_vendors_to_atom(0x2320)
  catch
    _class, _reason -> 8992
  end

  def to_atom(0x2428, :experimenter_oxm_vendors) do
    experimenter_oxm_vendors_to_atom(0x2428)
  catch
    _class, _reason -> 9256
  end

  def to_atom(0x4F4E4600, :experimenter_oxm_vendors) do
    experimenter_oxm_vendors_to_atom(0x4F4E4600)
  catch
    _class, _reason -> 1_330_529_792
  end

  def to_atom(_, :experimenter_oxm_vendors) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :match_type) do
    match_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :match_type) do
    match_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(_, :match_type) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :oxm_class) do
    oxm_class_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :oxm_class) do
    oxm_class_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x8000, :oxm_class) do
    oxm_class_to_atom(0x8000)
  catch
    _class, _reason -> 32768
  end

  def to_atom(0x8001, :oxm_class) do
    oxm_class_to_atom(0x8001)
  catch
    _class, _reason -> 32769
  end

  def to_atom(0xFFFF, :oxm_class) do
    oxm_class_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :oxm_class) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nxm_0) do
    nxm_0_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nxm_0) do
    nxm_0_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nxm_0) do
    nxm_0_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :nxm_0) do
    nxm_0_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :nxm_0) do
    nxm_0_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :nxm_0) do
    nxm_0_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :nxm_0) do
    nxm_0_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :nxm_0) do
    nxm_0_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :nxm_0) do
    nxm_0_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :nxm_0) do
    nxm_0_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :nxm_0) do
    nxm_0_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :nxm_0) do
    nxm_0_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :nxm_0) do
    nxm_0_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :nxm_0) do
    nxm_0_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :nxm_0) do
    nxm_0_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :nxm_0) do
    nxm_0_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x10, :nxm_0) do
    nxm_0_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x11, :nxm_0) do
    nxm_0_to_atom(0x11)
  catch
    _class, _reason -> 17
  end

  def to_atom(0x22, :nxm_0) do
    nxm_0_to_atom(0x22)
  catch
    _class, _reason -> 34
  end

  def to_atom(_, :nxm_0) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nxm_1) do
    nxm_1_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nxm_1) do
    nxm_1_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nxm_1) do
    nxm_1_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :nxm_1) do
    nxm_1_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :nxm_1) do
    nxm_1_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :nxm_1) do
    nxm_1_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :nxm_1) do
    nxm_1_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :nxm_1) do
    nxm_1_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :nxm_1) do
    nxm_1_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :nxm_1) do
    nxm_1_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :nxm_1) do
    nxm_1_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :nxm_1) do
    nxm_1_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :nxm_1) do
    nxm_1_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :nxm_1) do
    nxm_1_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :nxm_1) do
    nxm_1_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :nxm_1) do
    nxm_1_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x10, :nxm_1) do
    nxm_1_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x11, :nxm_1) do
    nxm_1_to_atom(0x11)
  catch
    _class, _reason -> 17
  end

  def to_atom(0x12, :nxm_1) do
    nxm_1_to_atom(0x12)
  catch
    _class, _reason -> 18
  end

  def to_atom(0x13, :nxm_1) do
    nxm_1_to_atom(0x13)
  catch
    _class, _reason -> 19
  end

  def to_atom(0x14, :nxm_1) do
    nxm_1_to_atom(0x14)
  catch
    _class, _reason -> 20
  end

  def to_atom(0x15, :nxm_1) do
    nxm_1_to_atom(0x15)
  catch
    _class, _reason -> 21
  end

  def to_atom(0x16, :nxm_1) do
    nxm_1_to_atom(0x16)
  catch
    _class, _reason -> 22
  end

  def to_atom(0x17, :nxm_1) do
    nxm_1_to_atom(0x17)
  catch
    _class, _reason -> 23
  end

  def to_atom(0x18, :nxm_1) do
    nxm_1_to_atom(0x18)
  catch
    _class, _reason -> 24
  end

  def to_atom(0x19, :nxm_1) do
    nxm_1_to_atom(0x19)
  catch
    _class, _reason -> 25
  end

  def to_atom(0x1A, :nxm_1) do
    nxm_1_to_atom(0x1A)
  catch
    _class, _reason -> 26
  end

  def to_atom(0x1B, :nxm_1) do
    nxm_1_to_atom(0x1B)
  catch
    _class, _reason -> 27
  end

  def to_atom(0x1C, :nxm_1) do
    nxm_1_to_atom(0x1C)
  catch
    _class, _reason -> 28
  end

  def to_atom(0x1D, :nxm_1) do
    nxm_1_to_atom(0x1D)
  catch
    _class, _reason -> 29
  end

  def to_atom(0x1E, :nxm_1) do
    nxm_1_to_atom(0x1E)
  catch
    _class, _reason -> 30
  end

  def to_atom(0x1F, :nxm_1) do
    nxm_1_to_atom(0x1F)
  catch
    _class, _reason -> 31
  end

  def to_atom(0x20, :nxm_1) do
    nxm_1_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x21, :nxm_1) do
    nxm_1_to_atom(0x21)
  catch
    _class, _reason -> 33
  end

  def to_atom(0x23, :nxm_1) do
    nxm_1_to_atom(0x23)
  catch
    _class, _reason -> 35
  end

  def to_atom(0x24, :nxm_1) do
    nxm_1_to_atom(0x24)
  catch
    _class, _reason -> 36
  end

  def to_atom(0x25, :nxm_1) do
    nxm_1_to_atom(0x25)
  catch
    _class, _reason -> 37
  end

  def to_atom(0x26, :nxm_1) do
    nxm_1_to_atom(0x26)
  catch
    _class, _reason -> 38
  end

  def to_atom(0x27, :nxm_1) do
    nxm_1_to_atom(0x27)
  catch
    _class, _reason -> 39
  end

  def to_atom(0x28, :nxm_1) do
    nxm_1_to_atom(0x28)
  catch
    _class, _reason -> 40
  end

  def to_atom(0x29, :nxm_1) do
    nxm_1_to_atom(0x29)
  catch
    _class, _reason -> 41
  end

  def to_atom(0x2A, :nxm_1) do
    nxm_1_to_atom(0x2A)
  catch
    _class, _reason -> 42
  end

  def to_atom(0x2B, :nxm_1) do
    nxm_1_to_atom(0x2B)
  catch
    _class, _reason -> 43
  end

  def to_atom(0x2C, :nxm_1) do
    nxm_1_to_atom(0x2C)
  catch
    _class, _reason -> 44
  end

  def to_atom(0x2D, :nxm_1) do
    nxm_1_to_atom(0x2D)
  catch
    _class, _reason -> 45
  end

  def to_atom(0x2E, :nxm_1) do
    nxm_1_to_atom(0x2E)
  catch
    _class, _reason -> 46
  end

  def to_atom(0x2F, :nxm_1) do
    nxm_1_to_atom(0x2F)
  catch
    _class, _reason -> 47
  end

  def to_atom(0x30, :nxm_1) do
    nxm_1_to_atom(0x30)
  catch
    _class, _reason -> 48
  end

  def to_atom(0x31, :nxm_1) do
    nxm_1_to_atom(0x31)
  catch
    _class, _reason -> 49
  end

  def to_atom(0x32, :nxm_1) do
    nxm_1_to_atom(0x32)
  catch
    _class, _reason -> 50
  end

  def to_atom(0x33, :nxm_1) do
    nxm_1_to_atom(0x33)
  catch
    _class, _reason -> 51
  end

  def to_atom(0x34, :nxm_1) do
    nxm_1_to_atom(0x34)
  catch
    _class, _reason -> 52
  end

  def to_atom(0x35, :nxm_1) do
    nxm_1_to_atom(0x35)
  catch
    _class, _reason -> 53
  end

  def to_atom(0x36, :nxm_1) do
    nxm_1_to_atom(0x36)
  catch
    _class, _reason -> 54
  end

  def to_atom(0x37, :nxm_1) do
    nxm_1_to_atom(0x37)
  catch
    _class, _reason -> 55
  end

  def to_atom(0x38, :nxm_1) do
    nxm_1_to_atom(0x38)
  catch
    _class, _reason -> 56
  end

  def to_atom(0x39, :nxm_1) do
    nxm_1_to_atom(0x39)
  catch
    _class, _reason -> 57
  end

  def to_atom(0x3A, :nxm_1) do
    nxm_1_to_atom(0x3A)
  catch
    _class, _reason -> 58
  end

  def to_atom(0x3B, :nxm_1) do
    nxm_1_to_atom(0x3B)
  catch
    _class, _reason -> 59
  end

  def to_atom(0x3C, :nxm_1) do
    nxm_1_to_atom(0x3C)
  catch
    _class, _reason -> 60
  end

  def to_atom(0x3D, :nxm_1) do
    nxm_1_to_atom(0x3D)
  catch
    _class, _reason -> 61
  end

  def to_atom(0x3E, :nxm_1) do
    nxm_1_to_atom(0x3E)
  catch
    _class, _reason -> 62
  end

  def to_atom(0x3F, :nxm_1) do
    nxm_1_to_atom(0x3F)
  catch
    _class, _reason -> 63
  end

  def to_atom(0x40, :nxm_1) do
    nxm_1_to_atom(0x40)
  catch
    _class, _reason -> 64
  end

  def to_atom(0x41, :nxm_1) do
    nxm_1_to_atom(0x41)
  catch
    _class, _reason -> 65
  end

  def to_atom(0x42, :nxm_1) do
    nxm_1_to_atom(0x42)
  catch
    _class, _reason -> 66
  end

  def to_atom(0x43, :nxm_1) do
    nxm_1_to_atom(0x43)
  catch
    _class, _reason -> 67
  end

  def to_atom(0x44, :nxm_1) do
    nxm_1_to_atom(0x44)
  catch
    _class, _reason -> 68
  end

  def to_atom(0x45, :nxm_1) do
    nxm_1_to_atom(0x45)
  catch
    _class, _reason -> 69
  end

  def to_atom(0x46, :nxm_1) do
    nxm_1_to_atom(0x46)
  catch
    _class, _reason -> 70
  end

  def to_atom(0x47, :nxm_1) do
    nxm_1_to_atom(0x47)
  catch
    _class, _reason -> 71
  end

  def to_atom(0x48, :nxm_1) do
    nxm_1_to_atom(0x48)
  catch
    _class, _reason -> 72
  end

  def to_atom(0x49, :nxm_1) do
    nxm_1_to_atom(0x49)
  catch
    _class, _reason -> 73
  end

  def to_atom(0x4A, :nxm_1) do
    nxm_1_to_atom(0x4A)
  catch
    _class, _reason -> 74
  end

  def to_atom(0x4B, :nxm_1) do
    nxm_1_to_atom(0x4B)
  catch
    _class, _reason -> 75
  end

  def to_atom(0x4C, :nxm_1) do
    nxm_1_to_atom(0x4C)
  catch
    _class, _reason -> 76
  end

  def to_atom(0x4D, :nxm_1) do
    nxm_1_to_atom(0x4D)
  catch
    _class, _reason -> 77
  end

  def to_atom(0x4E, :nxm_1) do
    nxm_1_to_atom(0x4E)
  catch
    _class, _reason -> 78
  end

  def to_atom(0x4F, :nxm_1) do
    nxm_1_to_atom(0x4F)
  catch
    _class, _reason -> 79
  end

  def to_atom(0x50, :nxm_1) do
    nxm_1_to_atom(0x50)
  catch
    _class, _reason -> 80
  end

  def to_atom(0x51, :nxm_1) do
    nxm_1_to_atom(0x51)
  catch
    _class, _reason -> 81
  end

  def to_atom(0x52, :nxm_1) do
    nxm_1_to_atom(0x52)
  catch
    _class, _reason -> 82
  end

  def to_atom(0x53, :nxm_1) do
    nxm_1_to_atom(0x53)
  catch
    _class, _reason -> 83
  end

  def to_atom(0x54, :nxm_1) do
    nxm_1_to_atom(0x54)
  catch
    _class, _reason -> 84
  end

  def to_atom(0x55, :nxm_1) do
    nxm_1_to_atom(0x55)
  catch
    _class, _reason -> 85
  end

  def to_atom(0x56, :nxm_1) do
    nxm_1_to_atom(0x56)
  catch
    _class, _reason -> 86
  end

  def to_atom(0x57, :nxm_1) do
    nxm_1_to_atom(0x57)
  catch
    _class, _reason -> 87
  end

  def to_atom(0x58, :nxm_1) do
    nxm_1_to_atom(0x58)
  catch
    _class, _reason -> 88
  end

  def to_atom(0x59, :nxm_1) do
    nxm_1_to_atom(0x59)
  catch
    _class, _reason -> 89
  end

  def to_atom(0x5A, :nxm_1) do
    nxm_1_to_atom(0x5A)
  catch
    _class, _reason -> 90
  end

  def to_atom(0x5B, :nxm_1) do
    nxm_1_to_atom(0x5B)
  catch
    _class, _reason -> 91
  end

  def to_atom(0x5C, :nxm_1) do
    nxm_1_to_atom(0x5C)
  catch
    _class, _reason -> 92
  end

  def to_atom(0x5D, :nxm_1) do
    nxm_1_to_atom(0x5D)
  catch
    _class, _reason -> 93
  end

  def to_atom(0x5E, :nxm_1) do
    nxm_1_to_atom(0x5E)
  catch
    _class, _reason -> 94
  end

  def to_atom(0x5F, :nxm_1) do
    nxm_1_to_atom(0x5F)
  catch
    _class, _reason -> 95
  end

  def to_atom(0x60, :nxm_1) do
    nxm_1_to_atom(0x60)
  catch
    _class, _reason -> 96
  end

  def to_atom(0x61, :nxm_1) do
    nxm_1_to_atom(0x61)
  catch
    _class, _reason -> 97
  end

  def to_atom(0x62, :nxm_1) do
    nxm_1_to_atom(0x62)
  catch
    _class, _reason -> 98
  end

  def to_atom(0x63, :nxm_1) do
    nxm_1_to_atom(0x63)
  catch
    _class, _reason -> 99
  end

  def to_atom(0x64, :nxm_1) do
    nxm_1_to_atom(0x64)
  catch
    _class, _reason -> 100
  end

  def to_atom(0x65, :nxm_1) do
    nxm_1_to_atom(0x65)
  catch
    _class, _reason -> 101
  end

  def to_atom(0x66, :nxm_1) do
    nxm_1_to_atom(0x66)
  catch
    _class, _reason -> 102
  end

  def to_atom(0x67, :nxm_1) do
    nxm_1_to_atom(0x67)
  catch
    _class, _reason -> 103
  end

  def to_atom(0x68, :nxm_1) do
    nxm_1_to_atom(0x68)
  catch
    _class, _reason -> 104
  end

  def to_atom(0x69, :nxm_1) do
    nxm_1_to_atom(0x69)
  catch
    _class, _reason -> 105
  end

  def to_atom(0x6A, :nxm_1) do
    nxm_1_to_atom(0x6A)
  catch
    _class, _reason -> 106
  end

  def to_atom(0x6B, :nxm_1) do
    nxm_1_to_atom(0x6B)
  catch
    _class, _reason -> 107
  end

  def to_atom(0x6C, :nxm_1) do
    nxm_1_to_atom(0x6C)
  catch
    _class, _reason -> 108
  end

  def to_atom(0x6D, :nxm_1) do
    nxm_1_to_atom(0x6D)
  catch
    _class, _reason -> 109
  end

  def to_atom(0x6E, :nxm_1) do
    nxm_1_to_atom(0x6E)
  catch
    _class, _reason -> 110
  end

  def to_atom(0x6F, :nxm_1) do
    nxm_1_to_atom(0x6F)
  catch
    _class, _reason -> 111
  end

  def to_atom(0x70, :nxm_1) do
    nxm_1_to_atom(0x70)
  catch
    _class, _reason -> 112
  end

  def to_atom(0x71, :nxm_1) do
    nxm_1_to_atom(0x71)
  catch
    _class, _reason -> 113
  end

  def to_atom(0x72, :nxm_1) do
    nxm_1_to_atom(0x72)
  catch
    _class, _reason -> 114
  end

  def to_atom(0x73, :nxm_1) do
    nxm_1_to_atom(0x73)
  catch
    _class, _reason -> 115
  end

  def to_atom(0x74, :nxm_1) do
    nxm_1_to_atom(0x74)
  catch
    _class, _reason -> 116
  end

  def to_atom(0x75, :nxm_1) do
    nxm_1_to_atom(0x75)
  catch
    _class, _reason -> 117
  end

  def to_atom(0x76, :nxm_1) do
    nxm_1_to_atom(0x76)
  catch
    _class, _reason -> 118
  end

  def to_atom(0x77, :nxm_1) do
    nxm_1_to_atom(0x77)
  catch
    _class, _reason -> 119
  end

  def to_atom(0x78, :nxm_1) do
    nxm_1_to_atom(0x78)
  catch
    _class, _reason -> 120
  end

  def to_atom(0x79, :nxm_1) do
    nxm_1_to_atom(0x79)
  catch
    _class, _reason -> 121
  end

  def to_atom(0x7A, :nxm_1) do
    nxm_1_to_atom(0x7A)
  catch
    _class, _reason -> 122
  end

  def to_atom(0x7B, :nxm_1) do
    nxm_1_to_atom(0x7B)
  catch
    _class, _reason -> 123
  end

  def to_atom(0x7C, :nxm_1) do
    nxm_1_to_atom(0x7C)
  catch
    _class, _reason -> 124
  end

  def to_atom(0x7D, :nxm_1) do
    nxm_1_to_atom(0x7D)
  catch
    _class, _reason -> 125
  end

  def to_atom(_, :nxm_1) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :openflow_basic) do
    openflow_basic_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :openflow_basic) do
    openflow_basic_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :openflow_basic) do
    openflow_basic_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :openflow_basic) do
    openflow_basic_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :openflow_basic) do
    openflow_basic_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :openflow_basic) do
    openflow_basic_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :openflow_basic) do
    openflow_basic_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :openflow_basic) do
    openflow_basic_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :openflow_basic) do
    openflow_basic_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :openflow_basic) do
    openflow_basic_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :openflow_basic) do
    openflow_basic_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xB, :openflow_basic) do
    openflow_basic_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :openflow_basic) do
    openflow_basic_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :openflow_basic) do
    openflow_basic_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :openflow_basic) do
    openflow_basic_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :openflow_basic) do
    openflow_basic_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x10, :openflow_basic) do
    openflow_basic_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x11, :openflow_basic) do
    openflow_basic_to_atom(0x11)
  catch
    _class, _reason -> 17
  end

  def to_atom(0x12, :openflow_basic) do
    openflow_basic_to_atom(0x12)
  catch
    _class, _reason -> 18
  end

  def to_atom(0x13, :openflow_basic) do
    openflow_basic_to_atom(0x13)
  catch
    _class, _reason -> 19
  end

  def to_atom(0x14, :openflow_basic) do
    openflow_basic_to_atom(0x14)
  catch
    _class, _reason -> 20
  end

  def to_atom(0x15, :openflow_basic) do
    openflow_basic_to_atom(0x15)
  catch
    _class, _reason -> 21
  end

  def to_atom(0x16, :openflow_basic) do
    openflow_basic_to_atom(0x16)
  catch
    _class, _reason -> 22
  end

  def to_atom(0x17, :openflow_basic) do
    openflow_basic_to_atom(0x17)
  catch
    _class, _reason -> 23
  end

  def to_atom(0x18, :openflow_basic) do
    openflow_basic_to_atom(0x18)
  catch
    _class, _reason -> 24
  end

  def to_atom(0x19, :openflow_basic) do
    openflow_basic_to_atom(0x19)
  catch
    _class, _reason -> 25
  end

  def to_atom(0x1A, :openflow_basic) do
    openflow_basic_to_atom(0x1A)
  catch
    _class, _reason -> 26
  end

  def to_atom(0x1B, :openflow_basic) do
    openflow_basic_to_atom(0x1B)
  catch
    _class, _reason -> 27
  end

  def to_atom(0x1C, :openflow_basic) do
    openflow_basic_to_atom(0x1C)
  catch
    _class, _reason -> 28
  end

  def to_atom(0x1D, :openflow_basic) do
    openflow_basic_to_atom(0x1D)
  catch
    _class, _reason -> 29
  end

  def to_atom(0x1E, :openflow_basic) do
    openflow_basic_to_atom(0x1E)
  catch
    _class, _reason -> 30
  end

  def to_atom(0x1F, :openflow_basic) do
    openflow_basic_to_atom(0x1F)
  catch
    _class, _reason -> 31
  end

  def to_atom(0x20, :openflow_basic) do
    openflow_basic_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x21, :openflow_basic) do
    openflow_basic_to_atom(0x21)
  catch
    _class, _reason -> 33
  end

  def to_atom(0x22, :openflow_basic) do
    openflow_basic_to_atom(0x22)
  catch
    _class, _reason -> 34
  end

  def to_atom(0x23, :openflow_basic) do
    openflow_basic_to_atom(0x23)
  catch
    _class, _reason -> 35
  end

  def to_atom(0x24, :openflow_basic) do
    openflow_basic_to_atom(0x24)
  catch
    _class, _reason -> 36
  end

  def to_atom(0x25, :openflow_basic) do
    openflow_basic_to_atom(0x25)
  catch
    _class, _reason -> 37
  end

  def to_atom(0x26, :openflow_basic) do
    openflow_basic_to_atom(0x26)
  catch
    _class, _reason -> 38
  end

  def to_atom(0x27, :openflow_basic) do
    openflow_basic_to_atom(0x27)
  catch
    _class, _reason -> 39
  end

  def to_atom(0x29, :openflow_basic) do
    openflow_basic_to_atom(0x29)
  catch
    _class, _reason -> 41
  end

  def to_atom(0x2A, :openflow_basic) do
    openflow_basic_to_atom(0x2A)
  catch
    _class, _reason -> 42
  end

  def to_atom(0x2B, :openflow_basic) do
    openflow_basic_to_atom(0x2B)
  catch
    _class, _reason -> 43
  end

  def to_atom(0x2C, :openflow_basic) do
    openflow_basic_to_atom(0x2C)
  catch
    _class, _reason -> 44
  end

  def to_atom(0x2D, :openflow_basic) do
    openflow_basic_to_atom(0x2D)
  catch
    _class, _reason -> 45
  end

  def to_atom(0x2E, :openflow_basic) do
    openflow_basic_to_atom(0x2E)
  catch
    _class, _reason -> 46
  end

  def to_atom(0x2F, :openflow_basic) do
    openflow_basic_to_atom(0x2F)
  catch
    _class, _reason -> 47
  end

  def to_atom(0x30, :openflow_basic) do
    openflow_basic_to_atom(0x30)
  catch
    _class, _reason -> 48
  end

  def to_atom(0x31, :openflow_basic) do
    openflow_basic_to_atom(0x31)
  catch
    _class, _reason -> 49
  end

  def to_atom(0x32, :openflow_basic) do
    openflow_basic_to_atom(0x32)
  catch
    _class, _reason -> 50
  end

  def to_atom(0x33, :openflow_basic) do
    openflow_basic_to_atom(0x33)
  catch
    _class, _reason -> 51
  end

  def to_atom(0x34, :openflow_basic) do
    openflow_basic_to_atom(0x34)
  catch
    _class, _reason -> 52
  end

  def to_atom(0x35, :openflow_basic) do
    openflow_basic_to_atom(0x35)
  catch
    _class, _reason -> 53
  end

  def to_atom(0x36, :openflow_basic) do
    openflow_basic_to_atom(0x36)
  catch
    _class, _reason -> 54
  end

  def to_atom(0x37, :openflow_basic) do
    openflow_basic_to_atom(0x37)
  catch
    _class, _reason -> 55
  end

  def to_atom(0x38, :openflow_basic) do
    openflow_basic_to_atom(0x38)
  catch
    _class, _reason -> 56
  end

  def to_atom(0x39, :openflow_basic) do
    openflow_basic_to_atom(0x39)
  catch
    _class, _reason -> 57
  end

  def to_atom(0x3A, :openflow_basic) do
    openflow_basic_to_atom(0x3A)
  catch
    _class, _reason -> 58
  end

  def to_atom(0x3B, :openflow_basic) do
    openflow_basic_to_atom(0x3B)
  catch
    _class, _reason -> 59
  end

  def to_atom(0x3C, :openflow_basic) do
    openflow_basic_to_atom(0x3C)
  catch
    _class, _reason -> 60
  end

  def to_atom(0x3D, :openflow_basic) do
    openflow_basic_to_atom(0x3D)
  catch
    _class, _reason -> 61
  end

  def to_atom(0x3E, :openflow_basic) do
    openflow_basic_to_atom(0x3E)
  catch
    _class, _reason -> 62
  end

  def to_atom(0x3F, :openflow_basic) do
    openflow_basic_to_atom(0x3F)
  catch
    _class, _reason -> 63
  end

  def to_atom(0x40, :openflow_basic) do
    openflow_basic_to_atom(0x40)
  catch
    _class, _reason -> 64
  end

  def to_atom(0x41, :openflow_basic) do
    openflow_basic_to_atom(0x41)
  catch
    _class, _reason -> 65
  end

  def to_atom(0x42, :openflow_basic) do
    openflow_basic_to_atom(0x42)
  catch
    _class, _reason -> 66
  end

  def to_atom(0x43, :openflow_basic) do
    openflow_basic_to_atom(0x43)
  catch
    _class, _reason -> 67
  end

  def to_atom(_, :openflow_basic) do
    throw(:bad_enum)
  end

  def to_atom(0x1000, :vlan_id) do
    vlan_id_to_atom(0x1000)
  catch
    _class, _reason -> 4096
  end

  def to_atom(0x0, :vlan_id) do
    vlan_id_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(_, :vlan_id) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x20, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x40, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x40)
  catch
    _class, _reason -> 64
  end

  def to_atom(0x80, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x80)
  catch
    _class, _reason -> 128
  end

  def to_atom(0x100, :ipv6exthdr_flags) do
    ipv6exthdr_flags_to_atom(0x100)
  catch
    _class, _reason -> 256
  end

  def to_atom(_, :ipv6exthdr_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :tcp_flags) do
    tcp_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :tcp_flags) do
    tcp_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :tcp_flags) do
    tcp_flags_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :tcp_flags) do
    tcp_flags_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :tcp_flags) do
    tcp_flags_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x20, :tcp_flags) do
    tcp_flags_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x40, :tcp_flags) do
    tcp_flags_to_atom(0x40)
  catch
    _class, _reason -> 64
  end

  def to_atom(0x80, :tcp_flags) do
    tcp_flags_to_atom(0x80)
  catch
    _class, _reason -> 128
  end

  def to_atom(0x100, :tcp_flags) do
    tcp_flags_to_atom(0x100)
  catch
    _class, _reason -> 256
  end

  def to_atom(_, :tcp_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :ct_state_flags) do
    ct_state_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :ct_state_flags) do
    ct_state_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :ct_state_flags) do
    ct_state_flags_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :ct_state_flags) do
    ct_state_flags_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :ct_state_flags) do
    ct_state_flags_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x20, :ct_state_flags) do
    ct_state_flags_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x40, :ct_state_flags) do
    ct_state_flags_to_atom(0x40)
  catch
    _class, _reason -> 64
  end

  def to_atom(0x80, :ct_state_flags) do
    ct_state_flags_to_atom(0x80)
  catch
    _class, _reason -> 128
  end

  def to_atom(_, :ct_state_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :packet_register) do
    packet_register_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :packet_register) do
    packet_register_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :packet_register) do
    packet_register_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :packet_register) do
    packet_register_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :packet_register) do
    packet_register_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :packet_register) do
    packet_register_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :packet_register) do
    packet_register_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :packet_register) do
    packet_register_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(_, :packet_register) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :nicira_ext_match) do
    nicira_ext_match_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(_, :nicira_ext_match) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :hp_ext_match) do
    hp_ext_match_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :hp_ext_match) do
    hp_ext_match_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :hp_ext_match) do
    hp_ext_match_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :hp_ext_match) do
    hp_ext_match_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :hp_ext_match) do
    hp_ext_match_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :hp_ext_match) do
    hp_ext_match_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :hp_ext_match) do
    hp_ext_match_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :hp_ext_match) do
    hp_ext_match_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :hp_ext_match) do
    hp_ext_match_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(_, :hp_ext_match) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :hp_custom_match_type) do
    hp_custom_match_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :hp_custom_match_type) do
    hp_custom_match_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :hp_custom_match_type) do
    hp_custom_match_type_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(_, :hp_custom_match_type) do
    throw(:bad_enum)
  end

  def to_atom(0x2A, :onf_ext_match) do
    onf_ext_match_to_atom(0x2A)
  catch
    _class, _reason -> 42
  end

  def to_atom(0x2B, :onf_ext_match) do
    onf_ext_match_to_atom(0x2B)
  catch
    _class, _reason -> 43
  end

  def to_atom(0xA00, :onf_ext_match) do
    onf_ext_match_to_atom(0xA00)
  catch
    _class, _reason -> 2560
  end

  def to_atom(_, :onf_ext_match) do
    throw(:bad_enum)
  end

  def to_atom(0xFFFFFFFF, :buffer_id) do
    buffer_id_to_atom(0xFFFFFFFF)
  catch
    _class, _reason -> 4_294_967_295
  end

  def to_atom(_, :buffer_id) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :port_config) do
    port_config_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x4, :port_config) do
    port_config_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x20, :port_config) do
    port_config_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x40, :port_config) do
    port_config_to_atom(0x40)
  catch
    _class, _reason -> 64
  end

  def to_atom(_, :port_config) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :port_state) do
    port_state_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :port_state) do
    port_state_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :port_state) do
    port_state_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(_, :port_state) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :port_features) do
    port_features_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :port_features) do
    port_features_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :port_features) do
    port_features_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :port_features) do
    port_features_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :port_features) do
    port_features_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x20, :port_features) do
    port_features_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x40, :port_features) do
    port_features_to_atom(0x40)
  catch
    _class, _reason -> 64
  end

  def to_atom(0x80, :port_features) do
    port_features_to_atom(0x80)
  catch
    _class, _reason -> 128
  end

  def to_atom(0x100, :port_features) do
    port_features_to_atom(0x100)
  catch
    _class, _reason -> 256
  end

  def to_atom(0x200, :port_features) do
    port_features_to_atom(0x200)
  catch
    _class, _reason -> 512
  end

  def to_atom(0x400, :port_features) do
    port_features_to_atom(0x400)
  catch
    _class, _reason -> 1024
  end

  def to_atom(0x800, :port_features) do
    port_features_to_atom(0x800)
  catch
    _class, _reason -> 2048
  end

  def to_atom(0x1000, :port_features) do
    port_features_to_atom(0x1000)
  catch
    _class, _reason -> 4096
  end

  def to_atom(0x2000, :port_features) do
    port_features_to_atom(0x2000)
  catch
    _class, _reason -> 8192
  end

  def to_atom(0x4000, :port_features) do
    port_features_to_atom(0x4000)
  catch
    _class, _reason -> 16384
  end

  def to_atom(0x8000, :port_features) do
    port_features_to_atom(0x8000)
  catch
    _class, _reason -> 32768
  end

  def to_atom(_, :port_features) do
    throw(:bad_enum)
  end

  def to_atom(0xFF00, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFF00)
  catch
    _class, _reason -> 65280
  end

  def to_atom(0xFFF8, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFFF8)
  catch
    _class, _reason -> 65528
  end

  def to_atom(0xFFF9, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFFF9)
  catch
    _class, _reason -> 65529
  end

  def to_atom(0xFFFA, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFFFA)
  catch
    _class, _reason -> 65530
  end

  def to_atom(0xFFFB, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFFFB)
  catch
    _class, _reason -> 65531
  end

  def to_atom(0xFFFC, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFFFC)
  catch
    _class, _reason -> 65532
  end

  def to_atom(0xFFFD, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFFFD)
  catch
    _class, _reason -> 65533
  end

  def to_atom(0xFFFE, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFFFE)
  catch
    _class, _reason -> 65534
  end

  def to_atom(0xFFFF, :openflow10_port_no) do
    openflow10_port_no_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :openflow10_port_no) do
    throw(:bad_enum)
  end

  def to_atom(0xFFFFFF00, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFF00)
  catch
    _class, _reason -> 4_294_967_040
  end

  def to_atom(0xFFFFFFF8, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFFF8)
  catch
    _class, _reason -> 4_294_967_288
  end

  def to_atom(0xFFFFFFF9, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFFF9)
  catch
    _class, _reason -> 4_294_967_289
  end

  def to_atom(0xFFFFFFFA, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFFFA)
  catch
    _class, _reason -> 4_294_967_290
  end

  def to_atom(0xFFFFFFFB, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFFFB)
  catch
    _class, _reason -> 4_294_967_291
  end

  def to_atom(0xFFFFFFFC, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFFFC)
  catch
    _class, _reason -> 4_294_967_292
  end

  def to_atom(0xFFFFFFFD, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFFFD)
  catch
    _class, _reason -> 4_294_967_293
  end

  def to_atom(0xFFFFFFFE, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFFFE)
  catch
    _class, _reason -> 4_294_967_294
  end

  def to_atom(0xFFFFFFFF, :openflow13_port_no) do
    openflow13_port_no_to_atom(0xFFFFFFFF)
  catch
    _class, _reason -> 4_294_967_295
  end

  def to_atom(_, :openflow13_port_no) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :packet_in_reason) do
    packet_in_reason_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :packet_in_reason) do
    packet_in_reason_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :packet_in_reason) do
    packet_in_reason_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :packet_in_reason) do
    packet_in_reason_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :packet_in_reason) do
    packet_in_reason_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :packet_in_reason) do
    packet_in_reason_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(_, :packet_in_reason) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :packet_in_reason_mask) do
    packet_in_reason_mask_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :packet_in_reason_mask) do
    packet_in_reason_mask_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :packet_in_reason_mask) do
    packet_in_reason_mask_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :packet_in_reason_mask) do
    packet_in_reason_mask_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :packet_in_reason_mask) do
    packet_in_reason_mask_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x20, :packet_in_reason_mask) do
    packet_in_reason_mask_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(_, :packet_in_reason_mask) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :flow_mod_command) do
    flow_mod_command_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :flow_mod_command) do
    flow_mod_command_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :flow_mod_command) do
    flow_mod_command_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :flow_mod_command) do
    flow_mod_command_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :flow_mod_command) do
    flow_mod_command_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(_, :flow_mod_command) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :flow_mod_flags) do
    flow_mod_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :flow_mod_flags) do
    flow_mod_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :flow_mod_flags) do
    flow_mod_flags_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :flow_mod_flags) do
    flow_mod_flags_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :flow_mod_flags) do
    flow_mod_flags_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(_, :flow_mod_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :flow_removed_reason) do
    flow_removed_reason_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :flow_removed_reason) do
    flow_removed_reason_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :flow_removed_reason) do
    flow_removed_reason_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :flow_removed_reason) do
    flow_removed_reason_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :flow_removed_reason) do
    flow_removed_reason_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :flow_removed_reason) do
    flow_removed_reason_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(_, :flow_removed_reason) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x20, :flow_removed_reason_mask) do
    flow_removed_reason_mask_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(_, :flow_removed_reason_mask) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :port_reason) do
    port_reason_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :port_reason) do
    port_reason_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :port_reason) do
    port_reason_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :port_reason) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :port_reason_mask) do
    port_reason_mask_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :port_reason_mask) do
    port_reason_mask_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :port_reason_mask) do
    port_reason_mask_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(_, :port_reason_mask) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :group_mod_command) do
    group_mod_command_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :group_mod_command) do
    group_mod_command_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :group_mod_command) do
    group_mod_command_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :group_mod_command) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :group_type) do
    group_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :group_type) do
    group_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :group_type) do
    group_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :group_type) do
    group_type_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(_, :group_type) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :group_type_flags) do
    group_type_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :group_type_flags) do
    group_type_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :group_type_flags) do
    group_type_flags_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :group_type_flags) do
    group_type_flags_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(_, :group_type_flags) do
    throw(:bad_enum)
  end

  def to_atom(0xFFFFFF00, :group_id) do
    group_id_to_atom(0xFFFFFF00)
  catch
    _class, _reason -> 4_294_967_040
  end

  def to_atom(0xFFFFFFFC, :group_id) do
    group_id_to_atom(0xFFFFFFFC)
  catch
    _class, _reason -> 4_294_967_292
  end

  def to_atom(0xFFFFFFFF, :group_id) do
    group_id_to_atom(0xFFFFFFFF)
  catch
    _class, _reason -> 4_294_967_295
  end

  def to_atom(_, :group_id) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :group_capabilities) do
    group_capabilities_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :group_capabilities) do
    group_capabilities_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :group_capabilities) do
    group_capabilities_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :group_capabilities) do
    group_capabilities_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(_, :group_capabilities) do
    throw(:bad_enum)
  end

  def to_atom(0xFE, :table_id) do
    table_id_to_atom(0xFE)
  catch
    _class, _reason -> 254
  end

  def to_atom(0xFF, :table_id) do
    table_id_to_atom(0xFF)
  catch
    _class, _reason -> 255
  end

  def to_atom(_, :table_id) do
    throw(:bad_enum)
  end

  def to_atom(0xFFFFFFFF, :queue_id) do
    queue_id_to_atom(0xFFFFFFFF)
  catch
    _class, _reason -> 4_294_967_295
  end

  def to_atom(_, :queue_id) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :meter_mod_command) do
    meter_mod_command_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :meter_mod_command) do
    meter_mod_command_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :meter_mod_command) do
    meter_mod_command_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :meter_mod_command) do
    throw(:bad_enum)
  end

  def to_atom(0xFFFF0000, :meter_id) do
    meter_id_to_atom(0xFFFF0000)
  catch
    _class, _reason -> 4_294_901_760
  end

  def to_atom(0xFFFFFFFD, :meter_id) do
    meter_id_to_atom(0xFFFFFFFD)
  catch
    _class, _reason -> 4_294_967_293
  end

  def to_atom(0xFFFFFFFE, :meter_id) do
    meter_id_to_atom(0xFFFFFFFE)
  catch
    _class, _reason -> 4_294_967_294
  end

  def to_atom(0xFFFFFFFF, :meter_id) do
    meter_id_to_atom(0xFFFFFFFF)
  catch
    _class, _reason -> 4_294_967_295
  end

  def to_atom(_, :meter_id) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :meter_flags) do
    meter_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :meter_flags) do
    meter_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :meter_flags) do
    meter_flags_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :meter_flags) do
    meter_flags_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(_, :meter_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :meter_band_type) do
    meter_band_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :meter_band_type) do
    meter_band_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0xFFFF, :meter_band_type) do
    meter_band_type_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :meter_band_type) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :table_config) do
    table_config_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :table_config) do
    table_config_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :table_config) do
    table_config_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :table_config) do
    table_config_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :table_config) do
    table_config_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :table_config) do
    table_config_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(_, :table_config) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :action_type) do
    action_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0xB, :action_type) do
    action_type_to_atom(0xB)
  catch
    _class, _reason -> 11
  end

  def to_atom(0xC, :action_type) do
    action_type_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xF, :action_type) do
    action_type_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x10, :action_type) do
    action_type_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x11, :action_type) do
    action_type_to_atom(0x11)
  catch
    _class, _reason -> 17
  end

  def to_atom(0x12, :action_type) do
    action_type_to_atom(0x12)
  catch
    _class, _reason -> 18
  end

  def to_atom(0x13, :action_type) do
    action_type_to_atom(0x13)
  catch
    _class, _reason -> 19
  end

  def to_atom(0x14, :action_type) do
    action_type_to_atom(0x14)
  catch
    _class, _reason -> 20
  end

  def to_atom(0x15, :action_type) do
    action_type_to_atom(0x15)
  catch
    _class, _reason -> 21
  end

  def to_atom(0x16, :action_type) do
    action_type_to_atom(0x16)
  catch
    _class, _reason -> 22
  end

  def to_atom(0x17, :action_type) do
    action_type_to_atom(0x17)
  catch
    _class, _reason -> 23
  end

  def to_atom(0x18, :action_type) do
    action_type_to_atom(0x18)
  catch
    _class, _reason -> 24
  end

  def to_atom(0x19, :action_type) do
    action_type_to_atom(0x19)
  catch
    _class, _reason -> 25
  end

  def to_atom(0x1A, :action_type) do
    action_type_to_atom(0x1A)
  catch
    _class, _reason -> 26
  end

  def to_atom(0x1B, :action_type) do
    action_type_to_atom(0x1B)
  catch
    _class, _reason -> 27
  end

  def to_atom(0x1C, :action_type) do
    action_type_to_atom(0x1C)
  catch
    _class, _reason -> 28
  end

  def to_atom(0x1D, :action_type) do
    action_type_to_atom(0x1D)
  catch
    _class, _reason -> 29
  end

  def to_atom(0x1E, :action_type) do
    action_type_to_atom(0x1E)
  catch
    _class, _reason -> 30
  end

  def to_atom(0x1F, :action_type) do
    action_type_to_atom(0x1F)
  catch
    _class, _reason -> 31
  end

  def to_atom(0xFFFF, :action_type) do
    action_type_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :action_type) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :action_flags) do
    action_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x800, :action_flags) do
    action_flags_to_atom(0x800)
  catch
    _class, _reason -> 2048
  end

  def to_atom(0x1000, :action_flags) do
    action_flags_to_atom(0x1000)
  catch
    _class, _reason -> 4096
  end

  def to_atom(0x8000, :action_flags) do
    action_flags_to_atom(0x8000)
  catch
    _class, _reason -> 32768
  end

  def to_atom(0x10000, :action_flags) do
    action_flags_to_atom(0x10000)
  catch
    _class, _reason -> 65536
  end

  def to_atom(0x20000, :action_flags) do
    action_flags_to_atom(0x20000)
  catch
    _class, _reason -> 131_072
  end

  def to_atom(0x40000, :action_flags) do
    action_flags_to_atom(0x40000)
  catch
    _class, _reason -> 262_144
  end

  def to_atom(0x80000, :action_flags) do
    action_flags_to_atom(0x80000)
  catch
    _class, _reason -> 524_288
  end

  def to_atom(0x100000, :action_flags) do
    action_flags_to_atom(0x100000)
  catch
    _class, _reason -> 1_048_576
  end

  def to_atom(0x200000, :action_flags) do
    action_flags_to_atom(0x200000)
  catch
    _class, _reason -> 2_097_152
  end

  def to_atom(0x400000, :action_flags) do
    action_flags_to_atom(0x400000)
  catch
    _class, _reason -> 4_194_304
  end

  def to_atom(0x800000, :action_flags) do
    action_flags_to_atom(0x800000)
  catch
    _class, _reason -> 8_388_608
  end

  def to_atom(0x1000000, :action_flags) do
    action_flags_to_atom(0x1000000)
  catch
    _class, _reason -> 16_777_216
  end

  def to_atom(0x2000000, :action_flags) do
    action_flags_to_atom(0x2000000)
  catch
    _class, _reason -> 33_554_432
  end

  def to_atom(0x4000000, :action_flags) do
    action_flags_to_atom(0x4000000)
  catch
    _class, _reason -> 67_108_864
  end

  def to_atom(0x8000000, :action_flags) do
    action_flags_to_atom(0x8000000)
  catch
    _class, _reason -> 134_217_728
  end

  def to_atom(0x10000000, :action_flags) do
    action_flags_to_atom(0x10000000)
  catch
    _class, _reason -> 268_435_456
  end

  def to_atom(0x20000000, :action_flags) do
    action_flags_to_atom(0x20000000)
  catch
    _class, _reason -> 536_870_912
  end

  def to_atom(0x40000000, :action_flags) do
    action_flags_to_atom(0x40000000)
  catch
    _class, _reason -> 1_073_741_824
  end

  def to_atom(0x80000000, :action_flags) do
    action_flags_to_atom(0x80000000)
  catch
    _class, _reason -> 2_147_483_648
  end

  def to_atom(0xFFFF, :action_flags) do
    action_flags_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :action_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x2320, :action_vendor) do
    action_vendor_to_atom(0x2320)
  catch
    _class, _reason -> 8992
  end

  def to_atom(0x4F4E4600, :action_vendor) do
    action_vendor_to_atom(0x4F4E4600)
  catch
    _class, _reason -> 1_330_529_792
  end

  def to_atom(_, :action_vendor) do
    throw(:bad_enum)
  end

  def to_atom(0xC80, :onf_ext_action) do
    onf_ext_action_to_atom(0xC80)
  catch
    _class, _reason -> 3200
  end

  def to_atom(_, :onf_ext_action) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x6, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x9, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x9)
  catch
    _class, _reason -> 9
  end

  def to_atom(0xA, :nicira_ext_action) do
    nicira_ext_action_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xC, :nicira_ext_action) do
    nicira_ext_action_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :nicira_ext_action) do
    nicira_ext_action_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :nicira_ext_action) do
    nicira_ext_action_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :nicira_ext_action) do
    nicira_ext_action_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0x10, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x11, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x11)
  catch
    _class, _reason -> 17
  end

  def to_atom(0x12, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x12)
  catch
    _class, _reason -> 18
  end

  def to_atom(0x13, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x13)
  catch
    _class, _reason -> 19
  end

  def to_atom(0x14, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x14)
  catch
    _class, _reason -> 20
  end

  def to_atom(0x15, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x15)
  catch
    _class, _reason -> 21
  end

  def to_atom(0x16, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x16)
  catch
    _class, _reason -> 22
  end

  def to_atom(0x1B, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x1B)
  catch
    _class, _reason -> 27
  end

  def to_atom(0x1C, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x1C)
  catch
    _class, _reason -> 28
  end

  def to_atom(0x1D, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x1D)
  catch
    _class, _reason -> 29
  end

  def to_atom(0x20, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(0x21, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x21)
  catch
    _class, _reason -> 33
  end

  def to_atom(0x22, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x22)
  catch
    _class, _reason -> 34
  end

  def to_atom(0x23, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x23)
  catch
    _class, _reason -> 35
  end

  def to_atom(0x24, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x24)
  catch
    _class, _reason -> 36
  end

  def to_atom(0x25, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x25)
  catch
    _class, _reason -> 37
  end

  def to_atom(0x26, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x26)
  catch
    _class, _reason -> 38
  end

  def to_atom(0x27, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x27)
  catch
    _class, _reason -> 39
  end

  def to_atom(0x28, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x28)
  catch
    _class, _reason -> 40
  end

  def to_atom(0x29, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x29)
  catch
    _class, _reason -> 41
  end

  def to_atom(0x2A, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x2A)
  catch
    _class, _reason -> 42
  end

  def to_atom(0x2B, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x2B)
  catch
    _class, _reason -> 43
  end

  def to_atom(0x2C, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x2C)
  catch
    _class, _reason -> 44
  end

  def to_atom(0x2D, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x2D)
  catch
    _class, _reason -> 45
  end

  def to_atom(0x2E, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x2E)
  catch
    _class, _reason -> 46
  end

  def to_atom(0x2F, :nicira_ext_action) do
    nicira_ext_action_to_atom(0x2F)
  catch
    _class, _reason -> 47
  end

  def to_atom(0xFF, :nicira_ext_action) do
    nicira_ext_action_to_atom(0xFF)
  catch
    _class, _reason -> 255
  end

  def to_atom(_, :nicira_ext_action) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nx_mp_algorithm) do
    nx_mp_algorithm_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nx_mp_algorithm) do
    nx_mp_algorithm_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_mp_algorithm) do
    nx_mp_algorithm_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :nx_mp_algorithm) do
    nx_mp_algorithm_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(_, :nx_mp_algorithm) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nx_hash_fields) do
    nx_hash_fields_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nx_hash_fields) do
    nx_hash_fields_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_hash_fields) do
    nx_hash_fields_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :nx_hash_fields) do
    nx_hash_fields_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :nx_hash_fields) do
    nx_hash_fields_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :nx_hash_fields) do
    nx_hash_fields_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(_, :nx_hash_fields) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nx_bd_algorithm) do
    nx_bd_algorithm_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nx_bd_algorithm) do
    nx_bd_algorithm_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(_, :nx_bd_algorithm) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :nx_learn_flag) do
    nx_learn_flag_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_learn_flag) do
    nx_learn_flag_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :nx_learn_flag) do
    nx_learn_flag_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(_, :nx_learn_flag) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :nx_conntrack_flags) do
    nx_conntrack_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_conntrack_flags) do
    nx_conntrack_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :nx_conntrack_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :nx_nat_flags) do
    nx_nat_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_nat_flags) do
    nx_nat_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :nx_nat_flags) do
    nx_nat_flags_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :nx_nat_flags) do
    nx_nat_flags_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :nx_nat_flags) do
    nx_nat_flags_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(_, :nx_nat_flags) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :nx_nat_range) do
    nx_nat_range_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_nat_range) do
    nx_nat_range_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :nx_nat_range) do
    nx_nat_range_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :nx_nat_range) do
    nx_nat_range_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :nx_nat_range) do
    nx_nat_range_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x20, :nx_nat_range) do
    nx_nat_range_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(_, :nx_nat_range) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :nx_action_controller2_prop_type) do
    nx_action_controller2_prop_type_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(_, :nx_action_controller2_prop_type) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nx_action_sample_direction) do
    nx_action_sample_direction_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nx_action_sample_direction) do
    nx_action_sample_direction_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_action_sample_direction) do
    nx_action_sample_direction_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :nx_action_sample_direction) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nx_flow_spec_type) do
    nx_flow_spec_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nx_flow_spec_type) do
    nx_flow_spec_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_flow_spec_type) do
    nx_flow_spec_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :nx_flow_spec_type) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :instruction_type) do
    instruction_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :instruction_type) do
    instruction_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :instruction_type) do
    instruction_type_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :instruction_type) do
    instruction_type_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :instruction_type) do
    instruction_type_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :instruction_type) do
    instruction_type_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0xFFFF, :instruction_type) do
    instruction_type_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :instruction_type) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :controller_role) do
    controller_role_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :controller_role) do
    controller_role_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :controller_role) do
    controller_role_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :controller_role) do
    controller_role_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(_, :controller_role) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :nx_role) do
    nx_role_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :nx_role) do
    nx_role_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :nx_role) do
    nx_role_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :nx_role) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :packet_in_format) do
    packet_in_format_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :packet_in_format) do
    packet_in_format_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :packet_in_format) do
    packet_in_format_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :packet_in_format) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :flow_format) do
    flow_format_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :flow_format) do
    flow_format_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(_, :flow_format) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :packet_in2_prop_type) do
    packet_in2_prop_type_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(_, :packet_in2_prop_type) do
    throw(:bad_enum)
  end

  def to_atom(0x8000, :continuation_prop_type) do
    continuation_prop_type_to_atom(0x8000)
  catch
    _class, _reason -> 32768
  end

  def to_atom(0x8001, :continuation_prop_type) do
    continuation_prop_type_to_atom(0x8001)
  catch
    _class, _reason -> 32769
  end

  def to_atom(0x8002, :continuation_prop_type) do
    continuation_prop_type_to_atom(0x8002)
  catch
    _class, _reason -> 32770
  end

  def to_atom(0x8003, :continuation_prop_type) do
    continuation_prop_type_to_atom(0x8003)
  catch
    _class, _reason -> 32771
  end

  def to_atom(0x8004, :continuation_prop_type) do
    continuation_prop_type_to_atom(0x8004)
  catch
    _class, _reason -> 32772
  end

  def to_atom(0x8005, :continuation_prop_type) do
    continuation_prop_type_to_atom(0x8005)
  catch
    _class, _reason -> 32773
  end

  def to_atom(0x8006, :continuation_prop_type) do
    continuation_prop_type_to_atom(0x8006)
  catch
    _class, _reason -> 32774
  end

  def to_atom(0x8007, :continuation_prop_type) do
    continuation_prop_type_to_atom(0x8007)
  catch
    _class, _reason -> 32775
  end

  def to_atom(_, :continuation_prop_type) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :flow_monitor_flag) do
    flow_monitor_flag_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :flow_monitor_flag) do
    flow_monitor_flag_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x4, :flow_monitor_flag) do
    flow_monitor_flag_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x8, :flow_monitor_flag) do
    flow_monitor_flag_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0x10, :flow_monitor_flag) do
    flow_monitor_flag_to_atom(0x10)
  catch
    _class, _reason -> 16
  end

  def to_atom(0x20, :flow_monitor_flag) do
    flow_monitor_flag_to_atom(0x20)
  catch
    _class, _reason -> 32
  end

  def to_atom(_, :flow_monitor_flag) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :flow_update_event) do
    flow_update_event_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :flow_update_event) do
    flow_update_event_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :flow_update_event) do
    flow_update_event_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :flow_update_event) do
    flow_update_event_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(_, :flow_update_event) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :tlv_table_mod_command) do
    tlv_table_mod_command_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :tlv_table_mod_command) do
    tlv_table_mod_command_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :tlv_table_mod_command) do
    tlv_table_mod_command_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :tlv_table_mod_command) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(0x8, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0x8)
  catch
    _class, _reason -> 8
  end

  def to_atom(0xA, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0xA)
  catch
    _class, _reason -> 10
  end

  def to_atom(0xC, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0xC)
  catch
    _class, _reason -> 12
  end

  def to_atom(0xD, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0xD)
  catch
    _class, _reason -> 13
  end

  def to_atom(0xE, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0xE)
  catch
    _class, _reason -> 14
  end

  def to_atom(0xF, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0xF)
  catch
    _class, _reason -> 15
  end

  def to_atom(0xFFFE, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0xFFFE)
  catch
    _class, _reason -> 65534
  end

  def to_atom(0xFFFF, :table_feature_prop_type) do
    table_feature_prop_type_to_atom(0xFFFF)
  catch
    _class, _reason -> 65535
  end

  def to_atom(_, :table_feature_prop_type) do
    throw(:bad_enum)
  end

  def to_atom(0x0, :bundle_ctrl_type) do
    bundle_ctrl_type_to_atom(0x0)
  catch
    _class, _reason -> 0
  end

  def to_atom(0x1, :bundle_ctrl_type) do
    bundle_ctrl_type_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :bundle_ctrl_type) do
    bundle_ctrl_type_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(0x3, :bundle_ctrl_type) do
    bundle_ctrl_type_to_atom(0x3)
  catch
    _class, _reason -> 3
  end

  def to_atom(0x4, :bundle_ctrl_type) do
    bundle_ctrl_type_to_atom(0x4)
  catch
    _class, _reason -> 4
  end

  def to_atom(0x5, :bundle_ctrl_type) do
    bundle_ctrl_type_to_atom(0x5)
  catch
    _class, _reason -> 5
  end

  def to_atom(0x6, :bundle_ctrl_type) do
    bundle_ctrl_type_to_atom(0x6)
  catch
    _class, _reason -> 6
  end

  def to_atom(0x7, :bundle_ctrl_type) do
    bundle_ctrl_type_to_atom(0x7)
  catch
    _class, _reason -> 7
  end

  def to_atom(_, :bundle_ctrl_type) do
    throw(:bad_enum)
  end

  def to_atom(0x1, :bundle_flags) do
    bundle_flags_to_atom(0x1)
  catch
    _class, _reason -> 1
  end

  def to_atom(0x2, :bundle_flags) do
    bundle_flags_to_atom(0x2)
  catch
    _class, _reason -> 2
  end

  def to_atom(_, :bundle_flags) do
    throw(:bad_enum)
  end

  def openflow_codec_to_int(Openflow.Hello), do: 0x0
  def openflow_codec_to_int(Openflow.ErrorMsg), do: 0x1
  def openflow_codec_to_int(Openflow.Echo.Request), do: 0x2
  def openflow_codec_to_int(Openflow.Echo.Reply), do: 0x3
  def openflow_codec_to_int(Openflow.Experimenter), do: 0x4
  def openflow_codec_to_int(Openflow.Features.Request), do: 0x5
  def openflow_codec_to_int(Openflow.Features.Reply), do: 0x6
  def openflow_codec_to_int(Openflow.GetConfig.Request), do: 0x7
  def openflow_codec_to_int(Openflow.GetConfig.Reply), do: 0x8
  def openflow_codec_to_int(Openflow.SetConfig), do: 0x9
  def openflow_codec_to_int(Openflow.PacketIn), do: 0xA
  def openflow_codec_to_int(Openflow.FlowRemoved), do: 0xB
  def openflow_codec_to_int(Openflow.PortStatus), do: 0xC
  def openflow_codec_to_int(Openflow.PacketOut), do: 0xD
  def openflow_codec_to_int(Openflow.FlowMod), do: 0xE
  def openflow_codec_to_int(Openflow.GroupMod), do: 0xF
  def openflow_codec_to_int(Openflow.PortMod), do: 0x10
  def openflow_codec_to_int(Openflow.TableMod), do: 0x11
  def openflow_codec_to_int(Openflow.Multipart.Request), do: 0x12
  def openflow_codec_to_int(Openflow.Multipart.Reply), do: 0x13
  def openflow_codec_to_int(Openflow.Barrier.Request), do: 0x14
  def openflow_codec_to_int(Openflow.Barrier.Reply), do: 0x15
  def openflow_codec_to_int(Openflow.Role.Request), do: 0x18
  def openflow_codec_to_int(Openflow.Role.Reply), do: 0x19
  def openflow_codec_to_int(Openflow.GetAsync.Request), do: 0x1A
  def openflow_codec_to_int(Openflow.GetAsync.Reply), do: 0x1B
  def openflow_codec_to_int(Openflow.SetAsync), do: 0x1C
  def openflow_codec_to_int(Openflow.MeterMod), do: 0x1D
  def openflow_codec_to_int(_), do: throw(:bad_enum)
  def openflow_codec_to_atom(0x0), do: Openflow.Hello
  def openflow_codec_to_atom(0x1), do: Openflow.ErrorMsg
  def openflow_codec_to_atom(0x2), do: Openflow.Echo.Request
  def openflow_codec_to_atom(0x3), do: Openflow.Echo.Reply
  def openflow_codec_to_atom(0x4), do: Openflow.Experimenter
  def openflow_codec_to_atom(0x5), do: Openflow.Features.Request
  def openflow_codec_to_atom(0x6), do: Openflow.Features.Reply
  def openflow_codec_to_atom(0x7), do: Openflow.GetConfig.Request
  def openflow_codec_to_atom(0x8), do: Openflow.GetConfig.Reply
  def openflow_codec_to_atom(0x9), do: Openflow.SetConfig
  def openflow_codec_to_atom(0xA), do: Openflow.PacketIn
  def openflow_codec_to_atom(0xB), do: Openflow.FlowRemoved
  def openflow_codec_to_atom(0xC), do: Openflow.PortStatus
  def openflow_codec_to_atom(0xD), do: Openflow.PacketOut
  def openflow_codec_to_atom(0xE), do: Openflow.FlowMod
  def openflow_codec_to_atom(0xF), do: Openflow.GroupMod
  def openflow_codec_to_atom(0x10), do: Openflow.PortMod
  def openflow_codec_to_atom(0x11), do: Openflow.TableMod
  def openflow_codec_to_atom(0x12), do: Openflow.Multipart.Request
  def openflow_codec_to_atom(0x13), do: Openflow.Multipart.Reply
  def openflow_codec_to_atom(0x14), do: Openflow.Barrier.Request
  def openflow_codec_to_atom(0x15), do: Openflow.Barrier.Reply
  def openflow_codec_to_atom(0x18), do: Openflow.Role.Request
  def openflow_codec_to_atom(0x19), do: Openflow.Role.Reply
  def openflow_codec_to_atom(0x1A), do: Openflow.GetAsync.Request
  def openflow_codec_to_atom(0x1B), do: Openflow.GetAsync.Reply
  def openflow_codec_to_atom(0x1C), do: Openflow.SetAsync
  def openflow_codec_to_atom(0x1D), do: Openflow.MeterMod
  def openflow_codec_to_atom(_), do: throw(:bad_enum)
  def experimenter_id_to_int(:nicira_ext_message), do: 0x2320
  def experimenter_id_to_int(:onf_ext_message), do: 0x4F4E4600
  def experimenter_id_to_int(_), do: throw(:bad_enum)
  def experimenter_id_to_atom(0x2320), do: :nicira_ext_message
  def experimenter_id_to_atom(0x4F4E4600), do: :onf_ext_message
  def experimenter_id_to_atom(_), do: throw(:bad_enum)
  def nicira_ext_message_to_int(Openflow.NxSetPacketInFormat), do: 0x10
  def nicira_ext_message_to_int(Openflow.NxSetControllerId), do: 0x14
  def nicira_ext_message_to_int(Openflow.NxFlowMonitor.Cancel), do: 0x15
  def nicira_ext_message_to_int(Openflow.NxFlowMonitor.Paused), do: 0x16
  def nicira_ext_message_to_int(Openflow.NxFlowMonitor.Resumed), do: 0x17
  def nicira_ext_message_to_int(Openflow.NxTLVTableMod), do: 0x18
  def nicira_ext_message_to_int(Openflow.NxTLVTable.Request), do: 0x19
  def nicira_ext_message_to_int(Openflow.NxTLVTable.Reply), do: 0x1A
  def nicira_ext_message_to_int(Openflow.NxSetAsyncConfig2), do: 0x1B
  def nicira_ext_message_to_int(Openflow.NxResume), do: 0x1C
  def nicira_ext_message_to_int(Openflow.NxCtFlushZone), do: 0x1D
  def nicira_ext_message_to_int(Openflow.NxPacketIn2), do: 0x1E
  def nicira_ext_message_to_int(_), do: throw(:bad_enum)
  def nicira_ext_message_to_atom(0x10), do: Openflow.NxSetPacketInFormat
  def nicira_ext_message_to_atom(0x14), do: Openflow.NxSetControllerId
  def nicira_ext_message_to_atom(0x15), do: Openflow.NxFlowMonitor.Cancel
  def nicira_ext_message_to_atom(0x16), do: Openflow.NxFlowMonitor.Paused
  def nicira_ext_message_to_atom(0x17), do: Openflow.NxFlowMonitor.Resumed
  def nicira_ext_message_to_atom(0x18), do: Openflow.NxTLVTableMod
  def nicira_ext_message_to_atom(0x19), do: Openflow.NxTLVTable.Request
  def nicira_ext_message_to_atom(0x1A), do: Openflow.NxTLVTable.Reply
  def nicira_ext_message_to_atom(0x1B), do: Openflow.NxSetAsyncConfig2
  def nicira_ext_message_to_atom(0x1C), do: Openflow.NxResume
  def nicira_ext_message_to_atom(0x1D), do: Openflow.NxCtFlushZone
  def nicira_ext_message_to_atom(0x1E), do: Openflow.NxPacketIn2
  def nicira_ext_message_to_atom(_), do: throw(:bad_enum)
  def onf_ext_message_to_int(Openflow.OnfBundleControl), do: 0x8FC
  def onf_ext_message_to_int(Openflow.OnfBundleAddMessage), do: 0x8FD
  def onf_ext_message_to_int(_), do: throw(:bad_enum)
  def onf_ext_message_to_atom(0x8FC), do: Openflow.OnfBundleControl
  def onf_ext_message_to_atom(0x8FD), do: Openflow.OnfBundleAddMessage
  def onf_ext_message_to_atom(_), do: throw(:bad_enum)
  def multipart_request_flags_to_int(:more), do: 0x1
  def multipart_request_flags_to_int(_), do: throw(:bad_enum)
  def multipart_request_flags_to_atom(0x1), do: :more
  def multipart_request_flags_to_atom(_), do: throw(:bad_enum)
  def multipart_reply_flags_to_int(:more), do: 0x1
  def multipart_reply_flags_to_int(_), do: throw(:bad_enum)
  def multipart_reply_flags_to_atom(0x1), do: :more
  def multipart_reply_flags_to_atom(_), do: throw(:bad_enum)
  def multipart_request_codec_to_int(Openflow.Multipart.Desc.Request), do: 0x0
  def multipart_request_codec_to_int(Openflow.Multipart.Flow.Request), do: 0x1
  def multipart_request_codec_to_int(Openflow.Multipart.Aggregate.Request), do: 0x2
  def multipart_request_codec_to_int(Openflow.Multipart.Table.Request), do: 0x3
  def multipart_request_codec_to_int(Openflow.Multipart.PortStats.Request), do: 0x4
  def multipart_request_codec_to_int(Openflow.Multipart.Queue.Request), do: 0x5
  def multipart_request_codec_to_int(Openflow.Multipart.Group.Request), do: 0x6
  def multipart_request_codec_to_int(Openflow.Multipart.GroupDesc.Request), do: 0x7
  def multipart_request_codec_to_int(Openflow.Multipart.GroupFeatures.Request), do: 0x8
  def multipart_request_codec_to_int(Openflow.Multipart.Meter.Request), do: 0x9
  def multipart_request_codec_to_int(Openflow.Multipart.MeterConfig.Request), do: 0xA
  def multipart_request_codec_to_int(Openflow.Multipart.MeterFeatures.Request), do: 0xB
  def multipart_request_codec_to_int(Openflow.Multipart.TableFeatures.Request), do: 0xC
  def multipart_request_codec_to_int(Openflow.Multipart.PortDesc.Request), do: 0xD
  def multipart_request_codec_to_int(Openflow.Multipart.Experimenter.Request), do: 0xFFFF
  def multipart_request_codec_to_int(_), do: throw(:bad_enum)
  def multipart_request_codec_to_atom(0x0), do: Openflow.Multipart.Desc.Request
  def multipart_request_codec_to_atom(0x1), do: Openflow.Multipart.Flow.Request
  def multipart_request_codec_to_atom(0x2), do: Openflow.Multipart.Aggregate.Request
  def multipart_request_codec_to_atom(0x3), do: Openflow.Multipart.Table.Request
  def multipart_request_codec_to_atom(0x4), do: Openflow.Multipart.PortStats.Request
  def multipart_request_codec_to_atom(0x5), do: Openflow.Multipart.Queue.Request
  def multipart_request_codec_to_atom(0x6), do: Openflow.Multipart.Group.Request
  def multipart_request_codec_to_atom(0x7), do: Openflow.Multipart.GroupDesc.Request
  def multipart_request_codec_to_atom(0x8), do: Openflow.Multipart.GroupFeatures.Request
  def multipart_request_codec_to_atom(0x9), do: Openflow.Multipart.Meter.Request
  def multipart_request_codec_to_atom(0xA), do: Openflow.Multipart.MeterConfig.Request
  def multipart_request_codec_to_atom(0xB), do: Openflow.Multipart.MeterFeatures.Request
  def multipart_request_codec_to_atom(0xC), do: Openflow.Multipart.TableFeatures.Request
  def multipart_request_codec_to_atom(0xD), do: Openflow.Multipart.PortDesc.Request
  def multipart_request_codec_to_atom(0xFFFF), do: Openflow.Multipart.Experimenter.Request
  def multipart_request_codec_to_atom(_), do: throw(:bad_enum)
  def multipart_reply_codec_to_int(Openflow.Multipart.Desc.Reply), do: 0x0
  def multipart_reply_codec_to_int(Openflow.Multipart.Flow.Reply), do: 0x1
  def multipart_reply_codec_to_int(Openflow.Multipart.Aggregate.Reply), do: 0x2
  def multipart_reply_codec_to_int(Openflow.Multipart.Table.Reply), do: 0x3
  def multipart_reply_codec_to_int(Openflow.Multipart.PortStats.Reply), do: 0x4
  def multipart_reply_codec_to_int(Openflow.Multipart.Queue.Reply), do: 0x5
  def multipart_reply_codec_to_int(Openflow.Multipart.Group.Reply), do: 0x6
  def multipart_reply_codec_to_int(Openflow.Multipart.GroupDesc.Reply), do: 0x7
  def multipart_reply_codec_to_int(Openflow.Multipart.GroupFeatures.Reply), do: 0x8
  def multipart_reply_codec_to_int(Openflow.Multipart.Meter.Reply), do: 0x9
  def multipart_reply_codec_to_int(Openflow.Multipart.MeterConfig.Reply), do: 0xA
  def multipart_reply_codec_to_int(Openflow.Multipart.MeterFeatures.Reply), do: 0xB
  def multipart_reply_codec_to_int(Openflow.Multipart.TableFeatures.Reply), do: 0xC
  def multipart_reply_codec_to_int(Openflow.Multipart.PortDesc.Reply), do: 0xD
  def multipart_reply_codec_to_int(Openflow.Multipart.Experimenter.Reply), do: 0xFFFF
  def multipart_reply_codec_to_int(_), do: throw(:bad_enum)
  def multipart_reply_codec_to_atom(0x0), do: Openflow.Multipart.Desc.Reply
  def multipart_reply_codec_to_atom(0x1), do: Openflow.Multipart.Flow.Reply
  def multipart_reply_codec_to_atom(0x2), do: Openflow.Multipart.Aggregate.Reply
  def multipart_reply_codec_to_atom(0x3), do: Openflow.Multipart.Table.Reply
  def multipart_reply_codec_to_atom(0x4), do: Openflow.Multipart.PortStats.Reply
  def multipart_reply_codec_to_atom(0x5), do: Openflow.Multipart.Queue.Reply
  def multipart_reply_codec_to_atom(0x6), do: Openflow.Multipart.Group.Reply
  def multipart_reply_codec_to_atom(0x7), do: Openflow.Multipart.GroupDesc.Reply
  def multipart_reply_codec_to_atom(0x8), do: Openflow.Multipart.GroupFeatures.Reply
  def multipart_reply_codec_to_atom(0x9), do: Openflow.Multipart.Meter.Reply
  def multipart_reply_codec_to_atom(0xA), do: Openflow.Multipart.MeterConfig.Reply
  def multipart_reply_codec_to_atom(0xB), do: Openflow.Multipart.MeterFeatures.Reply
  def multipart_reply_codec_to_atom(0xC), do: Openflow.Multipart.TableFeatures.Reply
  def multipart_reply_codec_to_atom(0xD), do: Openflow.Multipart.PortDesc.Reply
  def multipart_reply_codec_to_atom(0xFFFF), do: Openflow.Multipart.Experimenter.Reply
  def multipart_reply_codec_to_atom(_), do: throw(:bad_enum)
  def nicira_ext_stats_to_int(Openflow.Multipart.NxFlow), do: 0x0
  def nicira_ext_stats_to_int(Openflow.Multipart.NxAggregate), do: 0x1
  def nicira_ext_stats_to_int(Openflow.Multipart.NxFlowMonitor), do: 0x2
  def nicira_ext_stats_to_int(Openflow.Multipart.NxIPFIXBridge), do: 0x3
  def nicira_ext_stats_to_int(Openflow.Multipart.NxIPFIXFlow), do: 0x4
  def nicira_ext_stats_to_int(_), do: throw(:bad_enum)
  def nicira_ext_stats_to_atom(0x0), do: Openflow.Multipart.NxFlow
  def nicira_ext_stats_to_atom(0x1), do: Openflow.Multipart.NxAggregate
  def nicira_ext_stats_to_atom(0x2), do: Openflow.Multipart.NxFlowMonitor
  def nicira_ext_stats_to_atom(0x3), do: Openflow.Multipart.NxIPFIXBridge
  def nicira_ext_stats_to_atom(0x4), do: Openflow.Multipart.NxIPFIXFlow
  def nicira_ext_stats_to_atom(_), do: throw(:bad_enum)
  def hello_elem_to_int(:versionbitmap), do: 0x1
  def hello_elem_to_int(_), do: throw(:bad_enum)
  def hello_elem_to_atom(0x1), do: :versionbitmap
  def hello_elem_to_atom(_), do: throw(:bad_enum)
  def error_type_to_int(:hello_failed), do: 0x0
  def error_type_to_int(:bad_request), do: 0x1
  def error_type_to_int(:bad_action), do: 0x2
  def error_type_to_int(:bad_instruction), do: 0x3
  def error_type_to_int(:bad_match), do: 0x4
  def error_type_to_int(:flow_mod_failed), do: 0x5
  def error_type_to_int(:group_mod_failed), do: 0x6
  def error_type_to_int(:port_mod_failed), do: 0x7
  def error_type_to_int(:table_mod_failed), do: 0x8
  def error_type_to_int(:queue_op_failed), do: 0x9
  def error_type_to_int(:switch_config_failed), do: 0xA
  def error_type_to_int(:role_request_failed), do: 0xB
  def error_type_to_int(:meter_mod_failed), do: 0xC
  def error_type_to_int(:table_features_failed), do: 0xD
  def error_type_to_int(:experimenter), do: 0xFFFF
  def error_type_to_int(_), do: throw(:bad_enum)
  def error_type_to_atom(0x0), do: :hello_failed
  def error_type_to_atom(0x1), do: :bad_request
  def error_type_to_atom(0x2), do: :bad_action
  def error_type_to_atom(0x3), do: :bad_instruction
  def error_type_to_atom(0x4), do: :bad_match
  def error_type_to_atom(0x5), do: :flow_mod_failed
  def error_type_to_atom(0x6), do: :group_mod_failed
  def error_type_to_atom(0x7), do: :port_mod_failed
  def error_type_to_atom(0x8), do: :table_mod_failed
  def error_type_to_atom(0x9), do: :queue_op_failed
  def error_type_to_atom(0xA), do: :switch_config_failed
  def error_type_to_atom(0xB), do: :role_request_failed
  def error_type_to_atom(0xC), do: :meter_mod_failed
  def error_type_to_atom(0xD), do: :table_features_failed
  def error_type_to_atom(0xFFFF), do: :experimenter
  def error_type_to_atom(_), do: throw(:bad_enum)
  def hello_failed_to_int(:inconpatible), do: 0x0
  def hello_failed_to_int(:eperm), do: 0x1
  def hello_failed_to_int(_), do: throw(:bad_enum)
  def hello_failed_to_atom(0x0), do: :inconpatible
  def hello_failed_to_atom(0x1), do: :eperm
  def hello_failed_to_atom(_), do: throw(:bad_enum)
  def bad_request_to_int(:bad_version), do: 0x0
  def bad_request_to_int(:bad_type), do: 0x1
  def bad_request_to_int(:bad_multipart), do: 0x2
  def bad_request_to_int(:bad_experimeter), do: 0x3
  def bad_request_to_int(:bad_exp_type), do: 0x4
  def bad_request_to_int(:eperm), do: 0x5
  def bad_request_to_int(:bad_len), do: 0x6
  def bad_request_to_int(:buffer_empty), do: 0x7
  def bad_request_to_int(:buffer_unknown), do: 0x8
  def bad_request_to_int(:bad_table_id), do: 0x9
  def bad_request_to_int(:is_slave), do: 0xA
  def bad_request_to_int(:bad_port), do: 0xB
  def bad_request_to_int(:bad_packet), do: 0xC
  def bad_request_to_int(:multipart_buffer_overflow), do: 0xD
  def bad_request_to_int(:multipart_request_timeout), do: 0xE
  def bad_request_to_int(:multipart_reply_timeout), do: 0xF
  def bad_request_to_int(:nxm_invalid), do: 0x100
  def bad_request_to_int(:nxm_bad_type), do: 0x101
  def bad_request_to_int(:must_be_zero), do: 0x203
  def bad_request_to_int(:bad_reason), do: 0x204
  def bad_request_to_int(:flow_monitor_bad_event), do: 0x208
  def bad_request_to_int(:undecodable_error), do: 0x209
  def bad_request_to_int(:resume_not_supported), do: 0x215
  def bad_request_to_int(:resume_stale), do: 0x216
  def bad_request_to_int(_), do: throw(:bad_enum)
  def bad_request_to_atom(0x0), do: :bad_version
  def bad_request_to_atom(0x1), do: :bad_type
  def bad_request_to_atom(0x2), do: :bad_multipart
  def bad_request_to_atom(0x3), do: :bad_experimeter
  def bad_request_to_atom(0x4), do: :bad_exp_type
  def bad_request_to_atom(0x5), do: :eperm
  def bad_request_to_atom(0x6), do: :bad_len
  def bad_request_to_atom(0x7), do: :buffer_empty
  def bad_request_to_atom(0x8), do: :buffer_unknown
  def bad_request_to_atom(0x9), do: :bad_table_id
  def bad_request_to_atom(0xA), do: :is_slave
  def bad_request_to_atom(0xB), do: :bad_port
  def bad_request_to_atom(0xC), do: :bad_packet
  def bad_request_to_atom(0xD), do: :multipart_buffer_overflow
  def bad_request_to_atom(0xE), do: :multipart_request_timeout
  def bad_request_to_atom(0xF), do: :multipart_reply_timeout
  def bad_request_to_atom(0x100), do: :nxm_invalid
  def bad_request_to_atom(0x101), do: :nxm_bad_type
  def bad_request_to_atom(0x203), do: :must_be_zero
  def bad_request_to_atom(0x204), do: :bad_reason
  def bad_request_to_atom(0x208), do: :flow_monitor_bad_event
  def bad_request_to_atom(0x209), do: :undecodable_error
  def bad_request_to_atom(0x215), do: :resume_not_supported
  def bad_request_to_atom(0x216), do: :resume_stale
  def bad_request_to_atom(_), do: throw(:bad_enum)
  def bad_action_to_int(:bad_type), do: 0x0
  def bad_action_to_int(:bad_len), do: 0x1
  def bad_action_to_int(:bad_experimeter), do: 0x2
  def bad_action_to_int(:bad_exp_type), do: 0x3
  def bad_action_to_int(:bad_out_port), do: 0x4
  def bad_action_to_int(:bad_argument), do: 0x5
  def bad_action_to_int(:eperm), do: 0x6
  def bad_action_to_int(:too_many), do: 0x7
  def bad_action_to_int(:bad_queue), do: 0x8
  def bad_action_to_int(:bad_out_group), do: 0x9
  def bad_action_to_int(:match_inconsistent), do: 0xA
  def bad_action_to_int(:unsupported_order), do: 0xB
  def bad_action_to_int(:bad_tag), do: 0xC
  def bad_action_to_int(:bad_set_type), do: 0xD
  def bad_action_to_int(:bad_set_len), do: 0xE
  def bad_action_to_int(:bad_set_argument), do: 0xF
  def bad_action_to_int(:must_be_zero), do: 0x100
  def bad_action_to_int(:conntrack_datapath_support), do: 0x109
  def bad_action_to_int(:bad_conjunction), do: 0x20E
  def bad_action_to_int(_), do: throw(:bad_enum)
  def bad_action_to_atom(0x0), do: :bad_type
  def bad_action_to_atom(0x1), do: :bad_len
  def bad_action_to_atom(0x2), do: :bad_experimeter
  def bad_action_to_atom(0x3), do: :bad_exp_type
  def bad_action_to_atom(0x4), do: :bad_out_port
  def bad_action_to_atom(0x5), do: :bad_argument
  def bad_action_to_atom(0x6), do: :eperm
  def bad_action_to_atom(0x7), do: :too_many
  def bad_action_to_atom(0x8), do: :bad_queue
  def bad_action_to_atom(0x9), do: :bad_out_group
  def bad_action_to_atom(0xA), do: :match_inconsistent
  def bad_action_to_atom(0xB), do: :unsupported_order
  def bad_action_to_atom(0xC), do: :bad_tag
  def bad_action_to_atom(0xD), do: :bad_set_type
  def bad_action_to_atom(0xE), do: :bad_set_len
  def bad_action_to_atom(0xF), do: :bad_set_argument
  def bad_action_to_atom(0x100), do: :must_be_zero
  def bad_action_to_atom(0x109), do: :conntrack_datapath_support
  def bad_action_to_atom(0x20E), do: :bad_conjunction
  def bad_action_to_atom(_), do: throw(:bad_enum)
  def bad_instruction_to_int(:unknown_instruction), do: 0x0
  def bad_instruction_to_int(:unsupported_instruction), do: 0x1
  def bad_instruction_to_int(:bad_table_id), do: 0x2
  def bad_instruction_to_int(:unsupported_metadata), do: 0x3
  def bad_instruction_to_int(:unsupported_metadata_mask), do: 0x4
  def bad_instruction_to_int(:bad_experimeter), do: 0x5
  def bad_instruction_to_int(:bad_exp_type), do: 0x6
  def bad_instruction_to_int(:bad_len), do: 0x7
  def bad_instruction_to_int(:eperm), do: 0x8
  def bad_instruction_to_int(:dup_inst), do: 0x100
  def bad_instruction_to_int(_), do: throw(:bad_enum)
  def bad_instruction_to_atom(0x0), do: :unknown_instruction
  def bad_instruction_to_atom(0x1), do: :unsupported_instruction
  def bad_instruction_to_atom(0x2), do: :bad_table_id
  def bad_instruction_to_atom(0x3), do: :unsupported_metadata
  def bad_instruction_to_atom(0x4), do: :unsupported_metadata_mask
  def bad_instruction_to_atom(0x5), do: :bad_experimeter
  def bad_instruction_to_atom(0x6), do: :bad_exp_type
  def bad_instruction_to_atom(0x7), do: :bad_len
  def bad_instruction_to_atom(0x8), do: :eperm
  def bad_instruction_to_atom(0x100), do: :dup_inst
  def bad_instruction_to_atom(_), do: throw(:bad_enum)
  def bad_match_to_int(:bad_type), do: 0x0
  def bad_match_to_int(:bad_len), do: 0x1
  def bad_match_to_int(:bad_tag), do: 0x2
  def bad_match_to_int(:bad_dl_addr_mask), do: 0x3
  def bad_match_to_int(:bad_nw_addr_mask), do: 0x4
  def bad_match_to_int(:bad_wildcards), do: 0x5
  def bad_match_to_int(:bad_field), do: 0x6
  def bad_match_to_int(:bad_value), do: 0x7
  def bad_match_to_int(:bad_mask), do: 0x8
  def bad_match_to_int(:bad_prereq), do: 0x9
  def bad_match_to_int(:dup_field), do: 0xA
  def bad_match_to_int(:eperm), do: 0xB
  def bad_match_to_int(:conntrack_datapath_support), do: 0x108
  def bad_match_to_int(_), do: throw(:bad_enum)
  def bad_match_to_atom(0x0), do: :bad_type
  def bad_match_to_atom(0x1), do: :bad_len
  def bad_match_to_atom(0x2), do: :bad_tag
  def bad_match_to_atom(0x3), do: :bad_dl_addr_mask
  def bad_match_to_atom(0x4), do: :bad_nw_addr_mask
  def bad_match_to_atom(0x5), do: :bad_wildcards
  def bad_match_to_atom(0x6), do: :bad_field
  def bad_match_to_atom(0x7), do: :bad_value
  def bad_match_to_atom(0x8), do: :bad_mask
  def bad_match_to_atom(0x9), do: :bad_prereq
  def bad_match_to_atom(0xA), do: :dup_field
  def bad_match_to_atom(0xB), do: :eperm
  def bad_match_to_atom(0x108), do: :conntrack_datapath_support
  def bad_match_to_atom(_), do: throw(:bad_enum)
  def flow_mod_failed_to_int(:unknown), do: 0x0
  def flow_mod_failed_to_int(:table_full), do: 0x1
  def flow_mod_failed_to_int(:bad_table_id), do: 0x2
  def flow_mod_failed_to_int(:overlap), do: 0x3
  def flow_mod_failed_to_int(:eperm), do: 0x4
  def flow_mod_failed_to_int(:bad_timeout), do: 0x5
  def flow_mod_failed_to_int(:bad_command), do: 0x6
  def flow_mod_failed_to_int(:bad_flags), do: 0x7
  def flow_mod_failed_to_int(_), do: throw(:bad_enum)
  def flow_mod_failed_to_atom(0x0), do: :unknown
  def flow_mod_failed_to_atom(0x1), do: :table_full
  def flow_mod_failed_to_atom(0x2), do: :bad_table_id
  def flow_mod_failed_to_atom(0x3), do: :overlap
  def flow_mod_failed_to_atom(0x4), do: :eperm
  def flow_mod_failed_to_atom(0x5), do: :bad_timeout
  def flow_mod_failed_to_atom(0x6), do: :bad_command
  def flow_mod_failed_to_atom(0x7), do: :bad_flags
  def flow_mod_failed_to_atom(_), do: throw(:bad_enum)
  def group_mod_failed_to_int(:group_exists), do: 0x0
  def group_mod_failed_to_int(:invalid_group), do: 0x1
  def group_mod_failed_to_int(:weight_unsupported), do: 0x2
  def group_mod_failed_to_int(:out_of_groups), do: 0x3
  def group_mod_failed_to_int(:ouf_of_buckets), do: 0x4
  def group_mod_failed_to_int(:chaining_unsupported), do: 0x5
  def group_mod_failed_to_int(:watch_unsupported), do: 0x6
  def group_mod_failed_to_int(:loop), do: 0x7
  def group_mod_failed_to_int(:unknown_group), do: 0x8
  def group_mod_failed_to_int(:chained_group), do: 0x9
  def group_mod_failed_to_int(:bad_type), do: 0xA
  def group_mod_failed_to_int(:bad_command), do: 0xB
  def group_mod_failed_to_int(:bad_bucket), do: 0xC
  def group_mod_failed_to_int(:bad_watch), do: 0xD
  def group_mod_failed_to_int(:eperm), do: 0xE
  def group_mod_failed_to_int(:unknown_bucket), do: 0xF
  def group_mod_failed_to_int(:bucket_exists), do: 0x10
  def group_mod_failed_to_int(_), do: throw(:bad_enum)
  def group_mod_failed_to_atom(0x0), do: :group_exists
  def group_mod_failed_to_atom(0x1), do: :invalid_group
  def group_mod_failed_to_atom(0x2), do: :weight_unsupported
  def group_mod_failed_to_atom(0x3), do: :out_of_groups
  def group_mod_failed_to_atom(0x4), do: :ouf_of_buckets
  def group_mod_failed_to_atom(0x5), do: :chaining_unsupported
  def group_mod_failed_to_atom(0x6), do: :watch_unsupported
  def group_mod_failed_to_atom(0x7), do: :loop
  def group_mod_failed_to_atom(0x8), do: :unknown_group
  def group_mod_failed_to_atom(0x9), do: :chained_group
  def group_mod_failed_to_atom(0xA), do: :bad_type
  def group_mod_failed_to_atom(0xB), do: :bad_command
  def group_mod_failed_to_atom(0xC), do: :bad_bucket
  def group_mod_failed_to_atom(0xD), do: :bad_watch
  def group_mod_failed_to_atom(0xE), do: :eperm
  def group_mod_failed_to_atom(0xF), do: :unknown_bucket
  def group_mod_failed_to_atom(0x10), do: :bucket_exists
  def group_mod_failed_to_atom(_), do: throw(:bad_enum)
  def port_mod_failed_to_int(:bad_port), do: 0x0
  def port_mod_failed_to_int(:bad_hw_addr), do: 0x1
  def port_mod_failed_to_int(:bad_config), do: 0x2
  def port_mod_failed_to_int(:bad_advertise), do: 0x3
  def port_mod_failed_to_int(:eperm), do: 0x4
  def port_mod_failed_to_int(_), do: throw(:bad_enum)
  def port_mod_failed_to_atom(0x0), do: :bad_port
  def port_mod_failed_to_atom(0x1), do: :bad_hw_addr
  def port_mod_failed_to_atom(0x2), do: :bad_config
  def port_mod_failed_to_atom(0x3), do: :bad_advertise
  def port_mod_failed_to_atom(0x4), do: :eperm
  def port_mod_failed_to_atom(_), do: throw(:bad_enum)
  def table_mod_failed_to_int(:bad_table), do: 0x0
  def table_mod_failed_to_int(:bad_config), do: 0x1
  def table_mod_failed_to_int(:eperm), do: 0x2
  def table_mod_failed_to_int(_), do: throw(:bad_enum)
  def table_mod_failed_to_atom(0x0), do: :bad_table
  def table_mod_failed_to_atom(0x1), do: :bad_config
  def table_mod_failed_to_atom(0x2), do: :eperm
  def table_mod_failed_to_atom(_), do: throw(:bad_enum)
  def queue_op_failed_to_int(:bad_port), do: 0x0
  def queue_op_failed_to_int(:bad_queue), do: 0x1
  def queue_op_failed_to_int(:eperm), do: 0x2
  def queue_op_failed_to_int(_), do: throw(:bad_enum)
  def queue_op_failed_to_atom(0x0), do: :bad_port
  def queue_op_failed_to_atom(0x1), do: :bad_queue
  def queue_op_failed_to_atom(0x2), do: :eperm
  def queue_op_failed_to_atom(_), do: throw(:bad_enum)
  def switch_config_failed_to_int(:bad_flags), do: 0x0
  def switch_config_failed_to_int(:bad_len), do: 0x1
  def switch_config_failed_to_int(:eperm), do: 0x2
  def switch_config_failed_to_int(_), do: throw(:bad_enum)
  def switch_config_failed_to_atom(0x0), do: :bad_flags
  def switch_config_failed_to_atom(0x1), do: :bad_len
  def switch_config_failed_to_atom(0x2), do: :eperm
  def switch_config_failed_to_atom(_), do: throw(:bad_enum)
  def role_request_failed_to_int(:stale), do: 0x0
  def role_request_failed_to_int(:unsup), do: 0x1
  def role_request_failed_to_int(:bad_role), do: 0x2
  def role_request_failed_to_int(_), do: throw(:bad_enum)
  def role_request_failed_to_atom(0x0), do: :stale
  def role_request_failed_to_atom(0x1), do: :unsup
  def role_request_failed_to_atom(0x2), do: :bad_role
  def role_request_failed_to_atom(_), do: throw(:bad_enum)
  def meter_mod_failed_to_int(:unknown), do: 0x0
  def meter_mod_failed_to_int(:meter_exists), do: 0x1
  def meter_mod_failed_to_int(:invalid_meter), do: 0x2
  def meter_mod_failed_to_int(:unknown_meter), do: 0x3
  def meter_mod_failed_to_int(:bad_command), do: 0x4
  def meter_mod_failed_to_int(:bad_flags), do: 0x5
  def meter_mod_failed_to_int(:bad_rate), do: 0x6
  def meter_mod_failed_to_int(:bad_burst), do: 0x7
  def meter_mod_failed_to_int(:bad_band), do: 0x8
  def meter_mod_failed_to_int(:bad_band_value), do: 0x9
  def meter_mod_failed_to_int(:out_of_meters), do: 0xA
  def meter_mod_failed_to_int(:out_of_bands), do: 0xB
  def meter_mod_failed_to_int(_), do: throw(:bad_enum)
  def meter_mod_failed_to_atom(0x0), do: :unknown
  def meter_mod_failed_to_atom(0x1), do: :meter_exists
  def meter_mod_failed_to_atom(0x2), do: :invalid_meter
  def meter_mod_failed_to_atom(0x3), do: :unknown_meter
  def meter_mod_failed_to_atom(0x4), do: :bad_command
  def meter_mod_failed_to_atom(0x5), do: :bad_flags
  def meter_mod_failed_to_atom(0x6), do: :bad_rate
  def meter_mod_failed_to_atom(0x7), do: :bad_burst
  def meter_mod_failed_to_atom(0x8), do: :bad_band
  def meter_mod_failed_to_atom(0x9), do: :bad_band_value
  def meter_mod_failed_to_atom(0xA), do: :out_of_meters
  def meter_mod_failed_to_atom(0xB), do: :out_of_bands
  def meter_mod_failed_to_atom(_), do: throw(:bad_enum)
  def table_features_failed_to_int(:bad_table), do: 0x0
  def table_features_failed_to_int(:bad_metadata), do: 0x1
  def table_features_failed_to_int(:bad_type), do: 0x2
  def table_features_failed_to_int(:bad_len), do: 0x3
  def table_features_failed_to_int(:bad_argument), do: 0x4
  def table_features_failed_to_int(:eperm), do: 0x5
  def table_features_failed_to_int(_), do: throw(:bad_enum)
  def table_features_failed_to_atom(0x0), do: :bad_table
  def table_features_failed_to_atom(0x1), do: :bad_metadata
  def table_features_failed_to_atom(0x2), do: :bad_type
  def table_features_failed_to_atom(0x3), do: :bad_len
  def table_features_failed_to_atom(0x4), do: :bad_argument
  def table_features_failed_to_atom(0x5), do: :eperm
  def table_features_failed_to_atom(_), do: throw(:bad_enum)
  def switch_capabilities_to_int(:flow_stats), do: 0x1
  def switch_capabilities_to_int(:table_stats), do: 0x2
  def switch_capabilities_to_int(:port_stats), do: 0x4
  def switch_capabilities_to_int(:group_stats), do: 0x8
  def switch_capabilities_to_int(:ip_reasm), do: 0x20
  def switch_capabilities_to_int(:queue_stats), do: 0x40
  def switch_capabilities_to_int(:arp_match_ip), do: 0x80
  def switch_capabilities_to_int(:port_blocked), do: 0x100
  def switch_capabilities_to_int(_), do: throw(:bad_enum)
  def switch_capabilities_to_atom(0x1), do: :flow_stats
  def switch_capabilities_to_atom(0x2), do: :table_stats
  def switch_capabilities_to_atom(0x4), do: :port_stats
  def switch_capabilities_to_atom(0x8), do: :group_stats
  def switch_capabilities_to_atom(0x20), do: :ip_reasm
  def switch_capabilities_to_atom(0x40), do: :queue_stats
  def switch_capabilities_to_atom(0x80), do: :arp_match_ip
  def switch_capabilities_to_atom(0x100), do: :port_blocked
  def switch_capabilities_to_atom(_), do: throw(:bad_enum)
  def config_flags_to_int(:drop), do: 0x1
  def config_flags_to_int(:reasm), do: 0x2
  def config_flags_to_int(_), do: throw(:bad_enum)
  def config_flags_to_atom(0x1), do: :drop
  def config_flags_to_atom(0x2), do: :reasm
  def config_flags_to_atom(_), do: throw(:bad_enum)
  def controller_max_len_to_int(:max), do: 0xFFE5
  def controller_max_len_to_int(:no_buffer), do: 0xFFFF
  def controller_max_len_to_int(_), do: throw(:bad_enum)
  def controller_max_len_to_atom(0xFFE5), do: :max
  def controller_max_len_to_atom(0xFFFF), do: :no_buffer
  def controller_max_len_to_atom(_), do: throw(:bad_enum)
  def experimenter_oxm_vendors_to_int(:nicira_ext_match), do: 0x2320
  def experimenter_oxm_vendors_to_int(:hp_ext_match), do: 0x2428
  def experimenter_oxm_vendors_to_int(:onf_ext_match), do: 0x4F4E4600
  def experimenter_oxm_vendors_to_int(_), do: throw(:bad_enum)
  def experimenter_oxm_vendors_to_atom(0x2320), do: :nicira_ext_match
  def experimenter_oxm_vendors_to_atom(0x2428), do: :hp_ext_match
  def experimenter_oxm_vendors_to_atom(0x4F4E4600), do: :onf_ext_match
  def experimenter_oxm_vendors_to_atom(_), do: throw(:bad_enum)
  def match_type_to_int(:standard), do: 0x0
  def match_type_to_int(:oxm), do: 0x1
  def match_type_to_int(_), do: throw(:bad_enum)
  def match_type_to_atom(0x0), do: :standard
  def match_type_to_atom(0x1), do: :oxm
  def match_type_to_atom(_), do: throw(:bad_enum)
  def oxm_class_to_int(:nxm_0), do: 0x0
  def oxm_class_to_int(:nxm_1), do: 0x1
  def oxm_class_to_int(:openflow_basic), do: 0x8000
  def oxm_class_to_int(:packet_register), do: 0x8001
  def oxm_class_to_int(:experimenter), do: 0xFFFF
  def oxm_class_to_int(_), do: throw(:bad_enum)
  def oxm_class_to_atom(0x0), do: :nxm_0
  def oxm_class_to_atom(0x1), do: :nxm_1
  def oxm_class_to_atom(0x8000), do: :openflow_basic
  def oxm_class_to_atom(0x8001), do: :packet_register
  def oxm_class_to_atom(0xFFFF), do: :experimenter
  def oxm_class_to_atom(_), do: throw(:bad_enum)
  def nxm_0_to_int(:nx_in_port), do: 0x0
  def nxm_0_to_int(:nx_eth_dst), do: 0x1
  def nxm_0_to_int(:nx_eth_src), do: 0x2
  def nxm_0_to_int(:nx_eth_type), do: 0x3
  def nxm_0_to_int(:nx_vlan_tci), do: 0x4
  def nxm_0_to_int(:nx_ip_tos), do: 0x5
  def nxm_0_to_int(:nx_ip_proto), do: 0x6
  def nxm_0_to_int(:nx_ipv4_src), do: 0x7
  def nxm_0_to_int(:nx_ipv4_dst), do: 0x8
  def nxm_0_to_int(:nx_tcp_src), do: 0x9
  def nxm_0_to_int(:nx_tcp_dst), do: 0xA
  def nxm_0_to_int(:nx_udp_src), do: 0xB
  def nxm_0_to_int(:nx_udp_dst), do: 0xC
  def nxm_0_to_int(:nx_icmpv4_type), do: 0xD
  def nxm_0_to_int(:nx_icmpv4_code), do: 0xE
  def nxm_0_to_int(:nx_arp_op), do: 0xF
  def nxm_0_to_int(:nx_arp_spa), do: 0x10
  def nxm_0_to_int(:nx_arp_tpa), do: 0x11
  def nxm_0_to_int(:nx_tcp_flags), do: 0x22
  def nxm_0_to_int(_), do: throw(:bad_enum)
  def nxm_0_to_atom(0x0), do: :nx_in_port
  def nxm_0_to_atom(0x1), do: :nx_eth_dst
  def nxm_0_to_atom(0x2), do: :nx_eth_src
  def nxm_0_to_atom(0x3), do: :nx_eth_type
  def nxm_0_to_atom(0x4), do: :nx_vlan_tci
  def nxm_0_to_atom(0x5), do: :nx_ip_tos
  def nxm_0_to_atom(0x6), do: :nx_ip_proto
  def nxm_0_to_atom(0x7), do: :nx_ipv4_src
  def nxm_0_to_atom(0x8), do: :nx_ipv4_dst
  def nxm_0_to_atom(0x9), do: :nx_tcp_src
  def nxm_0_to_atom(0xA), do: :nx_tcp_dst
  def nxm_0_to_atom(0xB), do: :nx_udp_src
  def nxm_0_to_atom(0xC), do: :nx_udp_dst
  def nxm_0_to_atom(0xD), do: :nx_icmpv4_type
  def nxm_0_to_atom(0xE), do: :nx_icmpv4_code
  def nxm_0_to_atom(0xF), do: :nx_arp_op
  def nxm_0_to_atom(0x10), do: :nx_arp_spa
  def nxm_0_to_atom(0x11), do: :nx_arp_tpa
  def nxm_0_to_atom(0x22), do: :nx_tcp_flags
  def nxm_0_to_atom(_), do: throw(:bad_enum)
  def nxm_1_to_int(:reg0), do: 0x0
  def nxm_1_to_int(:reg1), do: 0x1
  def nxm_1_to_int(:reg2), do: 0x2
  def nxm_1_to_int(:reg3), do: 0x3
  def nxm_1_to_int(:reg4), do: 0x4
  def nxm_1_to_int(:reg5), do: 0x5
  def nxm_1_to_int(:reg6), do: 0x6
  def nxm_1_to_int(:reg7), do: 0x7
  def nxm_1_to_int(:reg8), do: 0x8
  def nxm_1_to_int(:reg9), do: 0x9
  def nxm_1_to_int(:reg10), do: 0xA
  def nxm_1_to_int(:reg11), do: 0xB
  def nxm_1_to_int(:reg12), do: 0xC
  def nxm_1_to_int(:reg13), do: 0xD
  def nxm_1_to_int(:reg14), do: 0xE
  def nxm_1_to_int(:reg15), do: 0xF
  def nxm_1_to_int(:tun_id), do: 0x10
  def nxm_1_to_int(:nx_arp_sha), do: 0x11
  def nxm_1_to_int(:nx_arp_tha), do: 0x12
  def nxm_1_to_int(:nx_ipv6_src), do: 0x13
  def nxm_1_to_int(:nx_ipv6_dst), do: 0x14
  def nxm_1_to_int(:nx_icmpv6_type), do: 0x15
  def nxm_1_to_int(:nx_icmpv6_code), do: 0x16
  def nxm_1_to_int(:nx_ipv6_nd_target), do: 0x17
  def nxm_1_to_int(:nx_ipv6_nd_sll), do: 0x18
  def nxm_1_to_int(:nx_ipv6_nd_tll), do: 0x19
  def nxm_1_to_int(:nx_ip_frag), do: 0x1A
  def nxm_1_to_int(:nx_ipv6_label), do: 0x1B
  def nxm_1_to_int(:nx_ip_ecn), do: 0x1C
  def nxm_1_to_int(:nx_ip_ttl), do: 0x1D
  def nxm_1_to_int(:nx_mpls_ttl), do: 0x1E
  def nxm_1_to_int(:tun_src), do: 0x1F
  def nxm_1_to_int(:tun_dst), do: 0x20
  def nxm_1_to_int(:pkt_mark), do: 0x21
  def nxm_1_to_int(:dp_hash), do: 0x23
  def nxm_1_to_int(:recirc_id), do: 0x24
  def nxm_1_to_int(:conj_id), do: 0x25
  def nxm_1_to_int(:tun_gbp_id), do: 0x26
  def nxm_1_to_int(:tun_gbp_flags), do: 0x27
  def nxm_1_to_int(:tun_metadata0), do: 0x28
  def nxm_1_to_int(:tun_metadata1), do: 0x29
  def nxm_1_to_int(:tun_metadata2), do: 0x2A
  def nxm_1_to_int(:tun_metadata3), do: 0x2B
  def nxm_1_to_int(:tun_metadata4), do: 0x2C
  def nxm_1_to_int(:tun_metadata5), do: 0x2D
  def nxm_1_to_int(:tun_metadata6), do: 0x2E
  def nxm_1_to_int(:tun_metadata7), do: 0x2F
  def nxm_1_to_int(:tun_metadata8), do: 0x30
  def nxm_1_to_int(:tun_metadata9), do: 0x31
  def nxm_1_to_int(:tun_metadata10), do: 0x32
  def nxm_1_to_int(:tun_metadata11), do: 0x33
  def nxm_1_to_int(:tun_metadata12), do: 0x34
  def nxm_1_to_int(:tun_metadata13), do: 0x35
  def nxm_1_to_int(:tun_metadata14), do: 0x36
  def nxm_1_to_int(:tun_metadata15), do: 0x37
  def nxm_1_to_int(:tun_metadata16), do: 0x38
  def nxm_1_to_int(:tun_metadata17), do: 0x39
  def nxm_1_to_int(:tun_metadata18), do: 0x3A
  def nxm_1_to_int(:tun_metadata19), do: 0x3B
  def nxm_1_to_int(:tun_metadata20), do: 0x3C
  def nxm_1_to_int(:tun_metadata21), do: 0x3D
  def nxm_1_to_int(:tun_metadata22), do: 0x3E
  def nxm_1_to_int(:tun_metadata23), do: 0x3F
  def nxm_1_to_int(:tun_metadata24), do: 0x40
  def nxm_1_to_int(:tun_metadata25), do: 0x41
  def nxm_1_to_int(:tun_metadata26), do: 0x42
  def nxm_1_to_int(:tun_metadata27), do: 0x43
  def nxm_1_to_int(:tun_metadata28), do: 0x44
  def nxm_1_to_int(:tun_metadata29), do: 0x45
  def nxm_1_to_int(:tun_metadata30), do: 0x46
  def nxm_1_to_int(:tun_metadata31), do: 0x47
  def nxm_1_to_int(:tun_metadata32), do: 0x48
  def nxm_1_to_int(:tun_metadata33), do: 0x49
  def nxm_1_to_int(:tun_metadata34), do: 0x4A
  def nxm_1_to_int(:tun_metadata35), do: 0x4B
  def nxm_1_to_int(:tun_metadata36), do: 0x4C
  def nxm_1_to_int(:tun_metadata37), do: 0x4D
  def nxm_1_to_int(:tun_metadata38), do: 0x4E
  def nxm_1_to_int(:tun_metadata39), do: 0x4F
  def nxm_1_to_int(:tun_metadata40), do: 0x50
  def nxm_1_to_int(:tun_metadata41), do: 0x51
  def nxm_1_to_int(:tun_metadata42), do: 0x52
  def nxm_1_to_int(:tun_metadata43), do: 0x53
  def nxm_1_to_int(:tun_metadata44), do: 0x54
  def nxm_1_to_int(:tun_metadata45), do: 0x55
  def nxm_1_to_int(:tun_metadata46), do: 0x56
  def nxm_1_to_int(:tun_metadata47), do: 0x57
  def nxm_1_to_int(:tun_metadata48), do: 0x58
  def nxm_1_to_int(:tun_metadata49), do: 0x59
  def nxm_1_to_int(:tun_metadata50), do: 0x5A
  def nxm_1_to_int(:tun_metadata51), do: 0x5B
  def nxm_1_to_int(:tun_metadata52), do: 0x5C
  def nxm_1_to_int(:tun_metadata53), do: 0x5D
  def nxm_1_to_int(:tun_metadata54), do: 0x5E
  def nxm_1_to_int(:tun_metadata55), do: 0x5F
  def nxm_1_to_int(:tun_metadata56), do: 0x60
  def nxm_1_to_int(:tun_metadata57), do: 0x61
  def nxm_1_to_int(:tun_metadata58), do: 0x62
  def nxm_1_to_int(:tun_metadata59), do: 0x63
  def nxm_1_to_int(:tun_metadata60), do: 0x64
  def nxm_1_to_int(:tun_metadata61), do: 0x65
  def nxm_1_to_int(:tun_metadata62), do: 0x66
  def nxm_1_to_int(:tun_metadata63), do: 0x67
  def nxm_1_to_int(:tun_flags), do: 0x68
  def nxm_1_to_int(:ct_state), do: 0x69
  def nxm_1_to_int(:ct_zone), do: 0x6A
  def nxm_1_to_int(:ct_mark), do: 0x6B
  def nxm_1_to_int(:ct_label), do: 0x6C
  def nxm_1_to_int(:tun_ipv6_src), do: 0x6D
  def nxm_1_to_int(:tun_ipv6_dst), do: 0x6E
  def nxm_1_to_int(:xxreg0), do: 0x6F
  def nxm_1_to_int(:xxreg1), do: 0x70
  def nxm_1_to_int(:xxreg2), do: 0x71
  def nxm_1_to_int(:xxreg3), do: 0x72
  def nxm_1_to_int(:xxreg4), do: 0x73
  def nxm_1_to_int(:xxreg5), do: 0x74
  def nxm_1_to_int(:xxreg6), do: 0x75
  def nxm_1_to_int(:xxreg7), do: 0x76
  def nxm_1_to_int(:ct_nw_proto), do: 0x77
  def nxm_1_to_int(:ct_nw_src), do: 0x78
  def nxm_1_to_int(:ct_nw_dst), do: 0x79
  def nxm_1_to_int(:ct_ipv6_src), do: 0x7A
  def nxm_1_to_int(:ct_ipv6_dst), do: 0x7B
  def nxm_1_to_int(:ct_tp_src), do: 0x7C
  def nxm_1_to_int(:ct_tp_dst), do: 0x7D
  def nxm_1_to_int(_), do: throw(:bad_enum)
  def nxm_1_to_atom(0x0), do: :reg0
  def nxm_1_to_atom(0x1), do: :reg1
  def nxm_1_to_atom(0x2), do: :reg2
  def nxm_1_to_atom(0x3), do: :reg3
  def nxm_1_to_atom(0x4), do: :reg4
  def nxm_1_to_atom(0x5), do: :reg5
  def nxm_1_to_atom(0x6), do: :reg6
  def nxm_1_to_atom(0x7), do: :reg7
  def nxm_1_to_atom(0x8), do: :reg8
  def nxm_1_to_atom(0x9), do: :reg9
  def nxm_1_to_atom(0xA), do: :reg10
  def nxm_1_to_atom(0xB), do: :reg11
  def nxm_1_to_atom(0xC), do: :reg12
  def nxm_1_to_atom(0xD), do: :reg13
  def nxm_1_to_atom(0xE), do: :reg14
  def nxm_1_to_atom(0xF), do: :reg15
  def nxm_1_to_atom(0x10), do: :tun_id
  def nxm_1_to_atom(0x11), do: :nx_arp_sha
  def nxm_1_to_atom(0x12), do: :nx_arp_tha
  def nxm_1_to_atom(0x13), do: :nx_ipv6_src
  def nxm_1_to_atom(0x14), do: :nx_ipv6_dst
  def nxm_1_to_atom(0x15), do: :nx_icmpv6_type
  def nxm_1_to_atom(0x16), do: :nx_icmpv6_code
  def nxm_1_to_atom(0x17), do: :nx_ipv6_nd_target
  def nxm_1_to_atom(0x18), do: :nx_ipv6_nd_sll
  def nxm_1_to_atom(0x19), do: :nx_ipv6_nd_tll
  def nxm_1_to_atom(0x1A), do: :nx_ip_frag
  def nxm_1_to_atom(0x1B), do: :nx_ipv6_label
  def nxm_1_to_atom(0x1C), do: :nx_ip_ecn
  def nxm_1_to_atom(0x1D), do: :nx_ip_ttl
  def nxm_1_to_atom(0x1E), do: :nx_mpls_ttl
  def nxm_1_to_atom(0x1F), do: :tun_src
  def nxm_1_to_atom(0x20), do: :tun_dst
  def nxm_1_to_atom(0x21), do: :pkt_mark
  def nxm_1_to_atom(0x23), do: :dp_hash
  def nxm_1_to_atom(0x24), do: :recirc_id
  def nxm_1_to_atom(0x25), do: :conj_id
  def nxm_1_to_atom(0x26), do: :tun_gbp_id
  def nxm_1_to_atom(0x27), do: :tun_gbp_flags
  def nxm_1_to_atom(0x28), do: :tun_metadata0
  def nxm_1_to_atom(0x29), do: :tun_metadata1
  def nxm_1_to_atom(0x2A), do: :tun_metadata2
  def nxm_1_to_atom(0x2B), do: :tun_metadata3
  def nxm_1_to_atom(0x2C), do: :tun_metadata4
  def nxm_1_to_atom(0x2D), do: :tun_metadata5
  def nxm_1_to_atom(0x2E), do: :tun_metadata6
  def nxm_1_to_atom(0x2F), do: :tun_metadata7
  def nxm_1_to_atom(0x30), do: :tun_metadata8
  def nxm_1_to_atom(0x31), do: :tun_metadata9
  def nxm_1_to_atom(0x32), do: :tun_metadata10
  def nxm_1_to_atom(0x33), do: :tun_metadata11
  def nxm_1_to_atom(0x34), do: :tun_metadata12
  def nxm_1_to_atom(0x35), do: :tun_metadata13
  def nxm_1_to_atom(0x36), do: :tun_metadata14
  def nxm_1_to_atom(0x37), do: :tun_metadata15
  def nxm_1_to_atom(0x38), do: :tun_metadata16
  def nxm_1_to_atom(0x39), do: :tun_metadata17
  def nxm_1_to_atom(0x3A), do: :tun_metadata18
  def nxm_1_to_atom(0x3B), do: :tun_metadata19
  def nxm_1_to_atom(0x3C), do: :tun_metadata20
  def nxm_1_to_atom(0x3D), do: :tun_metadata21
  def nxm_1_to_atom(0x3E), do: :tun_metadata22
  def nxm_1_to_atom(0x3F), do: :tun_metadata23
  def nxm_1_to_atom(0x40), do: :tun_metadata24
  def nxm_1_to_atom(0x41), do: :tun_metadata25
  def nxm_1_to_atom(0x42), do: :tun_metadata26
  def nxm_1_to_atom(0x43), do: :tun_metadata27
  def nxm_1_to_atom(0x44), do: :tun_metadata28
  def nxm_1_to_atom(0x45), do: :tun_metadata29
  def nxm_1_to_atom(0x46), do: :tun_metadata30
  def nxm_1_to_atom(0x47), do: :tun_metadata31
  def nxm_1_to_atom(0x48), do: :tun_metadata32
  def nxm_1_to_atom(0x49), do: :tun_metadata33
  def nxm_1_to_atom(0x4A), do: :tun_metadata34
  def nxm_1_to_atom(0x4B), do: :tun_metadata35
  def nxm_1_to_atom(0x4C), do: :tun_metadata36
  def nxm_1_to_atom(0x4D), do: :tun_metadata37
  def nxm_1_to_atom(0x4E), do: :tun_metadata38
  def nxm_1_to_atom(0x4F), do: :tun_metadata39
  def nxm_1_to_atom(0x50), do: :tun_metadata40
  def nxm_1_to_atom(0x51), do: :tun_metadata41
  def nxm_1_to_atom(0x52), do: :tun_metadata42
  def nxm_1_to_atom(0x53), do: :tun_metadata43
  def nxm_1_to_atom(0x54), do: :tun_metadata44
  def nxm_1_to_atom(0x55), do: :tun_metadata45
  def nxm_1_to_atom(0x56), do: :tun_metadata46
  def nxm_1_to_atom(0x57), do: :tun_metadata47
  def nxm_1_to_atom(0x58), do: :tun_metadata48
  def nxm_1_to_atom(0x59), do: :tun_metadata49
  def nxm_1_to_atom(0x5A), do: :tun_metadata50
  def nxm_1_to_atom(0x5B), do: :tun_metadata51
  def nxm_1_to_atom(0x5C), do: :tun_metadata52
  def nxm_1_to_atom(0x5D), do: :tun_metadata53
  def nxm_1_to_atom(0x5E), do: :tun_metadata54
  def nxm_1_to_atom(0x5F), do: :tun_metadata55
  def nxm_1_to_atom(0x60), do: :tun_metadata56
  def nxm_1_to_atom(0x61), do: :tun_metadata57
  def nxm_1_to_atom(0x62), do: :tun_metadata58
  def nxm_1_to_atom(0x63), do: :tun_metadata59
  def nxm_1_to_atom(0x64), do: :tun_metadata60
  def nxm_1_to_atom(0x65), do: :tun_metadata61
  def nxm_1_to_atom(0x66), do: :tun_metadata62
  def nxm_1_to_atom(0x67), do: :tun_metadata63
  def nxm_1_to_atom(0x68), do: :tun_flags
  def nxm_1_to_atom(0x69), do: :ct_state
  def nxm_1_to_atom(0x6A), do: :ct_zone
  def nxm_1_to_atom(0x6B), do: :ct_mark
  def nxm_1_to_atom(0x6C), do: :ct_label
  def nxm_1_to_atom(0x6D), do: :tun_ipv6_src
  def nxm_1_to_atom(0x6E), do: :tun_ipv6_dst
  def nxm_1_to_atom(0x6F), do: :xxreg0
  def nxm_1_to_atom(0x70), do: :xxreg1
  def nxm_1_to_atom(0x71), do: :xxreg2
  def nxm_1_to_atom(0x72), do: :xxreg3
  def nxm_1_to_atom(0x73), do: :xxreg4
  def nxm_1_to_atom(0x74), do: :xxreg5
  def nxm_1_to_atom(0x75), do: :xxreg6
  def nxm_1_to_atom(0x76), do: :xxreg7
  def nxm_1_to_atom(0x77), do: :ct_nw_proto
  def nxm_1_to_atom(0x78), do: :ct_nw_src
  def nxm_1_to_atom(0x79), do: :ct_nw_dst
  def nxm_1_to_atom(0x7A), do: :ct_ipv6_src
  def nxm_1_to_atom(0x7B), do: :ct_ipv6_dst
  def nxm_1_to_atom(0x7C), do: :ct_tp_src
  def nxm_1_to_atom(0x7D), do: :ct_tp_dst
  def nxm_1_to_atom(_), do: throw(:bad_enum)
  def openflow_basic_to_int(:in_port), do: 0x0
  def openflow_basic_to_int(:in_phy_port), do: 0x1
  def openflow_basic_to_int(:metadata), do: 0x2
  def openflow_basic_to_int(:eth_dst), do: 0x3
  def openflow_basic_to_int(:eth_src), do: 0x4
  def openflow_basic_to_int(:eth_type), do: 0x5
  def openflow_basic_to_int(:vlan_vid), do: 0x6
  def openflow_basic_to_int(:vlan_pcp), do: 0x7
  def openflow_basic_to_int(:ip_dscp), do: 0x8
  def openflow_basic_to_int(:ip_ecn), do: 0x9
  def openflow_basic_to_int(:ip_proto), do: 0xA
  def openflow_basic_to_int(:ipv4_src), do: 0xB
  def openflow_basic_to_int(:ipv4_dst), do: 0xC
  def openflow_basic_to_int(:tcp_src), do: 0xD
  def openflow_basic_to_int(:tcp_dst), do: 0xE
  def openflow_basic_to_int(:udp_src), do: 0xF
  def openflow_basic_to_int(:udp_dst), do: 0x10
  def openflow_basic_to_int(:sctp_src), do: 0x11
  def openflow_basic_to_int(:sctp_dst), do: 0x12
  def openflow_basic_to_int(:icmpv4_type), do: 0x13
  def openflow_basic_to_int(:icmpv4_code), do: 0x14
  def openflow_basic_to_int(:arp_op), do: 0x15
  def openflow_basic_to_int(:arp_spa), do: 0x16
  def openflow_basic_to_int(:arp_tpa), do: 0x17
  def openflow_basic_to_int(:arp_sha), do: 0x18
  def openflow_basic_to_int(:arp_tha), do: 0x19
  def openflow_basic_to_int(:ipv6_src), do: 0x1A
  def openflow_basic_to_int(:ipv6_dst), do: 0x1B
  def openflow_basic_to_int(:ipv6_flabel), do: 0x1C
  def openflow_basic_to_int(:icmpv6_type), do: 0x1D
  def openflow_basic_to_int(:icmpv6_code), do: 0x1E
  def openflow_basic_to_int(:ipv6_nd_target), do: 0x1F
  def openflow_basic_to_int(:ipv6_nd_sll), do: 0x20
  def openflow_basic_to_int(:ipv6_nd_tll), do: 0x21
  def openflow_basic_to_int(:mpls_label), do: 0x22
  def openflow_basic_to_int(:mpls_tc), do: 0x23
  def openflow_basic_to_int(:mpls_bos), do: 0x24
  def openflow_basic_to_int(:pbb_isid), do: 0x25
  def openflow_basic_to_int(:tunnel_id), do: 0x26
  def openflow_basic_to_int(:ipv6_exthdr), do: 0x27
  def openflow_basic_to_int(:pbb_uca), do: 0x29
  def openflow_basic_to_int(:packet_type), do: 0x2A
  def openflow_basic_to_int(:gre_flags), do: 0x2B
  def openflow_basic_to_int(:gre_ver), do: 0x2C
  def openflow_basic_to_int(:gre_protocol), do: 0x2D
  def openflow_basic_to_int(:gre_key), do: 0x2E
  def openflow_basic_to_int(:gre_seqnum), do: 0x2F
  def openflow_basic_to_int(:lisp_flags), do: 0x30
  def openflow_basic_to_int(:lisp_nonce), do: 0x31
  def openflow_basic_to_int(:lisp_id), do: 0x32
  def openflow_basic_to_int(:vxlan_flags), do: 0x33
  def openflow_basic_to_int(:vxlan_vni), do: 0x34
  def openflow_basic_to_int(:mpls_data_first_nibble), do: 0x35
  def openflow_basic_to_int(:mpls_ach_version), do: 0x36
  def openflow_basic_to_int(:mpls_ach_channel), do: 0x37
  def openflow_basic_to_int(:mpls_pw_metadata), do: 0x38
  def openflow_basic_to_int(:mpls_cw_flags), do: 0x39
  def openflow_basic_to_int(:mpls_cw_fragment), do: 0x3A
  def openflow_basic_to_int(:mpls_cw_len), do: 0x3B
  def openflow_basic_to_int(:mpls_cw_seq_num), do: 0x3C
  def openflow_basic_to_int(:gtpu_flags), do: 0x3D
  def openflow_basic_to_int(:gtpu_ver), do: 0x3E
  def openflow_basic_to_int(:gtpu_msg_type), do: 0x3F
  def openflow_basic_to_int(:gtpu_teid), do: 0x40
  def openflow_basic_to_int(:gtpu_extn_hdr), do: 0x41
  def openflow_basic_to_int(:gtpu_extn_udp_port), do: 0x42
  def openflow_basic_to_int(:gtpu_extn_sci), do: 0x43
  def openflow_basic_to_int(_), do: throw(:bad_enum)
  def openflow_basic_to_atom(0x0), do: :in_port
  def openflow_basic_to_atom(0x1), do: :in_phy_port
  def openflow_basic_to_atom(0x2), do: :metadata
  def openflow_basic_to_atom(0x3), do: :eth_dst
  def openflow_basic_to_atom(0x4), do: :eth_src
  def openflow_basic_to_atom(0x5), do: :eth_type
  def openflow_basic_to_atom(0x6), do: :vlan_vid
  def openflow_basic_to_atom(0x7), do: :vlan_pcp
  def openflow_basic_to_atom(0x8), do: :ip_dscp
  def openflow_basic_to_atom(0x9), do: :ip_ecn
  def openflow_basic_to_atom(0xA), do: :ip_proto
  def openflow_basic_to_atom(0xB), do: :ipv4_src
  def openflow_basic_to_atom(0xC), do: :ipv4_dst
  def openflow_basic_to_atom(0xD), do: :tcp_src
  def openflow_basic_to_atom(0xE), do: :tcp_dst
  def openflow_basic_to_atom(0xF), do: :udp_src
  def openflow_basic_to_atom(0x10), do: :udp_dst
  def openflow_basic_to_atom(0x11), do: :sctp_src
  def openflow_basic_to_atom(0x12), do: :sctp_dst
  def openflow_basic_to_atom(0x13), do: :icmpv4_type
  def openflow_basic_to_atom(0x14), do: :icmpv4_code
  def openflow_basic_to_atom(0x15), do: :arp_op
  def openflow_basic_to_atom(0x16), do: :arp_spa
  def openflow_basic_to_atom(0x17), do: :arp_tpa
  def openflow_basic_to_atom(0x18), do: :arp_sha
  def openflow_basic_to_atom(0x19), do: :arp_tha
  def openflow_basic_to_atom(0x1A), do: :ipv6_src
  def openflow_basic_to_atom(0x1B), do: :ipv6_dst
  def openflow_basic_to_atom(0x1C), do: :ipv6_flabel
  def openflow_basic_to_atom(0x1D), do: :icmpv6_type
  def openflow_basic_to_atom(0x1E), do: :icmpv6_code
  def openflow_basic_to_atom(0x1F), do: :ipv6_nd_target
  def openflow_basic_to_atom(0x20), do: :ipv6_nd_sll
  def openflow_basic_to_atom(0x21), do: :ipv6_nd_tll
  def openflow_basic_to_atom(0x22), do: :mpls_label
  def openflow_basic_to_atom(0x23), do: :mpls_tc
  def openflow_basic_to_atom(0x24), do: :mpls_bos
  def openflow_basic_to_atom(0x25), do: :pbb_isid
  def openflow_basic_to_atom(0x26), do: :tunnel_id
  def openflow_basic_to_atom(0x27), do: :ipv6_exthdr
  def openflow_basic_to_atom(0x29), do: :pbb_uca
  def openflow_basic_to_atom(0x2A), do: :packet_type
  def openflow_basic_to_atom(0x2B), do: :gre_flags
  def openflow_basic_to_atom(0x2C), do: :gre_ver
  def openflow_basic_to_atom(0x2D), do: :gre_protocol
  def openflow_basic_to_atom(0x2E), do: :gre_key
  def openflow_basic_to_atom(0x2F), do: :gre_seqnum
  def openflow_basic_to_atom(0x30), do: :lisp_flags
  def openflow_basic_to_atom(0x31), do: :lisp_nonce
  def openflow_basic_to_atom(0x32), do: :lisp_id
  def openflow_basic_to_atom(0x33), do: :vxlan_flags
  def openflow_basic_to_atom(0x34), do: :vxlan_vni
  def openflow_basic_to_atom(0x35), do: :mpls_data_first_nibble
  def openflow_basic_to_atom(0x36), do: :mpls_ach_version
  def openflow_basic_to_atom(0x37), do: :mpls_ach_channel
  def openflow_basic_to_atom(0x38), do: :mpls_pw_metadata
  def openflow_basic_to_atom(0x39), do: :mpls_cw_flags
  def openflow_basic_to_atom(0x3A), do: :mpls_cw_fragment
  def openflow_basic_to_atom(0x3B), do: :mpls_cw_len
  def openflow_basic_to_atom(0x3C), do: :mpls_cw_seq_num
  def openflow_basic_to_atom(0x3D), do: :gtpu_flags
  def openflow_basic_to_atom(0x3E), do: :gtpu_ver
  def openflow_basic_to_atom(0x3F), do: :gtpu_msg_type
  def openflow_basic_to_atom(0x40), do: :gtpu_teid
  def openflow_basic_to_atom(0x41), do: :gtpu_extn_hdr
  def openflow_basic_to_atom(0x42), do: :gtpu_extn_udp_port
  def openflow_basic_to_atom(0x43), do: :gtpu_extn_sci
  def openflow_basic_to_atom(_), do: throw(:bad_enum)
  def vlan_id_to_int(:present), do: 0x1000
  def vlan_id_to_int(:none), do: 0x0
  def vlan_id_to_int(_), do: throw(:bad_enum)
  def vlan_id_to_atom(0x1000), do: :present
  def vlan_id_to_atom(0x0), do: :none
  def vlan_id_to_atom(_), do: throw(:bad_enum)
  def ipv6exthdr_flags_to_int(:nonext), do: 0x1
  def ipv6exthdr_flags_to_int(:esp), do: 0x2
  def ipv6exthdr_flags_to_int(:auth), do: 0x4
  def ipv6exthdr_flags_to_int(:dest), do: 0x8
  def ipv6exthdr_flags_to_int(:frag), do: 0x10
  def ipv6exthdr_flags_to_int(:router), do: 0x20
  def ipv6exthdr_flags_to_int(:hop), do: 0x40
  def ipv6exthdr_flags_to_int(:unrep), do: 0x80
  def ipv6exthdr_flags_to_int(:unseq), do: 0x100
  def ipv6exthdr_flags_to_int(_), do: throw(:bad_enum)
  def ipv6exthdr_flags_to_atom(0x1), do: :nonext
  def ipv6exthdr_flags_to_atom(0x2), do: :esp
  def ipv6exthdr_flags_to_atom(0x4), do: :auth
  def ipv6exthdr_flags_to_atom(0x8), do: :dest
  def ipv6exthdr_flags_to_atom(0x10), do: :frag
  def ipv6exthdr_flags_to_atom(0x20), do: :router
  def ipv6exthdr_flags_to_atom(0x40), do: :hop
  def ipv6exthdr_flags_to_atom(0x80), do: :unrep
  def ipv6exthdr_flags_to_atom(0x100), do: :unseq
  def ipv6exthdr_flags_to_atom(_), do: throw(:bad_enum)
  def tcp_flags_to_int(:fin), do: 0x1
  def tcp_flags_to_int(:syn), do: 0x2
  def tcp_flags_to_int(:rst), do: 0x4
  def tcp_flags_to_int(:psh), do: 0x8
  def tcp_flags_to_int(:ack), do: 0x10
  def tcp_flags_to_int(:urg), do: 0x20
  def tcp_flags_to_int(:ece), do: 0x40
  def tcp_flags_to_int(:cwr), do: 0x80
  def tcp_flags_to_int(:ns), do: 0x100
  def tcp_flags_to_int(_), do: throw(:bad_enum)
  def tcp_flags_to_atom(0x1), do: :fin
  def tcp_flags_to_atom(0x2), do: :syn
  def tcp_flags_to_atom(0x4), do: :rst
  def tcp_flags_to_atom(0x8), do: :psh
  def tcp_flags_to_atom(0x10), do: :ack
  def tcp_flags_to_atom(0x20), do: :urg
  def tcp_flags_to_atom(0x40), do: :ece
  def tcp_flags_to_atom(0x80), do: :cwr
  def tcp_flags_to_atom(0x100), do: :ns
  def tcp_flags_to_atom(_), do: throw(:bad_enum)
  def ct_state_flags_to_int(:new), do: 0x1
  def ct_state_flags_to_int(:est), do: 0x2
  def ct_state_flags_to_int(:rel), do: 0x4
  def ct_state_flags_to_int(:rep), do: 0x8
  def ct_state_flags_to_int(:inv), do: 0x10
  def ct_state_flags_to_int(:trk), do: 0x20
  def ct_state_flags_to_int(:snat), do: 0x40
  def ct_state_flags_to_int(:dnat), do: 0x80
  def ct_state_flags_to_int(_), do: throw(:bad_enum)
  def ct_state_flags_to_atom(0x1), do: :new
  def ct_state_flags_to_atom(0x2), do: :est
  def ct_state_flags_to_atom(0x4), do: :rel
  def ct_state_flags_to_atom(0x8), do: :rep
  def ct_state_flags_to_atom(0x10), do: :inv
  def ct_state_flags_to_atom(0x20), do: :trk
  def ct_state_flags_to_atom(0x40), do: :snat
  def ct_state_flags_to_atom(0x80), do: :dnat
  def ct_state_flags_to_atom(_), do: throw(:bad_enum)
  def packet_register_to_int(:xreg0), do: 0x0
  def packet_register_to_int(:xreg1), do: 0x1
  def packet_register_to_int(:xreg2), do: 0x2
  def packet_register_to_int(:xreg3), do: 0x3
  def packet_register_to_int(:xreg4), do: 0x4
  def packet_register_to_int(:xreg5), do: 0x5
  def packet_register_to_int(:xreg6), do: 0x6
  def packet_register_to_int(:xreg7), do: 0x7
  def packet_register_to_int(_), do: throw(:bad_enum)
  def packet_register_to_atom(0x0), do: :xreg0
  def packet_register_to_atom(0x1), do: :xreg1
  def packet_register_to_atom(0x2), do: :xreg2
  def packet_register_to_atom(0x3), do: :xreg3
  def packet_register_to_atom(0x4), do: :xreg4
  def packet_register_to_atom(0x5), do: :xreg5
  def packet_register_to_atom(0x6), do: :xreg6
  def packet_register_to_atom(0x7), do: :xreg7
  def packet_register_to_atom(_), do: throw(:bad_enum)
  def nicira_ext_match_to_int(:nsh_flags), do: 0x1
  def nicira_ext_match_to_int(:nsh_mdtype), do: 0x2
  def nicira_ext_match_to_int(:nsh_np), do: 0x3
  def nicira_ext_match_to_int(:nsh_spi), do: 0x4
  def nicira_ext_match_to_int(:nsh_si), do: 0x5
  def nicira_ext_match_to_int(:nsh_c1), do: 0x6
  def nicira_ext_match_to_int(:nsh_c2), do: 0x7
  def nicira_ext_match_to_int(:nsh_c3), do: 0x8
  def nicira_ext_match_to_int(:nsh_c4), do: 0x9
  def nicira_ext_match_to_int(_), do: throw(:bad_enum)
  def nicira_ext_match_to_atom(0x1), do: :nsh_flags
  def nicira_ext_match_to_atom(0x2), do: :nsh_mdtype
  def nicira_ext_match_to_atom(0x3), do: :nsh_np
  def nicira_ext_match_to_atom(0x4), do: :nsh_spi
  def nicira_ext_match_to_atom(0x5), do: :nsh_si
  def nicira_ext_match_to_atom(0x6), do: :nsh_c1
  def nicira_ext_match_to_atom(0x7), do: :nsh_c2
  def nicira_ext_match_to_atom(0x8), do: :nsh_c3
  def nicira_ext_match_to_atom(0x9), do: :nsh_c4
  def nicira_ext_match_to_atom(_), do: throw(:bad_enum)
  def hp_ext_match_to_int(:hp_udp_src_port_range), do: 0x0
  def hp_ext_match_to_int(:hp_udp_dst_port_range), do: 0x1
  def hp_ext_match_to_int(:hp_tcp_src_port_range), do: 0x2
  def hp_ext_match_to_int(:hp_tcp_dst_port_range), do: 0x3
  def hp_ext_match_to_int(:hp_tcp_flags), do: 0x4
  def hp_ext_match_to_int(:hp_custom_1), do: 0x5
  def hp_ext_match_to_int(:hp_custom_2), do: 0x6
  def hp_ext_match_to_int(:hp_custom_3), do: 0x7
  def hp_ext_match_to_int(:hp_custom_4), do: 0x8
  def hp_ext_match_to_int(_), do: throw(:bad_enum)
  def hp_ext_match_to_atom(0x0), do: :hp_udp_src_port_range
  def hp_ext_match_to_atom(0x1), do: :hp_udp_dst_port_range
  def hp_ext_match_to_atom(0x2), do: :hp_tcp_src_port_range
  def hp_ext_match_to_atom(0x3), do: :hp_tcp_dst_port_range
  def hp_ext_match_to_atom(0x4), do: :hp_tcp_flags
  def hp_ext_match_to_atom(0x5), do: :hp_custom_1
  def hp_ext_match_to_atom(0x6), do: :hp_custom_2
  def hp_ext_match_to_atom(0x7), do: :hp_custom_3
  def hp_ext_match_to_atom(0x8), do: :hp_custom_4
  def hp_ext_match_to_atom(_), do: throw(:bad_enum)
  def hp_custom_match_type_to_int(:l2_start), do: 0x1
  def hp_custom_match_type_to_int(:l3_start), do: 0x2
  def hp_custom_match_type_to_int(:l4_start), do: 0x3
  def hp_custom_match_type_to_int(_), do: throw(:bad_enum)
  def hp_custom_match_type_to_atom(0x1), do: :l2_start
  def hp_custom_match_type_to_atom(0x2), do: :l3_start
  def hp_custom_match_type_to_atom(0x3), do: :l4_start
  def hp_custom_match_type_to_atom(_), do: throw(:bad_enum)
  def onf_ext_match_to_int(:onf_tcp_flags), do: 0x2A
  def onf_ext_match_to_int(:onf_actset_output), do: 0x2B
  def onf_ext_match_to_int(:onf_pbb_uca), do: 0xA00
  def onf_ext_match_to_int(_), do: throw(:bad_enum)
  def onf_ext_match_to_atom(0x2A), do: :onf_tcp_flags
  def onf_ext_match_to_atom(0x2B), do: :onf_actset_output
  def onf_ext_match_to_atom(0xA00), do: :onf_pbb_uca
  def onf_ext_match_to_atom(_), do: throw(:bad_enum)
  def buffer_id_to_int(:no_buffer), do: 0xFFFFFFFF
  def buffer_id_to_int(_), do: throw(:bad_enum)
  def buffer_id_to_atom(0xFFFFFFFF), do: :no_buffer
  def buffer_id_to_atom(_), do: throw(:bad_enum)
  def port_config_to_int(:port_down), do: 0x1
  def port_config_to_int(:no_receive), do: 0x4
  def port_config_to_int(:no_forward), do: 0x20
  def port_config_to_int(:no_packet_in), do: 0x40
  def port_config_to_int(_), do: throw(:bad_enum)
  def port_config_to_atom(0x1), do: :port_down
  def port_config_to_atom(0x4), do: :no_receive
  def port_config_to_atom(0x20), do: :no_forward
  def port_config_to_atom(0x40), do: :no_packet_in
  def port_config_to_atom(_), do: throw(:bad_enum)
  def port_state_to_int(:link_down), do: 0x1
  def port_state_to_int(:blocked), do: 0x2
  def port_state_to_int(:live), do: 0x4
  def port_state_to_int(_), do: throw(:bad_enum)
  def port_state_to_atom(0x1), do: :link_down
  def port_state_to_atom(0x2), do: :blocked
  def port_state_to_atom(0x4), do: :live
  def port_state_to_atom(_), do: throw(:bad_enum)
  def port_features_to_int(:"10mb_hd"), do: 0x1
  def port_features_to_int(:"10mb_fd"), do: 0x2
  def port_features_to_int(:"100mb_hd"), do: 0x4
  def port_features_to_int(:"100mb_fd"), do: 0x8
  def port_features_to_int(:"1gb_hd"), do: 0x10
  def port_features_to_int(:"1gb_fd"), do: 0x20
  def port_features_to_int(:"10gb_fd"), do: 0x40
  def port_features_to_int(:"40gb_fd"), do: 0x80
  def port_features_to_int(:"100gb_fd"), do: 0x100
  def port_features_to_int(:"1tb_fd"), do: 0x200
  def port_features_to_int(:other), do: 0x400
  def port_features_to_int(:copper), do: 0x800
  def port_features_to_int(:fiber), do: 0x1000
  def port_features_to_int(:autoneg), do: 0x2000
  def port_features_to_int(:pause), do: 0x4000
  def port_features_to_int(:pause_asym), do: 0x8000
  def port_features_to_int(_), do: throw(:bad_enum)
  def port_features_to_atom(0x1), do: :"10mb_hd"
  def port_features_to_atom(0x2), do: :"10mb_fd"
  def port_features_to_atom(0x4), do: :"100mb_hd"
  def port_features_to_atom(0x8), do: :"100mb_fd"
  def port_features_to_atom(0x10), do: :"1gb_hd"
  def port_features_to_atom(0x20), do: :"1gb_fd"
  def port_features_to_atom(0x40), do: :"10gb_fd"
  def port_features_to_atom(0x80), do: :"40gb_fd"
  def port_features_to_atom(0x100), do: :"100gb_fd"
  def port_features_to_atom(0x200), do: :"1tb_fd"
  def port_features_to_atom(0x400), do: :other
  def port_features_to_atom(0x800), do: :copper
  def port_features_to_atom(0x1000), do: :fiber
  def port_features_to_atom(0x2000), do: :autoneg
  def port_features_to_atom(0x4000), do: :pause
  def port_features_to_atom(0x8000), do: :pause_asym
  def port_features_to_atom(_), do: throw(:bad_enum)
  def openflow10_port_no_to_int(:max), do: 0xFF00
  def openflow10_port_no_to_int(:in_port), do: 0xFFF8
  def openflow10_port_no_to_int(:table), do: 0xFFF9
  def openflow10_port_no_to_int(:normal), do: 0xFFFA
  def openflow10_port_no_to_int(:flood), do: 0xFFFB
  def openflow10_port_no_to_int(:all), do: 0xFFFC
  def openflow10_port_no_to_int(:controller), do: 0xFFFD
  def openflow10_port_no_to_int(:local), do: 0xFFFE
  def openflow10_port_no_to_int(:none), do: 0xFFFF
  def openflow10_port_no_to_int(_), do: throw(:bad_enum)
  def openflow10_port_no_to_atom(0xFF00), do: :max
  def openflow10_port_no_to_atom(0xFFF8), do: :in_port
  def openflow10_port_no_to_atom(0xFFF9), do: :table
  def openflow10_port_no_to_atom(0xFFFA), do: :normal
  def openflow10_port_no_to_atom(0xFFFB), do: :flood
  def openflow10_port_no_to_atom(0xFFFC), do: :all
  def openflow10_port_no_to_atom(0xFFFD), do: :controller
  def openflow10_port_no_to_atom(0xFFFE), do: :local
  def openflow10_port_no_to_atom(0xFFFF), do: :none
  def openflow10_port_no_to_atom(_), do: throw(:bad_enum)
  def openflow13_port_no_to_int(:max), do: 0xFFFFFF00
  def openflow13_port_no_to_int(:in_port), do: 0xFFFFFFF8
  def openflow13_port_no_to_int(:table), do: 0xFFFFFFF9
  def openflow13_port_no_to_int(:normal), do: 0xFFFFFFFA
  def openflow13_port_no_to_int(:flood), do: 0xFFFFFFFB
  def openflow13_port_no_to_int(:all), do: 0xFFFFFFFC
  def openflow13_port_no_to_int(:controller), do: 0xFFFFFFFD
  def openflow13_port_no_to_int(:local), do: 0xFFFFFFFE
  def openflow13_port_no_to_int(:any), do: 0xFFFFFFFF
  def openflow13_port_no_to_int(_), do: throw(:bad_enum)
  def openflow13_port_no_to_atom(0xFFFFFF00), do: :max
  def openflow13_port_no_to_atom(0xFFFFFFF8), do: :in_port
  def openflow13_port_no_to_atom(0xFFFFFFF9), do: :table
  def openflow13_port_no_to_atom(0xFFFFFFFA), do: :normal
  def openflow13_port_no_to_atom(0xFFFFFFFB), do: :flood
  def openflow13_port_no_to_atom(0xFFFFFFFC), do: :all
  def openflow13_port_no_to_atom(0xFFFFFFFD), do: :controller
  def openflow13_port_no_to_atom(0xFFFFFFFE), do: :local
  def openflow13_port_no_to_atom(0xFFFFFFFF), do: :any
  def openflow13_port_no_to_atom(_), do: throw(:bad_enum)
  def packet_in_reason_to_int(:no_match), do: 0x0
  def packet_in_reason_to_int(:action), do: 0x1
  def packet_in_reason_to_int(:invalid_ttl), do: 0x2
  def packet_in_reason_to_int(:action_set), do: 0x3
  def packet_in_reason_to_int(:group), do: 0x4
  def packet_in_reason_to_int(:packet_out), do: 0x5
  def packet_in_reason_to_int(_), do: throw(:bad_enum)
  def packet_in_reason_to_atom(0x0), do: :no_match
  def packet_in_reason_to_atom(0x1), do: :action
  def packet_in_reason_to_atom(0x2), do: :invalid_ttl
  def packet_in_reason_to_atom(0x3), do: :action_set
  def packet_in_reason_to_atom(0x4), do: :group
  def packet_in_reason_to_atom(0x5), do: :packet_out
  def packet_in_reason_to_atom(_), do: throw(:bad_enum)
  def packet_in_reason_mask_to_int(:no_match), do: 0x1
  def packet_in_reason_mask_to_int(:action), do: 0x2
  def packet_in_reason_mask_to_int(:invalid_ttl), do: 0x4
  def packet_in_reason_mask_to_int(:action_set), do: 0x8
  def packet_in_reason_mask_to_int(:group), do: 0x10
  def packet_in_reason_mask_to_int(:packet_out), do: 0x20
  def packet_in_reason_mask_to_int(_), do: throw(:bad_enum)
  def packet_in_reason_mask_to_atom(0x1), do: :no_match
  def packet_in_reason_mask_to_atom(0x2), do: :action
  def packet_in_reason_mask_to_atom(0x4), do: :invalid_ttl
  def packet_in_reason_mask_to_atom(0x8), do: :action_set
  def packet_in_reason_mask_to_atom(0x10), do: :group
  def packet_in_reason_mask_to_atom(0x20), do: :packet_out
  def packet_in_reason_mask_to_atom(_), do: throw(:bad_enum)
  def flow_mod_command_to_int(:add), do: 0x0
  def flow_mod_command_to_int(:modify), do: 0x1
  def flow_mod_command_to_int(:modify_strict), do: 0x2
  def flow_mod_command_to_int(:delete), do: 0x3
  def flow_mod_command_to_int(:delete_strict), do: 0x4
  def flow_mod_command_to_int(_), do: throw(:bad_enum)
  def flow_mod_command_to_atom(0x0), do: :add
  def flow_mod_command_to_atom(0x1), do: :modify
  def flow_mod_command_to_atom(0x2), do: :modify_strict
  def flow_mod_command_to_atom(0x3), do: :delete
  def flow_mod_command_to_atom(0x4), do: :delete_strict
  def flow_mod_command_to_atom(_), do: throw(:bad_enum)
  def flow_mod_flags_to_int(:send_flow_rem), do: 0x1
  def flow_mod_flags_to_int(:check_overlap), do: 0x2
  def flow_mod_flags_to_int(:reset_counts), do: 0x4
  def flow_mod_flags_to_int(:no_packet_counts), do: 0x8
  def flow_mod_flags_to_int(:no_byte_counts), do: 0x10
  def flow_mod_flags_to_int(_), do: throw(:bad_enum)
  def flow_mod_flags_to_atom(0x1), do: :send_flow_rem
  def flow_mod_flags_to_atom(0x2), do: :check_overlap
  def flow_mod_flags_to_atom(0x4), do: :reset_counts
  def flow_mod_flags_to_atom(0x8), do: :no_packet_counts
  def flow_mod_flags_to_atom(0x10), do: :no_byte_counts
  def flow_mod_flags_to_atom(_), do: throw(:bad_enum)
  def flow_removed_reason_to_int(:idle_timeout), do: 0x0
  def flow_removed_reason_to_int(:hard_timeout), do: 0x1
  def flow_removed_reason_to_int(:delete), do: 0x2
  def flow_removed_reason_to_int(:group_delete), do: 0x3
  def flow_removed_reason_to_int(:meter_delete), do: 0x4
  def flow_removed_reason_to_int(:eviction), do: 0x5
  def flow_removed_reason_to_int(_), do: throw(:bad_enum)
  def flow_removed_reason_to_atom(0x0), do: :idle_timeout
  def flow_removed_reason_to_atom(0x1), do: :hard_timeout
  def flow_removed_reason_to_atom(0x2), do: :delete
  def flow_removed_reason_to_atom(0x3), do: :group_delete
  def flow_removed_reason_to_atom(0x4), do: :meter_delete
  def flow_removed_reason_to_atom(0x5), do: :eviction
  def flow_removed_reason_to_atom(_), do: throw(:bad_enum)
  def flow_removed_reason_mask_to_int(:idle_timeout), do: 0x1
  def flow_removed_reason_mask_to_int(:hard_timeout), do: 0x2
  def flow_removed_reason_mask_to_int(:delete), do: 0x4
  def flow_removed_reason_mask_to_int(:group_delete), do: 0x8
  def flow_removed_reason_mask_to_int(:meter_delete), do: 0x10
  def flow_removed_reason_mask_to_int(:eviction), do: 0x20
  def flow_removed_reason_mask_to_int(_), do: throw(:bad_enum)
  def flow_removed_reason_mask_to_atom(0x1), do: :idle_timeout
  def flow_removed_reason_mask_to_atom(0x2), do: :hard_timeout
  def flow_removed_reason_mask_to_atom(0x4), do: :delete
  def flow_removed_reason_mask_to_atom(0x8), do: :group_delete
  def flow_removed_reason_mask_to_atom(0x10), do: :meter_delete
  def flow_removed_reason_mask_to_atom(0x20), do: :eviction
  def flow_removed_reason_mask_to_atom(_), do: throw(:bad_enum)
  def port_reason_to_int(:add), do: 0x0
  def port_reason_to_int(:delete), do: 0x1
  def port_reason_to_int(:modify), do: 0x2
  def port_reason_to_int(_), do: throw(:bad_enum)
  def port_reason_to_atom(0x0), do: :add
  def port_reason_to_atom(0x1), do: :delete
  def port_reason_to_atom(0x2), do: :modify
  def port_reason_to_atom(_), do: throw(:bad_enum)
  def port_reason_mask_to_int(:add), do: 0x1
  def port_reason_mask_to_int(:delete), do: 0x2
  def port_reason_mask_to_int(:modify), do: 0x4
  def port_reason_mask_to_int(_), do: throw(:bad_enum)
  def port_reason_mask_to_atom(0x1), do: :add
  def port_reason_mask_to_atom(0x2), do: :delete
  def port_reason_mask_to_atom(0x4), do: :modify
  def port_reason_mask_to_atom(_), do: throw(:bad_enum)
  def group_mod_command_to_int(:add), do: 0x0
  def group_mod_command_to_int(:modify), do: 0x1
  def group_mod_command_to_int(:delete), do: 0x2
  def group_mod_command_to_int(_), do: throw(:bad_enum)
  def group_mod_command_to_atom(0x0), do: :add
  def group_mod_command_to_atom(0x1), do: :modify
  def group_mod_command_to_atom(0x2), do: :delete
  def group_mod_command_to_atom(_), do: throw(:bad_enum)
  def group_type_to_int(:all), do: 0x0
  def group_type_to_int(:select), do: 0x1
  def group_type_to_int(:indirect), do: 0x2
  def group_type_to_int(:fast_failover), do: 0x3
  def group_type_to_int(_), do: throw(:bad_enum)
  def group_type_to_atom(0x0), do: :all
  def group_type_to_atom(0x1), do: :select
  def group_type_to_atom(0x2), do: :indirect
  def group_type_to_atom(0x3), do: :fast_failover
  def group_type_to_atom(_), do: throw(:bad_enum)
  def group_type_flags_to_int(:all), do: 0x1
  def group_type_flags_to_int(:select), do: 0x2
  def group_type_flags_to_int(:indirect), do: 0x4
  def group_type_flags_to_int(:fast_failover), do: 0x8
  def group_type_flags_to_int(_), do: throw(:bad_enum)
  def group_type_flags_to_atom(0x1), do: :all
  def group_type_flags_to_atom(0x2), do: :select
  def group_type_flags_to_atom(0x4), do: :indirect
  def group_type_flags_to_atom(0x8), do: :fast_failover
  def group_type_flags_to_atom(_), do: throw(:bad_enum)
  def group_id_to_int(:max), do: 0xFFFFFF00
  def group_id_to_int(:all), do: 0xFFFFFFFC
  def group_id_to_int(:any), do: 0xFFFFFFFF
  def group_id_to_int(_), do: throw(:bad_enum)
  def group_id_to_atom(0xFFFFFF00), do: :max
  def group_id_to_atom(0xFFFFFFFC), do: :all
  def group_id_to_atom(0xFFFFFFFF), do: :any
  def group_id_to_atom(_), do: throw(:bad_enum)
  def group_capabilities_to_int(:select_weight), do: 0x1
  def group_capabilities_to_int(:select_liveness), do: 0x2
  def group_capabilities_to_int(:chaining), do: 0x4
  def group_capabilities_to_int(:chaining_checks), do: 0x8
  def group_capabilities_to_int(_), do: throw(:bad_enum)
  def group_capabilities_to_atom(0x1), do: :select_weight
  def group_capabilities_to_atom(0x2), do: :select_liveness
  def group_capabilities_to_atom(0x4), do: :chaining
  def group_capabilities_to_atom(0x8), do: :chaining_checks
  def group_capabilities_to_atom(_), do: throw(:bad_enum)
  def table_id_to_int(:max), do: 0xFE
  def table_id_to_int(:all), do: 0xFF
  def table_id_to_int(_), do: throw(:bad_enum)
  def table_id_to_atom(0xFE), do: :max
  def table_id_to_atom(0xFF), do: :all
  def table_id_to_atom(_), do: throw(:bad_enum)
  def queue_id_to_int(:all), do: 0xFFFFFFFF
  def queue_id_to_int(_), do: throw(:bad_enum)
  def queue_id_to_atom(0xFFFFFFFF), do: :all
  def queue_id_to_atom(_), do: throw(:bad_enum)
  def meter_mod_command_to_int(:add), do: 0x0
  def meter_mod_command_to_int(:modify), do: 0x1
  def meter_mod_command_to_int(:delete), do: 0x2
  def meter_mod_command_to_int(_), do: throw(:bad_enum)
  def meter_mod_command_to_atom(0x0), do: :add
  def meter_mod_command_to_atom(0x1), do: :modify
  def meter_mod_command_to_atom(0x2), do: :delete
  def meter_mod_command_to_atom(_), do: throw(:bad_enum)
  def meter_id_to_int(:max), do: 0xFFFF0000
  def meter_id_to_int(:slowpath), do: 0xFFFFFFFD
  def meter_id_to_int(:controller), do: 0xFFFFFFFE
  def meter_id_to_int(:all), do: 0xFFFFFFFF
  def meter_id_to_int(_), do: throw(:bad_enum)
  def meter_id_to_atom(0xFFFF0000), do: :max
  def meter_id_to_atom(0xFFFFFFFD), do: :slowpath
  def meter_id_to_atom(0xFFFFFFFE), do: :controller
  def meter_id_to_atom(0xFFFFFFFF), do: :all
  def meter_id_to_atom(_), do: throw(:bad_enum)
  def meter_flags_to_int(:kbps), do: 0x1
  def meter_flags_to_int(:pktps), do: 0x2
  def meter_flags_to_int(:burst), do: 0x4
  def meter_flags_to_int(:stats), do: 0x8
  def meter_flags_to_int(_), do: throw(:bad_enum)
  def meter_flags_to_atom(0x1), do: :kbps
  def meter_flags_to_atom(0x2), do: :pktps
  def meter_flags_to_atom(0x4), do: :burst
  def meter_flags_to_atom(0x8), do: :stats
  def meter_flags_to_atom(_), do: throw(:bad_enum)
  def meter_band_type_to_int(Openflow.MeterBand.Drop), do: 0x1
  def meter_band_type_to_int(Openflow.MeterBand.Remark), do: 0x2
  def meter_band_type_to_int(Openflow.MeterBand.Experimenter), do: 0xFFFF
  def meter_band_type_to_int(_), do: throw(:bad_enum)
  def meter_band_type_to_atom(0x1), do: Openflow.MeterBand.Drop
  def meter_band_type_to_atom(0x2), do: Openflow.MeterBand.Remark
  def meter_band_type_to_atom(0xFFFF), do: Openflow.MeterBand.Experimenter
  def meter_band_type_to_atom(_), do: throw(:bad_enum)
  def table_config_to_int(:table_miss_controller), do: 0x0
  def table_config_to_int(:table_miss_continue), do: 0x1
  def table_config_to_int(:table_miss_drop), do: 0x2
  def table_config_to_int(:table_miss_mask), do: 0x3
  def table_config_to_int(:eviction), do: 0x4
  def table_config_to_int(:vacancy_events), do: 0x8
  def table_config_to_int(_), do: throw(:bad_enum)
  def table_config_to_atom(0x0), do: :table_miss_controller
  def table_config_to_atom(0x1), do: :table_miss_continue
  def table_config_to_atom(0x2), do: :table_miss_drop
  def table_config_to_atom(0x3), do: :table_miss_mask
  def table_config_to_atom(0x4), do: :eviction
  def table_config_to_atom(0x8), do: :vacancy_events
  def table_config_to_atom(_), do: throw(:bad_enum)
  def action_type_to_int(Openflow.Action.Output), do: 0x0
  def action_type_to_int(Openflow.Action.CopyTtlOut), do: 0xB
  def action_type_to_int(Openflow.Action.CopyTtlIn), do: 0xC
  def action_type_to_int(Openflow.Action.SetMplsTtl), do: 0xF
  def action_type_to_int(Openflow.Action.DecMplsTtl), do: 0x10
  def action_type_to_int(Openflow.Action.PushVlan), do: 0x11
  def action_type_to_int(Openflow.Action.PopVlan), do: 0x12
  def action_type_to_int(Openflow.Action.PushMpls), do: 0x13
  def action_type_to_int(Openflow.Action.PopMpls), do: 0x14
  def action_type_to_int(Openflow.Action.SetQueue), do: 0x15
  def action_type_to_int(Openflow.Action.Group), do: 0x16
  def action_type_to_int(Openflow.Action.SetNwTtl), do: 0x17
  def action_type_to_int(Openflow.Action.DecNwTtl), do: 0x18
  def action_type_to_int(Openflow.Action.SetField), do: 0x19
  def action_type_to_int(Openflow.Action.PushPbb), do: 0x1A
  def action_type_to_int(Openflow.Action.PopPbb), do: 0x1B
  def action_type_to_int(Openflow.Action.Encap), do: 0x1C
  def action_type_to_int(Openflow.Action.Decap), do: 0x1D
  def action_type_to_int(Openflow.Action.SetSequence), do: 0x1E
  def action_type_to_int(Openflow.Action.ValidateSequence), do: 0x1F
  def action_type_to_int(Openflow.Action.Experimenter), do: 0xFFFF
  def action_type_to_int(_), do: throw(:bad_enum)
  def action_type_to_atom(0x0), do: Openflow.Action.Output
  def action_type_to_atom(0xB), do: Openflow.Action.CopyTtlOut
  def action_type_to_atom(0xC), do: Openflow.Action.CopyTtlIn
  def action_type_to_atom(0xF), do: Openflow.Action.SetMplsTtl
  def action_type_to_atom(0x10), do: Openflow.Action.DecMplsTtl
  def action_type_to_atom(0x11), do: Openflow.Action.PushVlan
  def action_type_to_atom(0x12), do: Openflow.Action.PopVlan
  def action_type_to_atom(0x13), do: Openflow.Action.PushMpls
  def action_type_to_atom(0x14), do: Openflow.Action.PopMpls
  def action_type_to_atom(0x15), do: Openflow.Action.SetQueue
  def action_type_to_atom(0x16), do: Openflow.Action.Group
  def action_type_to_atom(0x17), do: Openflow.Action.SetNwTtl
  def action_type_to_atom(0x18), do: Openflow.Action.DecNwTtl
  def action_type_to_atom(0x19), do: Openflow.Action.SetField
  def action_type_to_atom(0x1A), do: Openflow.Action.PushPbb
  def action_type_to_atom(0x1B), do: Openflow.Action.PopPbb
  def action_type_to_atom(0x1C), do: Openflow.Action.Encap
  def action_type_to_atom(0x1D), do: Openflow.Action.Decap
  def action_type_to_atom(0x1E), do: Openflow.Action.SetSequence
  def action_type_to_atom(0x1F), do: Openflow.Action.ValidateSequence
  def action_type_to_atom(0xFFFF), do: Openflow.Action.Experimenter
  def action_type_to_atom(_), do: throw(:bad_enum)
  def action_flags_to_int(Openflow.Action.Output), do: 0x1
  def action_flags_to_int(Openflow.Action.CopyTtlOut), do: 0x800
  def action_flags_to_int(Openflow.Action.CopyTtlIn), do: 0x1000
  def action_flags_to_int(Openflow.Action.SetMplsTtl), do: 0x8000
  def action_flags_to_int(Openflow.Action.DecMplsTtl), do: 0x10000
  def action_flags_to_int(Openflow.Action.PushVlan), do: 0x20000
  def action_flags_to_int(Openflow.Action.PopVlan), do: 0x40000
  def action_flags_to_int(Openflow.Action.PushMpls), do: 0x80000
  def action_flags_to_int(Openflow.Action.PopMpls), do: 0x100000
  def action_flags_to_int(Openflow.Action.SetQueue), do: 0x200000
  def action_flags_to_int(Openflow.Action.Group), do: 0x400000
  def action_flags_to_int(Openflow.Action.SetNwTtl), do: 0x800000
  def action_flags_to_int(Openflow.Action.DecNwTtl), do: 0x1000000
  def action_flags_to_int(Openflow.Action.SetField), do: 0x2000000
  def action_flags_to_int(Openflow.Action.PushPbb), do: 0x4000000
  def action_flags_to_int(Openflow.Action.PopPbb), do: 0x8000000
  def action_flags_to_int(Openflow.Action.Encap), do: 0x10000000
  def action_flags_to_int(Openflow.Action.Decap), do: 0x20000000
  def action_flags_to_int(Openflow.Action.SetSequence), do: 0x40000000
  def action_flags_to_int(Openflow.Action.ValidateSequence), do: 0x80000000
  def action_flags_to_int(Openflow.Action.Experimenter), do: 0xFFFF
  def action_flags_to_int(_), do: throw(:bad_enum)
  def action_flags_to_atom(0x1), do: Openflow.Action.Output
  def action_flags_to_atom(0x800), do: Openflow.Action.CopyTtlOut
  def action_flags_to_atom(0x1000), do: Openflow.Action.CopyTtlIn
  def action_flags_to_atom(0x8000), do: Openflow.Action.SetMplsTtl
  def action_flags_to_atom(0x10000), do: Openflow.Action.DecMplsTtl
  def action_flags_to_atom(0x20000), do: Openflow.Action.PushVlan
  def action_flags_to_atom(0x40000), do: Openflow.Action.PopVlan
  def action_flags_to_atom(0x80000), do: Openflow.Action.PushMpls
  def action_flags_to_atom(0x100000), do: Openflow.Action.PopMpls
  def action_flags_to_atom(0x200000), do: Openflow.Action.SetQueue
  def action_flags_to_atom(0x400000), do: Openflow.Action.Group
  def action_flags_to_atom(0x800000), do: Openflow.Action.SetNwTtl
  def action_flags_to_atom(0x1000000), do: Openflow.Action.DecNwTtl
  def action_flags_to_atom(0x2000000), do: Openflow.Action.SetField
  def action_flags_to_atom(0x4000000), do: Openflow.Action.PushPbb
  def action_flags_to_atom(0x8000000), do: Openflow.Action.PopPbb
  def action_flags_to_atom(0x10000000), do: Openflow.Action.Encap
  def action_flags_to_atom(0x20000000), do: Openflow.Action.Decap
  def action_flags_to_atom(0x40000000), do: Openflow.Action.SetSequence
  def action_flags_to_atom(0x80000000), do: Openflow.Action.ValidateSequence
  def action_flags_to_atom(0xFFFF), do: Openflow.Action.Experimenter
  def action_flags_to_atom(_), do: throw(:bad_enum)
  def action_vendor_to_int(:nicira_ext_action), do: 0x2320
  def action_vendor_to_int(:onf_ext_action), do: 0x4F4E4600
  def action_vendor_to_int(_), do: throw(:bad_enum)
  def action_vendor_to_atom(0x2320), do: :nicira_ext_action
  def action_vendor_to_atom(0x4F4E4600), do: :onf_ext_action
  def action_vendor_to_atom(_), do: throw(:bad_enum)
  def onf_ext_action_to_int(Openflow.Action.OnfCopyField), do: 0xC80
  def onf_ext_action_to_int(_), do: throw(:bad_enum)
  def onf_ext_action_to_atom(0xC80), do: Openflow.Action.OnfCopyField
  def onf_ext_action_to_atom(_), do: throw(:bad_enum)
  def nicira_ext_action_to_int(Openflow.Action.NxResubmit), do: 0x1
  def nicira_ext_action_to_int(Openflow.Action.NxSetTunnel), do: 0x2
  def nicira_ext_action_to_int(Openflow.Action.NxRegMove), do: 0x6
  def nicira_ext_action_to_int(Openflow.Action.NxRegLoad), do: 0x7
  def nicira_ext_action_to_int(Openflow.Action.NxNote), do: 0x8
  def nicira_ext_action_to_int(Openflow.Action.NxSetTunnel64), do: 0x9
  def nicira_ext_action_to_int(Openflow.Action.NxMultipath), do: 0xA
  def nicira_ext_action_to_int(Openflow.Action.NxBundle), do: 0xC
  def nicira_ext_action_to_int(Openflow.Action.NxBundleLoad), do: 0xD
  def nicira_ext_action_to_int(Openflow.Action.NxResubmitTable), do: 0xE
  def nicira_ext_action_to_int(Openflow.Action.NxOutputReg), do: 0xF
  def nicira_ext_action_to_int(Openflow.Action.NxLearn), do: 0x10
  def nicira_ext_action_to_int(Openflow.Action.NxExit), do: 0x11
  def nicira_ext_action_to_int(Openflow.Action.NxDecTtl), do: 0x12
  def nicira_ext_action_to_int(Openflow.Action.NxFinTimeout), do: 0x13
  def nicira_ext_action_to_int(Openflow.Action.NxController), do: 0x14
  def nicira_ext_action_to_int(Openflow.Action.NxDecTtlCntIds), do: 0x15
  def nicira_ext_action_to_int(Openflow.Action.NxWriteMetadata), do: 0x16
  def nicira_ext_action_to_int(Openflow.Action.NxStackPush), do: 0x1B
  def nicira_ext_action_to_int(Openflow.Action.NxStackPop), do: 0x1C
  def nicira_ext_action_to_int(Openflow.Action.NxSample), do: 0x1D
  def nicira_ext_action_to_int(Openflow.Action.NxOutputReg2), do: 0x20
  def nicira_ext_action_to_int(Openflow.Action.NxRegLoad2), do: 0x21
  def nicira_ext_action_to_int(Openflow.Action.NxConjunction), do: 0x22
  def nicira_ext_action_to_int(Openflow.Action.NxConntrack), do: 0x23
  def nicira_ext_action_to_int(Openflow.Action.NxNat), do: 0x24
  def nicira_ext_action_to_int(Openflow.Action.NxController2), do: 0x25
  def nicira_ext_action_to_int(Openflow.Action.NxSample2), do: 0x26
  def nicira_ext_action_to_int(Openflow.Action.NxOutputTrunc), do: 0x27
  def nicira_ext_action_to_int(Openflow.Action.NxGroup), do: 0x28
  def nicira_ext_action_to_int(Openflow.Action.NxSample3), do: 0x29
  def nicira_ext_action_to_int(Openflow.Action.NxClone), do: 0x2A
  def nicira_ext_action_to_int(Openflow.Action.NxCtClear), do: 0x2B
  def nicira_ext_action_to_int(Openflow.Action.NxResubmitTableCt), do: 0x2C
  def nicira_ext_action_to_int(Openflow.Action.NxLearn2), do: 0x2D
  def nicira_ext_action_to_int(Openflow.Action.NxEncap), do: 0x2E
  def nicira_ext_action_to_int(Openflow.Action.NxDecap), do: 0x2F
  def nicira_ext_action_to_int(Openflow.Action.NxDebugRecirc), do: 0xFF
  def nicira_ext_action_to_int(_), do: throw(:bad_enum)
  def nicira_ext_action_to_atom(0x1), do: Openflow.Action.NxResubmit
  def nicira_ext_action_to_atom(0x2), do: Openflow.Action.NxSetTunnel
  def nicira_ext_action_to_atom(0x6), do: Openflow.Action.NxRegMove
  def nicira_ext_action_to_atom(0x7), do: Openflow.Action.NxRegLoad
  def nicira_ext_action_to_atom(0x8), do: Openflow.Action.NxNote
  def nicira_ext_action_to_atom(0x9), do: Openflow.Action.NxSetTunnel64
  def nicira_ext_action_to_atom(0xA), do: Openflow.Action.NxMultipath
  def nicira_ext_action_to_atom(0xC), do: Openflow.Action.NxBundle
  def nicira_ext_action_to_atom(0xD), do: Openflow.Action.NxBundleLoad
  def nicira_ext_action_to_atom(0xE), do: Openflow.Action.NxResubmitTable
  def nicira_ext_action_to_atom(0xF), do: Openflow.Action.NxOutputReg
  def nicira_ext_action_to_atom(0x10), do: Openflow.Action.NxLearn
  def nicira_ext_action_to_atom(0x11), do: Openflow.Action.NxExit
  def nicira_ext_action_to_atom(0x12), do: Openflow.Action.NxDecTtl
  def nicira_ext_action_to_atom(0x13), do: Openflow.Action.NxFinTimeout
  def nicira_ext_action_to_atom(0x14), do: Openflow.Action.NxController
  def nicira_ext_action_to_atom(0x15), do: Openflow.Action.NxDecTtlCntIds
  def nicira_ext_action_to_atom(0x16), do: Openflow.Action.NxWriteMetadata
  def nicira_ext_action_to_atom(0x1B), do: Openflow.Action.NxStackPush
  def nicira_ext_action_to_atom(0x1C), do: Openflow.Action.NxStackPop
  def nicira_ext_action_to_atom(0x1D), do: Openflow.Action.NxSample
  def nicira_ext_action_to_atom(0x20), do: Openflow.Action.NxOutputReg2
  def nicira_ext_action_to_atom(0x21), do: Openflow.Action.NxRegLoad2
  def nicira_ext_action_to_atom(0x22), do: Openflow.Action.NxConjunction
  def nicira_ext_action_to_atom(0x23), do: Openflow.Action.NxConntrack
  def nicira_ext_action_to_atom(0x24), do: Openflow.Action.NxNat
  def nicira_ext_action_to_atom(0x25), do: Openflow.Action.NxController2
  def nicira_ext_action_to_atom(0x26), do: Openflow.Action.NxSample2
  def nicira_ext_action_to_atom(0x27), do: Openflow.Action.NxOutputTrunc
  def nicira_ext_action_to_atom(0x28), do: Openflow.Action.NxGroup
  def nicira_ext_action_to_atom(0x29), do: Openflow.Action.NxSample3
  def nicira_ext_action_to_atom(0x2A), do: Openflow.Action.NxClone
  def nicira_ext_action_to_atom(0x2B), do: Openflow.Action.NxCtClear
  def nicira_ext_action_to_atom(0x2C), do: Openflow.Action.NxResubmitTableCt
  def nicira_ext_action_to_atom(0x2D), do: Openflow.Action.NxLearn2
  def nicira_ext_action_to_atom(0x2E), do: Openflow.Action.NxEncap
  def nicira_ext_action_to_atom(0x2F), do: Openflow.Action.NxDecap
  def nicira_ext_action_to_atom(0xFF), do: Openflow.Action.NxDebugRecirc
  def nicira_ext_action_to_atom(_), do: throw(:bad_enum)
  def nx_mp_algorithm_to_int(:modulo_n), do: 0x0
  def nx_mp_algorithm_to_int(:hash_threshold), do: 0x1
  def nx_mp_algorithm_to_int(:highest_random_weight), do: 0x2
  def nx_mp_algorithm_to_int(:iterative_hash), do: 0x3
  def nx_mp_algorithm_to_int(_), do: throw(:bad_enum)
  def nx_mp_algorithm_to_atom(0x0), do: :modulo_n
  def nx_mp_algorithm_to_atom(0x1), do: :hash_threshold
  def nx_mp_algorithm_to_atom(0x2), do: :highest_random_weight
  def nx_mp_algorithm_to_atom(0x3), do: :iterative_hash
  def nx_mp_algorithm_to_atom(_), do: throw(:bad_enum)
  def nx_hash_fields_to_int(:eth_src), do: 0x0
  def nx_hash_fields_to_int(:symmetric_l4), do: 0x1
  def nx_hash_fields_to_int(:symmetric_l3l4), do: 0x2
  def nx_hash_fields_to_int(:symmetric_l3l4_udp), do: 0x3
  def nx_hash_fields_to_int(:nw_src), do: 0x4
  def nx_hash_fields_to_int(:nw_dst), do: 0x5
  def nx_hash_fields_to_int(_), do: throw(:bad_enum)
  def nx_hash_fields_to_atom(0x0), do: :eth_src
  def nx_hash_fields_to_atom(0x1), do: :symmetric_l4
  def nx_hash_fields_to_atom(0x2), do: :symmetric_l3l4
  def nx_hash_fields_to_atom(0x3), do: :symmetric_l3l4_udp
  def nx_hash_fields_to_atom(0x4), do: :nw_src
  def nx_hash_fields_to_atom(0x5), do: :nw_dst
  def nx_hash_fields_to_atom(_), do: throw(:bad_enum)
  def nx_bd_algorithm_to_int(:active_backup), do: 0x0
  def nx_bd_algorithm_to_int(:highest_random_weight), do: 0x1
  def nx_bd_algorithm_to_int(_), do: throw(:bad_enum)
  def nx_bd_algorithm_to_atom(0x0), do: :active_backup
  def nx_bd_algorithm_to_atom(0x1), do: :highest_random_weight
  def nx_bd_algorithm_to_atom(_), do: throw(:bad_enum)
  def nx_learn_flag_to_int(:send_flow_rem), do: 0x1
  def nx_learn_flag_to_int(:delete_learned), do: 0x2
  def nx_learn_flag_to_int(:write_result), do: 0x4
  def nx_learn_flag_to_int(_), do: throw(:bad_enum)
  def nx_learn_flag_to_atom(0x1), do: :send_flow_rem
  def nx_learn_flag_to_atom(0x2), do: :delete_learned
  def nx_learn_flag_to_atom(0x4), do: :write_result
  def nx_learn_flag_to_atom(_), do: throw(:bad_enum)
  def nx_conntrack_flags_to_int(:commit), do: 0x1
  def nx_conntrack_flags_to_int(:force), do: 0x2
  def nx_conntrack_flags_to_int(_), do: throw(:bad_enum)
  def nx_conntrack_flags_to_atom(0x1), do: :commit
  def nx_conntrack_flags_to_atom(0x2), do: :force
  def nx_conntrack_flags_to_atom(_), do: throw(:bad_enum)
  def nx_nat_flags_to_int(:src), do: 0x1
  def nx_nat_flags_to_int(:dst), do: 0x2
  def nx_nat_flags_to_int(:persistent), do: 0x4
  def nx_nat_flags_to_int(:protocol_hash), do: 0x8
  def nx_nat_flags_to_int(:protocol_random), do: 0x10
  def nx_nat_flags_to_int(_), do: throw(:bad_enum)
  def nx_nat_flags_to_atom(0x1), do: :src
  def nx_nat_flags_to_atom(0x2), do: :dst
  def nx_nat_flags_to_atom(0x4), do: :persistent
  def nx_nat_flags_to_atom(0x8), do: :protocol_hash
  def nx_nat_flags_to_atom(0x10), do: :protocol_random
  def nx_nat_flags_to_atom(_), do: throw(:bad_enum)
  def nx_nat_range_to_int(:ipv4_min), do: 0x1
  def nx_nat_range_to_int(:ipv4_max), do: 0x2
  def nx_nat_range_to_int(:ipv6_min), do: 0x4
  def nx_nat_range_to_int(:ipv6_max), do: 0x8
  def nx_nat_range_to_int(:proto_min), do: 0x10
  def nx_nat_range_to_int(:proto_max), do: 0x20
  def nx_nat_range_to_int(_), do: throw(:bad_enum)
  def nx_nat_range_to_atom(0x1), do: :ipv4_min
  def nx_nat_range_to_atom(0x2), do: :ipv4_max
  def nx_nat_range_to_atom(0x4), do: :ipv6_min
  def nx_nat_range_to_atom(0x8), do: :ipv6_max
  def nx_nat_range_to_atom(0x10), do: :proto_min
  def nx_nat_range_to_atom(0x20), do: :proto_max
  def nx_nat_range_to_atom(_), do: throw(:bad_enum)
  def nx_action_controller2_prop_type_to_int(:max_len), do: 0x0
  def nx_action_controller2_prop_type_to_int(:controller_id), do: 0x1
  def nx_action_controller2_prop_type_to_int(:reason), do: 0x2
  def nx_action_controller2_prop_type_to_int(:userdata), do: 0x3
  def nx_action_controller2_prop_type_to_int(:pause), do: 0x4
  def nx_action_controller2_prop_type_to_int(_), do: throw(:bad_enum)
  def nx_action_controller2_prop_type_to_atom(0x0), do: :max_len
  def nx_action_controller2_prop_type_to_atom(0x1), do: :controller_id
  def nx_action_controller2_prop_type_to_atom(0x2), do: :reason
  def nx_action_controller2_prop_type_to_atom(0x3), do: :userdata
  def nx_action_controller2_prop_type_to_atom(0x4), do: :pause
  def nx_action_controller2_prop_type_to_atom(_), do: throw(:bad_enum)
  def nx_action_sample_direction_to_int(:default), do: 0x0
  def nx_action_sample_direction_to_int(:ingress), do: 0x1
  def nx_action_sample_direction_to_int(:egress), do: 0x2
  def nx_action_sample_direction_to_int(_), do: throw(:bad_enum)
  def nx_action_sample_direction_to_atom(0x0), do: :default
  def nx_action_sample_direction_to_atom(0x1), do: :ingress
  def nx_action_sample_direction_to_atom(0x2), do: :egress
  def nx_action_sample_direction_to_atom(_), do: throw(:bad_enum)
  def nx_flow_spec_type_to_int(Openflow.Action.NxFlowSpecMatch), do: 0x0
  def nx_flow_spec_type_to_int(Openflow.Action.NxFlowSpecLoad), do: 0x1
  def nx_flow_spec_type_to_int(Openflow.Action.NxFlowSpecOutput), do: 0x2
  def nx_flow_spec_type_to_int(_), do: throw(:bad_enum)
  def nx_flow_spec_type_to_atom(0x0), do: Openflow.Action.NxFlowSpecMatch
  def nx_flow_spec_type_to_atom(0x1), do: Openflow.Action.NxFlowSpecLoad
  def nx_flow_spec_type_to_atom(0x2), do: Openflow.Action.NxFlowSpecOutput
  def nx_flow_spec_type_to_atom(_), do: throw(:bad_enum)
  def instruction_type_to_int(Openflow.Instruction.GotoTable), do: 0x1
  def instruction_type_to_int(Openflow.Instruction.WriteMetadata), do: 0x2
  def instruction_type_to_int(Openflow.Instruction.WriteActions), do: 0x3
  def instruction_type_to_int(Openflow.Instruction.ApplyActions), do: 0x4
  def instruction_type_to_int(Openflow.Instruction.ClearActions), do: 0x5
  def instruction_type_to_int(Openflow.Instruction.Meter), do: 0x6
  def instruction_type_to_int(Openflow.Instruction.Experimenter), do: 0xFFFF
  def instruction_type_to_int(_), do: throw(:bad_enum)
  def instruction_type_to_atom(0x1), do: Openflow.Instruction.GotoTable
  def instruction_type_to_atom(0x2), do: Openflow.Instruction.WriteMetadata
  def instruction_type_to_atom(0x3), do: Openflow.Instruction.WriteActions
  def instruction_type_to_atom(0x4), do: Openflow.Instruction.ApplyActions
  def instruction_type_to_atom(0x5), do: Openflow.Instruction.ClearActions
  def instruction_type_to_atom(0x6), do: Openflow.Instruction.Meter
  def instruction_type_to_atom(0xFFFF), do: Openflow.Instruction.Experimenter
  def instruction_type_to_atom(_), do: throw(:bad_enum)
  def controller_role_to_int(:nochange), do: 0x0
  def controller_role_to_int(:equal), do: 0x1
  def controller_role_to_int(:master), do: 0x2
  def controller_role_to_int(:slave), do: 0x3
  def controller_role_to_int(_), do: throw(:bad_enum)
  def controller_role_to_atom(0x0), do: :nochange
  def controller_role_to_atom(0x1), do: :equal
  def controller_role_to_atom(0x2), do: :master
  def controller_role_to_atom(0x3), do: :slave
  def controller_role_to_atom(_), do: throw(:bad_enum)
  def nx_role_to_int(:other), do: 0x0
  def nx_role_to_int(:master), do: 0x1
  def nx_role_to_int(:slave), do: 0x2
  def nx_role_to_int(_), do: throw(:bad_enum)
  def nx_role_to_atom(0x0), do: :other
  def nx_role_to_atom(0x1), do: :master
  def nx_role_to_atom(0x2), do: :slave
  def nx_role_to_atom(_), do: throw(:bad_enum)
  def packet_in_format_to_int(:standard), do: 0x0
  def packet_in_format_to_int(:nxt_packet_in), do: 0x1
  def packet_in_format_to_int(:nxt_packet_in2), do: 0x2
  def packet_in_format_to_int(_), do: throw(:bad_enum)
  def packet_in_format_to_atom(0x0), do: :standard
  def packet_in_format_to_atom(0x1), do: :nxt_packet_in
  def packet_in_format_to_atom(0x2), do: :nxt_packet_in2
  def packet_in_format_to_atom(_), do: throw(:bad_enum)
  def flow_format_to_int(:openflow10), do: 0x0
  def flow_format_to_int(:nxm), do: 0x1
  def flow_format_to_int(_), do: throw(:bad_enum)
  def flow_format_to_atom(0x0), do: :openflow10
  def flow_format_to_atom(0x1), do: :nxm
  def flow_format_to_atom(_), do: throw(:bad_enum)
  def packet_in2_prop_type_to_int(:packet), do: 0x0
  def packet_in2_prop_type_to_int(:full_len), do: 0x1
  def packet_in2_prop_type_to_int(:buffer_id), do: 0x2
  def packet_in2_prop_type_to_int(:table_id), do: 0x3
  def packet_in2_prop_type_to_int(:cookie), do: 0x4
  def packet_in2_prop_type_to_int(:reason), do: 0x5
  def packet_in2_prop_type_to_int(:metadata), do: 0x6
  def packet_in2_prop_type_to_int(:userdata), do: 0x7
  def packet_in2_prop_type_to_int(:continuation), do: 0x8
  def packet_in2_prop_type_to_int(_), do: throw(:bad_enum)
  def packet_in2_prop_type_to_atom(0x0), do: :packet
  def packet_in2_prop_type_to_atom(0x1), do: :full_len
  def packet_in2_prop_type_to_atom(0x2), do: :buffer_id
  def packet_in2_prop_type_to_atom(0x3), do: :table_id
  def packet_in2_prop_type_to_atom(0x4), do: :cookie
  def packet_in2_prop_type_to_atom(0x5), do: :reason
  def packet_in2_prop_type_to_atom(0x6), do: :metadata
  def packet_in2_prop_type_to_atom(0x7), do: :userdata
  def packet_in2_prop_type_to_atom(0x8), do: :continuation
  def packet_in2_prop_type_to_atom(_), do: throw(:bad_enum)
  def continuation_prop_type_to_int(:bridge), do: 0x8000
  def continuation_prop_type_to_int(:stack), do: 0x8001
  def continuation_prop_type_to_int(:mirrors), do: 0x8002
  def continuation_prop_type_to_int(:conntracked), do: 0x8003
  def continuation_prop_type_to_int(:table_id), do: 0x8004
  def continuation_prop_type_to_int(:cookie), do: 0x8005
  def continuation_prop_type_to_int(:actions), do: 0x8006
  def continuation_prop_type_to_int(:action_set), do: 0x8007
  def continuation_prop_type_to_int(_), do: throw(:bad_enum)
  def continuation_prop_type_to_atom(0x8000), do: :bridge
  def continuation_prop_type_to_atom(0x8001), do: :stack
  def continuation_prop_type_to_atom(0x8002), do: :mirrors
  def continuation_prop_type_to_atom(0x8003), do: :conntracked
  def continuation_prop_type_to_atom(0x8004), do: :table_id
  def continuation_prop_type_to_atom(0x8005), do: :cookie
  def continuation_prop_type_to_atom(0x8006), do: :actions
  def continuation_prop_type_to_atom(0x8007), do: :action_set
  def continuation_prop_type_to_atom(_), do: throw(:bad_enum)
  def flow_monitor_flag_to_int(:initial), do: 0x1
  def flow_monitor_flag_to_int(:add), do: 0x2
  def flow_monitor_flag_to_int(:delete), do: 0x4
  def flow_monitor_flag_to_int(:modify), do: 0x8
  def flow_monitor_flag_to_int(:actions), do: 0x10
  def flow_monitor_flag_to_int(:own), do: 0x20
  def flow_monitor_flag_to_int(_), do: throw(:bad_enum)
  def flow_monitor_flag_to_atom(0x1), do: :initial
  def flow_monitor_flag_to_atom(0x2), do: :add
  def flow_monitor_flag_to_atom(0x4), do: :delete
  def flow_monitor_flag_to_atom(0x8), do: :modify
  def flow_monitor_flag_to_atom(0x10), do: :actions
  def flow_monitor_flag_to_atom(0x20), do: :own
  def flow_monitor_flag_to_atom(_), do: throw(:bad_enum)
  def flow_update_event_to_int(:added), do: 0x0
  def flow_update_event_to_int(:deleted), do: 0x1
  def flow_update_event_to_int(:modified), do: 0x2
  def flow_update_event_to_int(:abbrev), do: 0x3
  def flow_update_event_to_int(_), do: throw(:bad_enum)
  def flow_update_event_to_atom(0x0), do: :added
  def flow_update_event_to_atom(0x1), do: :deleted
  def flow_update_event_to_atom(0x2), do: :modified
  def flow_update_event_to_atom(0x3), do: :abbrev
  def flow_update_event_to_atom(_), do: throw(:bad_enum)
  def tlv_table_mod_command_to_int(:add), do: 0x0
  def tlv_table_mod_command_to_int(:delete), do: 0x1
  def tlv_table_mod_command_to_int(:clear), do: 0x2
  def tlv_table_mod_command_to_int(_), do: throw(:bad_enum)
  def tlv_table_mod_command_to_atom(0x0), do: :add
  def tlv_table_mod_command_to_atom(0x1), do: :delete
  def tlv_table_mod_command_to_atom(0x2), do: :clear
  def tlv_table_mod_command_to_atom(_), do: throw(:bad_enum)
  def table_feature_prop_type_to_int(:instructions), do: 0x0
  def table_feature_prop_type_to_int(:instructions_miss), do: 0x1
  def table_feature_prop_type_to_int(:next_tables), do: 0x2
  def table_feature_prop_type_to_int(:next_tables_miss), do: 0x3
  def table_feature_prop_type_to_int(:write_actions), do: 0x4
  def table_feature_prop_type_to_int(:write_actions_miss), do: 0x5
  def table_feature_prop_type_to_int(:apply_actions), do: 0x6
  def table_feature_prop_type_to_int(:apply_actions_miss), do: 0x7
  def table_feature_prop_type_to_int(:match), do: 0x8
  def table_feature_prop_type_to_int(:wildcards), do: 0xA
  def table_feature_prop_type_to_int(:write_setfield), do: 0xC
  def table_feature_prop_type_to_int(:write_setfield_miss), do: 0xD
  def table_feature_prop_type_to_int(:apply_setfield), do: 0xE
  def table_feature_prop_type_to_int(:apply_setfield_miss), do: 0xF
  def table_feature_prop_type_to_int(:experimenter), do: 0xFFFE
  def table_feature_prop_type_to_int(:experimenter_miss), do: 0xFFFF
  def table_feature_prop_type_to_int(_), do: throw(:bad_enum)
  def table_feature_prop_type_to_atom(0x0), do: :instructions
  def table_feature_prop_type_to_atom(0x1), do: :instructions_miss
  def table_feature_prop_type_to_atom(0x2), do: :next_tables
  def table_feature_prop_type_to_atom(0x3), do: :next_tables_miss
  def table_feature_prop_type_to_atom(0x4), do: :write_actions
  def table_feature_prop_type_to_atom(0x5), do: :write_actions_miss
  def table_feature_prop_type_to_atom(0x6), do: :apply_actions
  def table_feature_prop_type_to_atom(0x7), do: :apply_actions_miss
  def table_feature_prop_type_to_atom(0x8), do: :match
  def table_feature_prop_type_to_atom(0xA), do: :wildcards
  def table_feature_prop_type_to_atom(0xC), do: :write_setfield
  def table_feature_prop_type_to_atom(0xD), do: :write_setfield_miss
  def table_feature_prop_type_to_atom(0xE), do: :apply_setfield
  def table_feature_prop_type_to_atom(0xF), do: :apply_setfield_miss
  def table_feature_prop_type_to_atom(0xFFFE), do: :experimenter
  def table_feature_prop_type_to_atom(0xFFFF), do: :experimenter_miss
  def table_feature_prop_type_to_atom(_), do: throw(:bad_enum)
  def bundle_ctrl_type_to_int(:open_request), do: 0x0
  def bundle_ctrl_type_to_int(:open_reply), do: 0x1
  def bundle_ctrl_type_to_int(:close_request), do: 0x2
  def bundle_ctrl_type_to_int(:close_reply), do: 0x3
  def bundle_ctrl_type_to_int(:commit_request), do: 0x4
  def bundle_ctrl_type_to_int(:commit_reply), do: 0x5
  def bundle_ctrl_type_to_int(:discard_request), do: 0x6
  def bundle_ctrl_type_to_int(:discard_reply), do: 0x7
  def bundle_ctrl_type_to_int(_), do: throw(:bad_enum)
  def bundle_ctrl_type_to_atom(0x0), do: :open_request
  def bundle_ctrl_type_to_atom(0x1), do: :open_reply
  def bundle_ctrl_type_to_atom(0x2), do: :close_request
  def bundle_ctrl_type_to_atom(0x3), do: :close_reply
  def bundle_ctrl_type_to_atom(0x4), do: :commit_request
  def bundle_ctrl_type_to_atom(0x5), do: :commit_reply
  def bundle_ctrl_type_to_atom(0x6), do: :discard_request
  def bundle_ctrl_type_to_atom(0x7), do: :discard_reply
  def bundle_ctrl_type_to_atom(_), do: throw(:bad_enum)
  def bundle_flags_to_int(:atomic), do: 0x1
  def bundle_flags_to_int(:ordered), do: 0x2
  def bundle_flags_to_int(_), do: throw(:bad_enum)
  def bundle_flags_to_atom(0x1), do: :atomic
  def bundle_flags_to_atom(0x2), do: :ordered
  def bundle_flags_to_atom(_), do: throw(:bad_enum)

  def int_to_flags(int, :openflow_codec) do
    Openflow.Utils.int_to_flags([], int, enum_of(:openflow_codec))
  end

  def int_to_flags(int, :experimenter_id) do
    Openflow.Utils.int_to_flags([], int, enum_of(:experimenter_id))
  end

  def int_to_flags(int, :nicira_ext_message) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nicira_ext_message))
  end

  def int_to_flags(int, :onf_ext_message) do
    Openflow.Utils.int_to_flags([], int, enum_of(:onf_ext_message))
  end

  def int_to_flags(int, :multipart_request_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:multipart_request_flags))
  end

  def int_to_flags(int, :multipart_reply_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:multipart_reply_flags))
  end

  def int_to_flags(int, :multipart_request_codec) do
    Openflow.Utils.int_to_flags([], int, enum_of(:multipart_request_codec))
  end

  def int_to_flags(int, :multipart_reply_codec) do
    Openflow.Utils.int_to_flags([], int, enum_of(:multipart_reply_codec))
  end

  def int_to_flags(int, :nicira_ext_stats) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nicira_ext_stats))
  end

  def int_to_flags(int, :hello_elem) do
    Openflow.Utils.int_to_flags([], int, enum_of(:hello_elem))
  end

  def int_to_flags(int, :error_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:error_type))
  end

  def int_to_flags(int, :hello_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:hello_failed))
  end

  def int_to_flags(int, :bad_request) do
    Openflow.Utils.int_to_flags([], int, enum_of(:bad_request))
  end

  def int_to_flags(int, :bad_action) do
    Openflow.Utils.int_to_flags([], int, enum_of(:bad_action))
  end

  def int_to_flags(int, :bad_instruction) do
    Openflow.Utils.int_to_flags([], int, enum_of(:bad_instruction))
  end

  def int_to_flags(int, :bad_match) do
    Openflow.Utils.int_to_flags([], int, enum_of(:bad_match))
  end

  def int_to_flags(int, :flow_mod_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:flow_mod_failed))
  end

  def int_to_flags(int, :group_mod_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:group_mod_failed))
  end

  def int_to_flags(int, :port_mod_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:port_mod_failed))
  end

  def int_to_flags(int, :table_mod_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:table_mod_failed))
  end

  def int_to_flags(int, :queue_op_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:queue_op_failed))
  end

  def int_to_flags(int, :switch_config_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:switch_config_failed))
  end

  def int_to_flags(int, :role_request_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:role_request_failed))
  end

  def int_to_flags(int, :meter_mod_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:meter_mod_failed))
  end

  def int_to_flags(int, :table_features_failed) do
    Openflow.Utils.int_to_flags([], int, enum_of(:table_features_failed))
  end

  def int_to_flags(int, :switch_capabilities) do
    Openflow.Utils.int_to_flags([], int, enum_of(:switch_capabilities))
  end

  def int_to_flags(int, :config_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:config_flags))
  end

  def int_to_flags(int, :controller_max_len) do
    Openflow.Utils.int_to_flags([], int, enum_of(:controller_max_len))
  end

  def int_to_flags(int, :experimenter_oxm_vendors) do
    Openflow.Utils.int_to_flags([], int, enum_of(:experimenter_oxm_vendors))
  end

  def int_to_flags(int, :match_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:match_type))
  end

  def int_to_flags(int, :oxm_class) do
    Openflow.Utils.int_to_flags([], int, enum_of(:oxm_class))
  end

  def int_to_flags(int, :nxm_0) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nxm_0))
  end

  def int_to_flags(int, :nxm_1) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nxm_1))
  end

  def int_to_flags(int, :openflow_basic) do
    Openflow.Utils.int_to_flags([], int, enum_of(:openflow_basic))
  end

  def int_to_flags(int, :vlan_id) do
    Openflow.Utils.int_to_flags([], int, enum_of(:vlan_id))
  end

  def int_to_flags(int, :ipv6exthdr_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:ipv6exthdr_flags))
  end

  def int_to_flags(int, :tcp_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:tcp_flags))
  end

  def int_to_flags(int, :ct_state_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:ct_state_flags))
  end

  def int_to_flags(int, :packet_register) do
    Openflow.Utils.int_to_flags([], int, enum_of(:packet_register))
  end

  def int_to_flags(int, :nicira_ext_match) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nicira_ext_match))
  end

  def int_to_flags(int, :hp_ext_match) do
    Openflow.Utils.int_to_flags([], int, enum_of(:hp_ext_match))
  end

  def int_to_flags(int, :hp_custom_match_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:hp_custom_match_type))
  end

  def int_to_flags(int, :onf_ext_match) do
    Openflow.Utils.int_to_flags([], int, enum_of(:onf_ext_match))
  end

  def int_to_flags(int, :buffer_id) do
    Openflow.Utils.int_to_flags([], int, enum_of(:buffer_id))
  end

  def int_to_flags(int, :port_config) do
    Openflow.Utils.int_to_flags([], int, enum_of(:port_config))
  end

  def int_to_flags(int, :port_state) do
    Openflow.Utils.int_to_flags([], int, enum_of(:port_state))
  end

  def int_to_flags(int, :port_features) do
    Openflow.Utils.int_to_flags([], int, enum_of(:port_features))
  end

  def int_to_flags(int, :openflow10_port_no) do
    Openflow.Utils.int_to_flags([], int, enum_of(:openflow10_port_no))
  end

  def int_to_flags(int, :openflow13_port_no) do
    Openflow.Utils.int_to_flags([], int, enum_of(:openflow13_port_no))
  end

  def int_to_flags(int, :packet_in_reason) do
    Openflow.Utils.int_to_flags([], int, enum_of(:packet_in_reason))
  end

  def int_to_flags(int, :packet_in_reason_mask) do
    Openflow.Utils.int_to_flags([], int, enum_of(:packet_in_reason_mask))
  end

  def int_to_flags(int, :flow_mod_command) do
    Openflow.Utils.int_to_flags([], int, enum_of(:flow_mod_command))
  end

  def int_to_flags(int, :flow_mod_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:flow_mod_flags))
  end

  def int_to_flags(int, :flow_removed_reason) do
    Openflow.Utils.int_to_flags([], int, enum_of(:flow_removed_reason))
  end

  def int_to_flags(int, :flow_removed_reason_mask) do
    Openflow.Utils.int_to_flags([], int, enum_of(:flow_removed_reason_mask))
  end

  def int_to_flags(int, :port_reason) do
    Openflow.Utils.int_to_flags([], int, enum_of(:port_reason))
  end

  def int_to_flags(int, :port_reason_mask) do
    Openflow.Utils.int_to_flags([], int, enum_of(:port_reason_mask))
  end

  def int_to_flags(int, :group_mod_command) do
    Openflow.Utils.int_to_flags([], int, enum_of(:group_mod_command))
  end

  def int_to_flags(int, :group_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:group_type))
  end

  def int_to_flags(int, :group_type_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:group_type_flags))
  end

  def int_to_flags(int, :group_id) do
    Openflow.Utils.int_to_flags([], int, enum_of(:group_id))
  end

  def int_to_flags(int, :group_capabilities) do
    Openflow.Utils.int_to_flags([], int, enum_of(:group_capabilities))
  end

  def int_to_flags(int, :table_id) do
    Openflow.Utils.int_to_flags([], int, enum_of(:table_id))
  end

  def int_to_flags(int, :queue_id) do
    Openflow.Utils.int_to_flags([], int, enum_of(:queue_id))
  end

  def int_to_flags(int, :meter_mod_command) do
    Openflow.Utils.int_to_flags([], int, enum_of(:meter_mod_command))
  end

  def int_to_flags(int, :meter_id) do
    Openflow.Utils.int_to_flags([], int, enum_of(:meter_id))
  end

  def int_to_flags(int, :meter_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:meter_flags))
  end

  def int_to_flags(int, :meter_band_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:meter_band_type))
  end

  def int_to_flags(int, :table_config) do
    Openflow.Utils.int_to_flags([], int, enum_of(:table_config))
  end

  def int_to_flags(int, :action_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:action_type))
  end

  def int_to_flags(int, :action_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:action_flags))
  end

  def int_to_flags(int, :action_vendor) do
    Openflow.Utils.int_to_flags([], int, enum_of(:action_vendor))
  end

  def int_to_flags(int, :onf_ext_action) do
    Openflow.Utils.int_to_flags([], int, enum_of(:onf_ext_action))
  end

  def int_to_flags(int, :nicira_ext_action) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nicira_ext_action))
  end

  def int_to_flags(int, :nx_mp_algorithm) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_mp_algorithm))
  end

  def int_to_flags(int, :nx_hash_fields) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_hash_fields))
  end

  def int_to_flags(int, :nx_bd_algorithm) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_bd_algorithm))
  end

  def int_to_flags(int, :nx_learn_flag) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_learn_flag))
  end

  def int_to_flags(int, :nx_conntrack_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_conntrack_flags))
  end

  def int_to_flags(int, :nx_nat_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_nat_flags))
  end

  def int_to_flags(int, :nx_nat_range) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_nat_range))
  end

  def int_to_flags(int, :nx_action_controller2_prop_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_action_controller2_prop_type))
  end

  def int_to_flags(int, :nx_action_sample_direction) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_action_sample_direction))
  end

  def int_to_flags(int, :nx_flow_spec_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_flow_spec_type))
  end

  def int_to_flags(int, :instruction_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:instruction_type))
  end

  def int_to_flags(int, :controller_role) do
    Openflow.Utils.int_to_flags([], int, enum_of(:controller_role))
  end

  def int_to_flags(int, :nx_role) do
    Openflow.Utils.int_to_flags([], int, enum_of(:nx_role))
  end

  def int_to_flags(int, :packet_in_format) do
    Openflow.Utils.int_to_flags([], int, enum_of(:packet_in_format))
  end

  def int_to_flags(int, :flow_format) do
    Openflow.Utils.int_to_flags([], int, enum_of(:flow_format))
  end

  def int_to_flags(int, :packet_in2_prop_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:packet_in2_prop_type))
  end

  def int_to_flags(int, :continuation_prop_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:continuation_prop_type))
  end

  def int_to_flags(int, :flow_monitor_flag) do
    Openflow.Utils.int_to_flags([], int, enum_of(:flow_monitor_flag))
  end

  def int_to_flags(int, :flow_update_event) do
    Openflow.Utils.int_to_flags([], int, enum_of(:flow_update_event))
  end

  def int_to_flags(int, :tlv_table_mod_command) do
    Openflow.Utils.int_to_flags([], int, enum_of(:tlv_table_mod_command))
  end

  def int_to_flags(int, :table_feature_prop_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:table_feature_prop_type))
  end

  def int_to_flags(int, :bundle_ctrl_type) do
    Openflow.Utils.int_to_flags([], int, enum_of(:bundle_ctrl_type))
  end

  def int_to_flags(int, :bundle_flags) do
    Openflow.Utils.int_to_flags([], int, enum_of(:bundle_flags))
  end

  def flags_to_int(flags, :openflow_codec) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:openflow_codec))
  end

  def flags_to_int(flags, :experimenter_id) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:experimenter_id))
  end

  def flags_to_int(flags, :nicira_ext_message) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nicira_ext_message))
  end

  def flags_to_int(flags, :onf_ext_message) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:onf_ext_message))
  end

  def flags_to_int(flags, :multipart_request_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:multipart_request_flags))
  end

  def flags_to_int(flags, :multipart_reply_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:multipart_reply_flags))
  end

  def flags_to_int(flags, :multipart_request_codec) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:multipart_request_codec))
  end

  def flags_to_int(flags, :multipart_reply_codec) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:multipart_reply_codec))
  end

  def flags_to_int(flags, :nicira_ext_stats) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nicira_ext_stats))
  end

  def flags_to_int(flags, :hello_elem) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:hello_elem))
  end

  def flags_to_int(flags, :error_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:error_type))
  end

  def flags_to_int(flags, :hello_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:hello_failed))
  end

  def flags_to_int(flags, :bad_request) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:bad_request))
  end

  def flags_to_int(flags, :bad_action) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:bad_action))
  end

  def flags_to_int(flags, :bad_instruction) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:bad_instruction))
  end

  def flags_to_int(flags, :bad_match) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:bad_match))
  end

  def flags_to_int(flags, :flow_mod_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:flow_mod_failed))
  end

  def flags_to_int(flags, :group_mod_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:group_mod_failed))
  end

  def flags_to_int(flags, :port_mod_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:port_mod_failed))
  end

  def flags_to_int(flags, :table_mod_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:table_mod_failed))
  end

  def flags_to_int(flags, :queue_op_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:queue_op_failed))
  end

  def flags_to_int(flags, :switch_config_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:switch_config_failed))
  end

  def flags_to_int(flags, :role_request_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:role_request_failed))
  end

  def flags_to_int(flags, :meter_mod_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:meter_mod_failed))
  end

  def flags_to_int(flags, :table_features_failed) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:table_features_failed))
  end

  def flags_to_int(flags, :switch_capabilities) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:switch_capabilities))
  end

  def flags_to_int(flags, :config_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:config_flags))
  end

  def flags_to_int(flags, :controller_max_len) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:controller_max_len))
  end

  def flags_to_int(flags, :experimenter_oxm_vendors) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:experimenter_oxm_vendors))
  end

  def flags_to_int(flags, :match_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:match_type))
  end

  def flags_to_int(flags, :oxm_class) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:oxm_class))
  end

  def flags_to_int(flags, :nxm_0) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nxm_0))
  end

  def flags_to_int(flags, :nxm_1) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nxm_1))
  end

  def flags_to_int(flags, :openflow_basic) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:openflow_basic))
  end

  def flags_to_int(flags, :vlan_id) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:vlan_id))
  end

  def flags_to_int(flags, :ipv6exthdr_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:ipv6exthdr_flags))
  end

  def flags_to_int(flags, :tcp_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:tcp_flags))
  end

  def flags_to_int(flags, :ct_state_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:ct_state_flags))
  end

  def flags_to_int(flags, :packet_register) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:packet_register))
  end

  def flags_to_int(flags, :nicira_ext_match) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nicira_ext_match))
  end

  def flags_to_int(flags, :hp_ext_match) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:hp_ext_match))
  end

  def flags_to_int(flags, :hp_custom_match_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:hp_custom_match_type))
  end

  def flags_to_int(flags, :onf_ext_match) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:onf_ext_match))
  end

  def flags_to_int(flags, :buffer_id) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:buffer_id))
  end

  def flags_to_int(flags, :port_config) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:port_config))
  end

  def flags_to_int(flags, :port_state) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:port_state))
  end

  def flags_to_int(flags, :port_features) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:port_features))
  end

  def flags_to_int(flags, :openflow10_port_no) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:openflow10_port_no))
  end

  def flags_to_int(flags, :openflow13_port_no) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:openflow13_port_no))
  end

  def flags_to_int(flags, :packet_in_reason) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:packet_in_reason))
  end

  def flags_to_int(flags, :packet_in_reason_mask) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:packet_in_reason_mask))
  end

  def flags_to_int(flags, :flow_mod_command) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:flow_mod_command))
  end

  def flags_to_int(flags, :flow_mod_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:flow_mod_flags))
  end

  def flags_to_int(flags, :flow_removed_reason) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:flow_removed_reason))
  end

  def flags_to_int(flags, :flow_removed_reason_mask) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:flow_removed_reason_mask))
  end

  def flags_to_int(flags, :port_reason) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:port_reason))
  end

  def flags_to_int(flags, :port_reason_mask) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:port_reason_mask))
  end

  def flags_to_int(flags, :group_mod_command) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:group_mod_command))
  end

  def flags_to_int(flags, :group_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:group_type))
  end

  def flags_to_int(flags, :group_type_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:group_type_flags))
  end

  def flags_to_int(flags, :group_id) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:group_id))
  end

  def flags_to_int(flags, :group_capabilities) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:group_capabilities))
  end

  def flags_to_int(flags, :table_id) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:table_id))
  end

  def flags_to_int(flags, :queue_id) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:queue_id))
  end

  def flags_to_int(flags, :meter_mod_command) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:meter_mod_command))
  end

  def flags_to_int(flags, :meter_id) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:meter_id))
  end

  def flags_to_int(flags, :meter_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:meter_flags))
  end

  def flags_to_int(flags, :meter_band_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:meter_band_type))
  end

  def flags_to_int(flags, :table_config) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:table_config))
  end

  def flags_to_int(flags, :action_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:action_type))
  end

  def flags_to_int(flags, :action_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:action_flags))
  end

  def flags_to_int(flags, :action_vendor) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:action_vendor))
  end

  def flags_to_int(flags, :onf_ext_action) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:onf_ext_action))
  end

  def flags_to_int(flags, :nicira_ext_action) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nicira_ext_action))
  end

  def flags_to_int(flags, :nx_mp_algorithm) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_mp_algorithm))
  end

  def flags_to_int(flags, :nx_hash_fields) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_hash_fields))
  end

  def flags_to_int(flags, :nx_bd_algorithm) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_bd_algorithm))
  end

  def flags_to_int(flags, :nx_learn_flag) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_learn_flag))
  end

  def flags_to_int(flags, :nx_conntrack_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_conntrack_flags))
  end

  def flags_to_int(flags, :nx_nat_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_nat_flags))
  end

  def flags_to_int(flags, :nx_nat_range) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_nat_range))
  end

  def flags_to_int(flags, :nx_action_controller2_prop_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_action_controller2_prop_type))
  end

  def flags_to_int(flags, :nx_action_sample_direction) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_action_sample_direction))
  end

  def flags_to_int(flags, :nx_flow_spec_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_flow_spec_type))
  end

  def flags_to_int(flags, :instruction_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:instruction_type))
  end

  def flags_to_int(flags, :controller_role) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:controller_role))
  end

  def flags_to_int(flags, :nx_role) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:nx_role))
  end

  def flags_to_int(flags, :packet_in_format) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:packet_in_format))
  end

  def flags_to_int(flags, :flow_format) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:flow_format))
  end

  def flags_to_int(flags, :packet_in2_prop_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:packet_in2_prop_type))
  end

  def flags_to_int(flags, :continuation_prop_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:continuation_prop_type))
  end

  def flags_to_int(flags, :flow_monitor_flag) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:flow_monitor_flag))
  end

  def flags_to_int(flags, :flow_update_event) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:flow_update_event))
  end

  def flags_to_int(flags, :tlv_table_mod_command) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:tlv_table_mod_command))
  end

  def flags_to_int(flags, :table_feature_prop_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:table_feature_prop_type))
  end

  def flags_to_int(flags, :bundle_ctrl_type) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:bundle_ctrl_type))
  end

  def flags_to_int(flags, :bundle_flags) do
    Openflow.Utils.flags_to_int(0, flags, enum_of(:bundle_flags))
  end

  defp enum_of(:openflow_codec),
    do: [
      {Openflow.Hello, 0},
      {Openflow.ErrorMsg, 1},
      {Openflow.Echo.Request, 2},
      {Openflow.Echo.Reply, 3},
      {Openflow.Experimenter, 4},
      {Openflow.Features.Request, 5},
      {Openflow.Features.Reply, 6},
      {Openflow.GetConfig.Request, 7},
      {Openflow.GetConfig.Reply, 8},
      {Openflow.SetConfig, 9},
      {Openflow.PacketIn, 10},
      {Openflow.FlowRemoved, 11},
      {Openflow.PortStatus, 12},
      {Openflow.PacketOut, 13},
      {Openflow.FlowMod, 14},
      {Openflow.GroupMod, 15},
      {Openflow.PortMod, 16},
      {Openflow.TableMod, 17},
      {Openflow.Multipart.Request, 18},
      {Openflow.Multipart.Reply, 19},
      {Openflow.Barrier.Request, 20},
      {Openflow.Barrier.Reply, 21},
      {Openflow.Role.Request, 24},
      {Openflow.Role.Reply, 25},
      {Openflow.GetAsync.Request, 26},
      {Openflow.GetAsync.Reply, 27},
      {Openflow.SetAsync, 28},
      {Openflow.MeterMod, 29}
    ]

  defp enum_of(:experimenter_id), do: [nicira_ext_message: 8992, onf_ext_message: 1_330_529_792]

  defp enum_of(:nicira_ext_message),
    do: [
      {Openflow.NxSetPacketInFormat, 16},
      {Openflow.NxSetControllerId, 20},
      {Openflow.NxFlowMonitor.Cancel, 21},
      {Openflow.NxFlowMonitor.Paused, 22},
      {Openflow.NxFlowMonitor.Resumed, 23},
      {Openflow.NxTLVTableMod, 24},
      {Openflow.NxTLVTable.Request, 25},
      {Openflow.NxTLVTable.Reply, 26},
      {Openflow.NxSetAsyncConfig2, 27},
      {Openflow.NxResume, 28},
      {Openflow.NxCtFlushZone, 29},
      {Openflow.NxPacketIn2, 30}
    ]

  defp enum_of(:onf_ext_message),
    do: [{Openflow.OnfBundleControl, 2300}, {Openflow.OnfBundleAddMessage, 2301}]

  defp enum_of(:multipart_request_flags), do: [more: 1]
  defp enum_of(:multipart_reply_flags), do: [more: 1]

  defp enum_of(:multipart_request_codec),
    do: [
      {Openflow.Multipart.Desc.Request, 0},
      {Openflow.Multipart.Flow.Request, 1},
      {Openflow.Multipart.Aggregate.Request, 2},
      {Openflow.Multipart.Table.Request, 3},
      {Openflow.Multipart.PortStats.Request, 4},
      {Openflow.Multipart.Queue.Request, 5},
      {Openflow.Multipart.Group.Request, 6},
      {Openflow.Multipart.GroupDesc.Request, 7},
      {Openflow.Multipart.GroupFeatures.Request, 8},
      {Openflow.Multipart.Meter.Request, 9},
      {Openflow.Multipart.MeterConfig.Request, 10},
      {Openflow.Multipart.MeterFeatures.Request, 11},
      {Openflow.Multipart.TableFeatures.Request, 12},
      {Openflow.Multipart.PortDesc.Request, 13},
      {Openflow.Multipart.Experimenter.Request, 65535}
    ]

  defp enum_of(:multipart_reply_codec),
    do: [
      {Openflow.Multipart.Desc.Reply, 0},
      {Openflow.Multipart.Flow.Reply, 1},
      {Openflow.Multipart.Aggregate.Reply, 2},
      {Openflow.Multipart.Table.Reply, 3},
      {Openflow.Multipart.PortStats.Reply, 4},
      {Openflow.Multipart.Queue.Reply, 5},
      {Openflow.Multipart.Group.Reply, 6},
      {Openflow.Multipart.GroupDesc.Reply, 7},
      {Openflow.Multipart.GroupFeatures.Reply, 8},
      {Openflow.Multipart.Meter.Reply, 9},
      {Openflow.Multipart.MeterConfig.Reply, 10},
      {Openflow.Multipart.MeterFeatures.Reply, 11},
      {Openflow.Multipart.TableFeatures.Reply, 12},
      {Openflow.Multipart.PortDesc.Reply, 13},
      {Openflow.Multipart.Experimenter.Reply, 65535}
    ]

  defp enum_of(:nicira_ext_stats),
    do: [
      {Openflow.Multipart.NxFlow, 0},
      {Openflow.Multipart.NxAggregate, 1},
      {Openflow.Multipart.NxFlowMonitor, 2},
      {Openflow.Multipart.NxIPFIXBridge, 3},
      {Openflow.Multipart.NxIPFIXFlow, 4}
    ]

  defp enum_of(:hello_elem), do: [versionbitmap: 1]

  defp enum_of(:error_type),
    do: [
      hello_failed: 0,
      bad_request: 1,
      bad_action: 2,
      bad_instruction: 3,
      bad_match: 4,
      flow_mod_failed: 5,
      group_mod_failed: 6,
      port_mod_failed: 7,
      table_mod_failed: 8,
      queue_op_failed: 9,
      switch_config_failed: 10,
      role_request_failed: 11,
      meter_mod_failed: 12,
      table_features_failed: 13,
      experimenter: 65535
    ]

  defp enum_of(:hello_failed), do: [inconpatible: 0, eperm: 1]

  defp enum_of(:bad_request),
    do: [
      bad_version: 0,
      bad_type: 1,
      bad_multipart: 2,
      bad_experimeter: 3,
      bad_exp_type: 4,
      eperm: 5,
      bad_len: 6,
      buffer_empty: 7,
      buffer_unknown: 8,
      bad_table_id: 9,
      is_slave: 10,
      bad_port: 11,
      bad_packet: 12,
      multipart_buffer_overflow: 13,
      multipart_request_timeout: 14,
      multipart_reply_timeout: 15,
      nxm_invalid: 256,
      nxm_bad_type: 257,
      must_be_zero: 515,
      bad_reason: 516,
      flow_monitor_bad_event: 520,
      undecodable_error: 521,
      resume_not_supported: 533,
      resume_stale: 534
    ]

  defp enum_of(:bad_action),
    do: [
      bad_type: 0,
      bad_len: 1,
      bad_experimeter: 2,
      bad_exp_type: 3,
      bad_out_port: 4,
      bad_argument: 5,
      eperm: 6,
      too_many: 7,
      bad_queue: 8,
      bad_out_group: 9,
      match_inconsistent: 10,
      unsupported_order: 11,
      bad_tag: 12,
      bad_set_type: 13,
      bad_set_len: 14,
      bad_set_argument: 15,
      must_be_zero: 256,
      conntrack_datapath_support: 265,
      bad_conjunction: 526
    ]

  defp enum_of(:bad_instruction),
    do: [
      unknown_instruction: 0,
      unsupported_instruction: 1,
      bad_table_id: 2,
      unsupported_metadata: 3,
      unsupported_metadata_mask: 4,
      bad_experimeter: 5,
      bad_exp_type: 6,
      bad_len: 7,
      eperm: 8,
      dup_inst: 256
    ]

  defp enum_of(:bad_match),
    do: [
      bad_type: 0,
      bad_len: 1,
      bad_tag: 2,
      bad_dl_addr_mask: 3,
      bad_nw_addr_mask: 4,
      bad_wildcards: 5,
      bad_field: 6,
      bad_value: 7,
      bad_mask: 8,
      bad_prereq: 9,
      dup_field: 10,
      eperm: 11,
      conntrack_datapath_support: 264
    ]

  defp enum_of(:flow_mod_failed),
    do: [
      unknown: 0,
      table_full: 1,
      bad_table_id: 2,
      overlap: 3,
      eperm: 4,
      bad_timeout: 5,
      bad_command: 6,
      bad_flags: 7
    ]

  defp enum_of(:group_mod_failed),
    do: [
      group_exists: 0,
      invalid_group: 1,
      weight_unsupported: 2,
      out_of_groups: 3,
      ouf_of_buckets: 4,
      chaining_unsupported: 5,
      watch_unsupported: 6,
      loop: 7,
      unknown_group: 8,
      chained_group: 9,
      bad_type: 10,
      bad_command: 11,
      bad_bucket: 12,
      bad_watch: 13,
      eperm: 14,
      unknown_bucket: 15,
      bucket_exists: 16
    ]

  defp enum_of(:port_mod_failed),
    do: [bad_port: 0, bad_hw_addr: 1, bad_config: 2, bad_advertise: 3, eperm: 4]

  defp enum_of(:table_mod_failed), do: [bad_table: 0, bad_config: 1, eperm: 2]
  defp enum_of(:queue_op_failed), do: [bad_port: 0, bad_queue: 1, eperm: 2]
  defp enum_of(:switch_config_failed), do: [bad_flags: 0, bad_len: 1, eperm: 2]
  defp enum_of(:role_request_failed), do: [stale: 0, unsup: 1, bad_role: 2]

  defp enum_of(:meter_mod_failed),
    do: [
      unknown: 0,
      meter_exists: 1,
      invalid_meter: 2,
      unknown_meter: 3,
      bad_command: 4,
      bad_flags: 5,
      bad_rate: 6,
      bad_burst: 7,
      bad_band: 8,
      bad_band_value: 9,
      out_of_meters: 10,
      out_of_bands: 11
    ]

  defp enum_of(:table_features_failed),
    do: [
      bad_table: 0,
      bad_metadata: 1,
      bad_type: 2,
      bad_len: 3,
      bad_argument: 4,
      eperm: 5
    ]

  defp enum_of(:switch_capabilities),
    do: [
      flow_stats: 1,
      table_stats: 2,
      port_stats: 4,
      group_stats: 8,
      ip_reasm: 32,
      queue_stats: 64,
      arp_match_ip: 128,
      port_blocked: 256
    ]

  defp enum_of(:config_flags), do: [drop: 1, reasm: 2]
  defp enum_of(:controller_max_len), do: [max: 65509, no_buffer: 65535]

  defp enum_of(:experimenter_oxm_vendors),
    do: [nicira_ext_match: 8992, hp_ext_match: 9256, onf_ext_match: 1_330_529_792]

  defp enum_of(:match_type), do: [standard: 0, oxm: 1]

  defp enum_of(:oxm_class),
    do: [
      nxm_0: 0,
      nxm_1: 1,
      openflow_basic: 32768,
      packet_register: 32769,
      experimenter: 65535
    ]

  defp enum_of(:nxm_0),
    do: [
      nx_in_port: 0,
      nx_eth_dst: 1,
      nx_eth_src: 2,
      nx_eth_type: 3,
      nx_vlan_tci: 4,
      nx_ip_tos: 5,
      nx_ip_proto: 6,
      nx_ipv4_src: 7,
      nx_ipv4_dst: 8,
      nx_tcp_src: 9,
      nx_tcp_dst: 10,
      nx_udp_src: 11,
      nx_udp_dst: 12,
      nx_icmpv4_type: 13,
      nx_icmpv4_code: 14,
      nx_arp_op: 15,
      nx_arp_spa: 16,
      nx_arp_tpa: 17,
      nx_tcp_flags: 34
    ]

  defp enum_of(:nxm_1),
    do: [
      reg0: 0,
      reg1: 1,
      reg2: 2,
      reg3: 3,
      reg4: 4,
      reg5: 5,
      reg6: 6,
      reg7: 7,
      reg8: 8,
      reg9: 9,
      reg10: 10,
      reg11: 11,
      reg12: 12,
      reg13: 13,
      reg14: 14,
      reg15: 15,
      tun_id: 16,
      nx_arp_sha: 17,
      nx_arp_tha: 18,
      nx_ipv6_src: 19,
      nx_ipv6_dst: 20,
      nx_icmpv6_type: 21,
      nx_icmpv6_code: 22,
      nx_ipv6_nd_target: 23,
      nx_ipv6_nd_sll: 24,
      nx_ipv6_nd_tll: 25,
      nx_ip_frag: 26,
      nx_ipv6_label: 27,
      nx_ip_ecn: 28,
      nx_ip_ttl: 29,
      nx_mpls_ttl: 30,
      tun_src: 31,
      tun_dst: 32,
      pkt_mark: 33,
      dp_hash: 35,
      recirc_id: 36,
      conj_id: 37,
      tun_gbp_id: 38,
      tun_gbp_flags: 39,
      tun_metadata0: 40,
      tun_metadata1: 41,
      tun_metadata2: 42,
      tun_metadata3: 43,
      tun_metadata4: 44,
      tun_metadata5: 45,
      tun_metadata6: 46,
      tun_metadata7: 47,
      tun_metadata8: 48,
      tun_metadata9: 49,
      tun_metadata10: 50,
      tun_metadata11: 51,
      tun_metadata12: 52,
      tun_metadata13: 53,
      tun_metadata14: 54,
      tun_metadata15: 55,
      tun_metadata16: 56,
      tun_metadata17: 57,
      tun_metadata18: 58,
      tun_metadata19: 59,
      tun_metadata20: 60,
      tun_metadata21: 61,
      tun_metadata22: 62,
      tun_metadata23: 63,
      tun_metadata24: 64,
      tun_metadata25: 65,
      tun_metadata26: 66,
      tun_metadata27: 67,
      tun_metadata28: 68,
      tun_metadata29: 69,
      tun_metadata30: 70,
      tun_metadata31: 71,
      tun_metadata32: 72,
      tun_metadata33: 73,
      tun_metadata34: 74,
      tun_metadata35: 75,
      tun_metadata36: 76,
      tun_metadata37: 77,
      tun_metadata38: 78,
      tun_metadata39: 79,
      tun_metadata40: 80,
      tun_metadata41: 81,
      tun_metadata42: 82,
      tun_metadata43: 83,
      tun_metadata44: 84,
      tun_metadata45: 85,
      tun_metadata46: 86,
      tun_metadata47: 87,
      tun_metadata48: 88,
      tun_metadata49: 89,
      tun_metadata50: 90,
      tun_metadata51: 91,
      tun_metadata52: 92,
      tun_metadata53: 93,
      tun_metadata54: 94,
      tun_metadata55: 95,
      tun_metadata56: 96,
      tun_metadata57: 97,
      tun_metadata58: 98,
      tun_metadata59: 99,
      tun_metadata60: 100,
      tun_metadata61: 101,
      tun_metadata62: 102,
      tun_metadata63: 103,
      tun_flags: 104,
      ct_state: 105,
      ct_zone: 106,
      ct_mark: 107,
      ct_label: 108,
      tun_ipv6_src: 109,
      tun_ipv6_dst: 110,
      xxreg0: 111,
      xxreg1: 112,
      xxreg2: 113,
      xxreg3: 114,
      xxreg4: 115,
      xxreg5: 116,
      xxreg6: 117,
      xxreg7: 118,
      ct_nw_proto: 119,
      ct_nw_src: 120,
      ct_nw_dst: 121,
      ct_ipv6_src: 122,
      ct_ipv6_dst: 123,
      ct_tp_src: 124,
      ct_tp_dst: 125
    ]

  defp enum_of(:openflow_basic),
    do: [
      in_port: 0,
      in_phy_port: 1,
      metadata: 2,
      eth_dst: 3,
      eth_src: 4,
      eth_type: 5,
      vlan_vid: 6,
      vlan_pcp: 7,
      ip_dscp: 8,
      ip_ecn: 9,
      ip_proto: 10,
      ipv4_src: 11,
      ipv4_dst: 12,
      tcp_src: 13,
      tcp_dst: 14,
      udp_src: 15,
      udp_dst: 16,
      sctp_src: 17,
      sctp_dst: 18,
      icmpv4_type: 19,
      icmpv4_code: 20,
      arp_op: 21,
      arp_spa: 22,
      arp_tpa: 23,
      arp_sha: 24,
      arp_tha: 25,
      ipv6_src: 26,
      ipv6_dst: 27,
      ipv6_flabel: 28,
      icmpv6_type: 29,
      icmpv6_code: 30,
      ipv6_nd_target: 31,
      ipv6_nd_sll: 32,
      ipv6_nd_tll: 33,
      mpls_label: 34,
      mpls_tc: 35,
      mpls_bos: 36,
      pbb_isid: 37,
      tunnel_id: 38,
      ipv6_exthdr: 39,
      pbb_uca: 41,
      packet_type: 42,
      gre_flags: 43,
      gre_ver: 44,
      gre_protocol: 45,
      gre_key: 46,
      gre_seqnum: 47,
      lisp_flags: 48,
      lisp_nonce: 49,
      lisp_id: 50,
      vxlan_flags: 51,
      vxlan_vni: 52,
      mpls_data_first_nibble: 53,
      mpls_ach_version: 54,
      mpls_ach_channel: 55,
      mpls_pw_metadata: 56,
      mpls_cw_flags: 57,
      mpls_cw_fragment: 58,
      mpls_cw_len: 59,
      mpls_cw_seq_num: 60,
      gtpu_flags: 61,
      gtpu_ver: 62,
      gtpu_msg_type: 63,
      gtpu_teid: 64,
      gtpu_extn_hdr: 65,
      gtpu_extn_udp_port: 66,
      gtpu_extn_sci: 67
    ]

  defp enum_of(:vlan_id), do: [present: 4096, none: 0]

  defp enum_of(:ipv6exthdr_flags),
    do: [
      nonext: 1,
      esp: 2,
      auth: 4,
      dest: 8,
      frag: 16,
      router: 32,
      hop: 64,
      unrep: 128,
      unseq: 256
    ]

  defp enum_of(:tcp_flags),
    do: [fin: 1, syn: 2, rst: 4, psh: 8, ack: 16, urg: 32, ece: 64, cwr: 128, ns: 256]

  defp enum_of(:ct_state_flags),
    do: [new: 1, est: 2, rel: 4, rep: 8, inv: 16, trk: 32, snat: 64, dnat: 128]

  defp enum_of(:packet_register),
    do: [xreg0: 0, xreg1: 1, xreg2: 2, xreg3: 3, xreg4: 4, xreg5: 5, xreg6: 6, xreg7: 7]

  defp enum_of(:nicira_ext_match),
    do: [
      nsh_flags: 1,
      nsh_mdtype: 2,
      nsh_np: 3,
      nsh_spi: 4,
      nsh_si: 5,
      nsh_c1: 6,
      nsh_c2: 7,
      nsh_c3: 8,
      nsh_c4: 9
    ]

  defp enum_of(:hp_ext_match),
    do: [
      hp_udp_src_port_range: 0,
      hp_udp_dst_port_range: 1,
      hp_tcp_src_port_range: 2,
      hp_tcp_dst_port_range: 3,
      hp_tcp_flags: 4,
      hp_custom_1: 5,
      hp_custom_2: 6,
      hp_custom_3: 7,
      hp_custom_4: 8
    ]

  defp enum_of(:hp_custom_match_type), do: [l2_start: 1, l3_start: 2, l4_start: 3]
  defp enum_of(:onf_ext_match), do: [onf_tcp_flags: 42, onf_actset_output: 43, onf_pbb_uca: 2560]
  defp enum_of(:buffer_id), do: [no_buffer: 4_294_967_295]
  defp enum_of(:port_config), do: [port_down: 1, no_receive: 4, no_forward: 32, no_packet_in: 64]
  defp enum_of(:port_state), do: [link_down: 1, blocked: 2, live: 4]

  defp enum_of(:port_features),
    do: [
      "10mb_hd": 1,
      "10mb_fd": 2,
      "100mb_hd": 4,
      "100mb_fd": 8,
      "1gb_hd": 16,
      "1gb_fd": 32,
      "10gb_fd": 64,
      "40gb_fd": 128,
      "100gb_fd": 256,
      "1tb_fd": 512,
      other: 1024,
      copper: 2048,
      fiber: 4096,
      autoneg: 8192,
      pause: 16384,
      pause_asym: 32768
    ]

  defp enum_of(:openflow10_port_no),
    do: [
      max: 65280,
      in_port: 65528,
      table: 65529,
      normal: 65530,
      flood: 65531,
      all: 65532,
      controller: 65533,
      local: 65534,
      none: 65535
    ]

  defp enum_of(:openflow13_port_no),
    do: [
      max: 4_294_967_040,
      in_port: 4_294_967_288,
      table: 4_294_967_289,
      normal: 4_294_967_290,
      flood: 4_294_967_291,
      all: 4_294_967_292,
      controller: 4_294_967_293,
      local: 4_294_967_294,
      any: 4_294_967_295
    ]

  defp enum_of(:packet_in_reason),
    do: [no_match: 0, action: 1, invalid_ttl: 2, action_set: 3, group: 4, packet_out: 5]

  defp enum_of(:packet_in_reason_mask),
    do: [
      no_match: 1,
      action: 2,
      invalid_ttl: 4,
      action_set: 8,
      group: 16,
      packet_out: 32
    ]

  defp enum_of(:flow_mod_command),
    do: [add: 0, modify: 1, modify_strict: 2, delete: 3, delete_strict: 4]

  defp enum_of(:flow_mod_flags),
    do: [
      send_flow_rem: 1,
      check_overlap: 2,
      reset_counts: 4,
      no_packet_counts: 8,
      no_byte_counts: 16
    ]

  defp enum_of(:flow_removed_reason),
    do: [
      idle_timeout: 0,
      hard_timeout: 1,
      delete: 2,
      group_delete: 3,
      meter_delete: 4,
      eviction: 5
    ]

  defp enum_of(:flow_removed_reason_mask),
    do: [
      idle_timeout: 1,
      hard_timeout: 2,
      delete: 4,
      group_delete: 8,
      meter_delete: 16,
      eviction: 32
    ]

  defp enum_of(:port_reason), do: [add: 0, delete: 1, modify: 2]
  defp enum_of(:port_reason_mask), do: [add: 1, delete: 2, modify: 4]
  defp enum_of(:group_mod_command), do: [add: 0, modify: 1, delete: 2]
  defp enum_of(:group_type), do: [all: 0, select: 1, indirect: 2, fast_failover: 3]
  defp enum_of(:group_type_flags), do: [all: 1, select: 2, indirect: 4, fast_failover: 8]
  defp enum_of(:group_id), do: [max: 4_294_967_040, all: 4_294_967_292, any: 4_294_967_295]

  defp enum_of(:group_capabilities),
    do: [select_weight: 1, select_liveness: 2, chaining: 4, chaining_checks: 8]

  defp enum_of(:table_id), do: [max: 254, all: 255]
  defp enum_of(:queue_id), do: [all: 4_294_967_295]
  defp enum_of(:meter_mod_command), do: [add: 0, modify: 1, delete: 2]

  defp enum_of(:meter_id),
    do: [
      max: 4_294_901_760,
      slowpath: 4_294_967_293,
      controller: 4_294_967_294,
      all: 4_294_967_295
    ]

  defp enum_of(:meter_flags), do: [kbps: 1, pktps: 2, burst: 4, stats: 8]

  defp enum_of(:meter_band_type),
    do: [
      {Openflow.MeterBand.Drop, 1},
      {Openflow.MeterBand.Remark, 2},
      {Openflow.MeterBand.Experimenter, 65535}
    ]

  defp enum_of(:table_config),
    do: [
      table_miss_controller: 0,
      table_miss_continue: 1,
      table_miss_drop: 2,
      table_miss_mask: 3,
      eviction: 4,
      vacancy_events: 8
    ]

  defp enum_of(:action_type),
    do: [
      {Openflow.Action.Output, 0},
      {Openflow.Action.CopyTtlOut, 11},
      {Openflow.Action.CopyTtlIn, 12},
      {Openflow.Action.SetMplsTtl, 15},
      {Openflow.Action.DecMplsTtl, 16},
      {Openflow.Action.PushVlan, 17},
      {Openflow.Action.PopVlan, 18},
      {Openflow.Action.PushMpls, 19},
      {Openflow.Action.PopMpls, 20},
      {Openflow.Action.SetQueue, 21},
      {Openflow.Action.Group, 22},
      {Openflow.Action.SetNwTtl, 23},
      {Openflow.Action.DecNwTtl, 24},
      {Openflow.Action.SetField, 25},
      {Openflow.Action.PushPbb, 26},
      {Openflow.Action.PopPbb, 27},
      {Openflow.Action.Encap, 28},
      {Openflow.Action.Decap, 29},
      {Openflow.Action.SetSequence, 30},
      {Openflow.Action.ValidateSequence, 31},
      {Openflow.Action.Experimenter, 65535}
    ]

  defp enum_of(:action_flags),
    do: [
      {Openflow.Action.Output, 1},
      {Openflow.Action.CopyTtlOut, 2048},
      {Openflow.Action.CopyTtlIn, 4096},
      {Openflow.Action.SetMplsTtl, 32768},
      {Openflow.Action.DecMplsTtl, 65536},
      {Openflow.Action.PushVlan, 131_072},
      {Openflow.Action.PopVlan, 262_144},
      {Openflow.Action.PushMpls, 524_288},
      {Openflow.Action.PopMpls, 1_048_576},
      {Openflow.Action.SetQueue, 2_097_152},
      {Openflow.Action.Group, 4_194_304},
      {Openflow.Action.SetNwTtl, 8_388_608},
      {Openflow.Action.DecNwTtl, 16_777_216},
      {Openflow.Action.SetField, 33_554_432},
      {Openflow.Action.PushPbb, 67_108_864},
      {Openflow.Action.PopPbb, 134_217_728},
      {Openflow.Action.Encap, 268_435_456},
      {Openflow.Action.Decap, 536_870_912},
      {Openflow.Action.SetSequence, 1_073_741_824},
      {Openflow.Action.ValidateSequence, 2_147_483_648},
      {Openflow.Action.Experimenter, 65535}
    ]

  defp enum_of(:action_vendor), do: [nicira_ext_action: 8992, onf_ext_action: 1_330_529_792]
  defp enum_of(:onf_ext_action), do: [{Openflow.Action.OnfCopyField, 3200}]

  defp enum_of(:nicira_ext_action),
    do: [
      {Openflow.Action.NxResubmit, 1},
      {Openflow.Action.NxSetTunnel, 2},
      {Openflow.Action.NxRegMove, 6},
      {Openflow.Action.NxRegLoad, 7},
      {Openflow.Action.NxNote, 8},
      {Openflow.Action.NxSetTunnel64, 9},
      {Openflow.Action.NxMultipath, 10},
      {Openflow.Action.NxBundle, 12},
      {Openflow.Action.NxBundleLoad, 13},
      {Openflow.Action.NxResubmitTable, 14},
      {Openflow.Action.NxOutputReg, 15},
      {Openflow.Action.NxLearn, 16},
      {Openflow.Action.NxExit, 17},
      {Openflow.Action.NxDecTtl, 18},
      {Openflow.Action.NxFinTimeout, 19},
      {Openflow.Action.NxController, 20},
      {Openflow.Action.NxDecTtlCntIds, 21},
      {Openflow.Action.NxWriteMetadata, 22},
      {Openflow.Action.NxStackPush, 27},
      {Openflow.Action.NxStackPop, 28},
      {Openflow.Action.NxSample, 29},
      {Openflow.Action.NxOutputReg2, 32},
      {Openflow.Action.NxRegLoad2, 33},
      {Openflow.Action.NxConjunction, 34},
      {Openflow.Action.NxConntrack, 35},
      {Openflow.Action.NxNat, 36},
      {Openflow.Action.NxController2, 37},
      {Openflow.Action.NxSample2, 38},
      {Openflow.Action.NxOutputTrunc, 39},
      {Openflow.Action.NxGroup, 40},
      {Openflow.Action.NxSample3, 41},
      {Openflow.Action.NxClone, 42},
      {Openflow.Action.NxCtClear, 43},
      {Openflow.Action.NxResubmitTableCt, 44},
      {Openflow.Action.NxLearn2, 45},
      {Openflow.Action.NxEncap, 46},
      {Openflow.Action.NxDecap, 47},
      {Openflow.Action.NxDebugRecirc, 255}
    ]

  defp enum_of(:nx_mp_algorithm),
    do: [modulo_n: 0, hash_threshold: 1, highest_random_weight: 2, iterative_hash: 3]

  defp enum_of(:nx_hash_fields),
    do: [
      eth_src: 0,
      symmetric_l4: 1,
      symmetric_l3l4: 2,
      symmetric_l3l4_udp: 3,
      nw_src: 4,
      nw_dst: 5
    ]

  defp enum_of(:nx_bd_algorithm), do: [active_backup: 0, highest_random_weight: 1]
  defp enum_of(:nx_learn_flag), do: [send_flow_rem: 1, delete_learned: 2, write_result: 4]
  defp enum_of(:nx_conntrack_flags), do: [commit: 1, force: 2]

  defp enum_of(:nx_nat_flags),
    do: [src: 1, dst: 2, persistent: 4, protocol_hash: 8, protocol_random: 16]

  defp enum_of(:nx_nat_range),
    do: [
      ipv4_min: 1,
      ipv4_max: 2,
      ipv6_min: 4,
      ipv6_max: 8,
      proto_min: 16,
      proto_max: 32
    ]

  defp enum_of(:nx_action_controller2_prop_type),
    do: [max_len: 0, controller_id: 1, reason: 2, userdata: 3, pause: 4]

  defp enum_of(:nx_action_sample_direction), do: [default: 0, ingress: 1, egress: 2]

  defp enum_of(:nx_flow_spec_type),
    do: [
      {Openflow.Action.NxFlowSpecMatch, 0},
      {Openflow.Action.NxFlowSpecLoad, 1},
      {Openflow.Action.NxFlowSpecOutput, 2}
    ]

  defp enum_of(:instruction_type),
    do: [
      {Openflow.Instruction.GotoTable, 1},
      {Openflow.Instruction.WriteMetadata, 2},
      {Openflow.Instruction.WriteActions, 3},
      {Openflow.Instruction.ApplyActions, 4},
      {Openflow.Instruction.ClearActions, 5},
      {Openflow.Instruction.Meter, 6},
      {Openflow.Instruction.Experimenter, 65535}
    ]

  defp enum_of(:controller_role), do: [nochange: 0, equal: 1, master: 2, slave: 3]
  defp enum_of(:nx_role), do: [other: 0, master: 1, slave: 2]
  defp enum_of(:packet_in_format), do: [standard: 0, nxt_packet_in: 1, nxt_packet_in2: 2]
  defp enum_of(:flow_format), do: [openflow10: 0, nxm: 1]

  defp enum_of(:packet_in2_prop_type),
    do: [
      packet: 0,
      full_len: 1,
      buffer_id: 2,
      table_id: 3,
      cookie: 4,
      reason: 5,
      metadata: 6,
      userdata: 7,
      continuation: 8
    ]

  defp enum_of(:continuation_prop_type),
    do: [
      bridge: 32768,
      stack: 32769,
      mirrors: 32770,
      conntracked: 32771,
      table_id: 32772,
      cookie: 32773,
      actions: 32774,
      action_set: 32775
    ]

  defp enum_of(:flow_monitor_flag),
    do: [initial: 1, add: 2, delete: 4, modify: 8, actions: 16, own: 32]

  defp enum_of(:flow_update_event), do: [added: 0, deleted: 1, modified: 2, abbrev: 3]
  defp enum_of(:tlv_table_mod_command), do: [add: 0, delete: 1, clear: 2]

  defp enum_of(:table_feature_prop_type),
    do: [
      instructions: 0,
      instructions_miss: 1,
      next_tables: 2,
      next_tables_miss: 3,
      write_actions: 4,
      write_actions_miss: 5,
      apply_actions: 6,
      apply_actions_miss: 7,
      match: 8,
      wildcards: 10,
      write_setfield: 12,
      write_setfield_miss: 13,
      apply_setfield: 14,
      apply_setfield_miss: 15,
      experimenter: 65534,
      experimenter_miss: 65535
    ]

  defp enum_of(:bundle_ctrl_type),
    do: [
      open_request: 0,
      open_reply: 1,
      close_request: 2,
      close_reply: 3,
      commit_request: 4,
      commit_reply: 5,
      discard_request: 6,
      discard_reply: 7
    ]

  defp enum_of(:bundle_flags), do: [atomic: 1, ordered: 2]
end
