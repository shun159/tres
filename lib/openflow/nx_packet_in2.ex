defmodule Openflow.NxPacketIn2 do
  defstruct(
    version:        4,
    xid:            0,
    datapath_id:   "",
    aux_id:         0,
    # packet_in properties:
    packet:       nil,
    full_len:     nil,
    buffer_id:    nil,
    table_id:     nil,
    cookie:       nil,
    reason:       nil,
    metadata:     nil,
    userdata:     nil,
    # continuation properties:
    continuation_bridge:      "",
    continuation_stack:       [],
    continuation_conntracked: false,
    continuation_table_id:    nil,
    continuation_cookie:      nil,
    continuation_actions:     [],
    continuation_action_set:  nil
  )

  alias __MODULE__

  @experimenter 0x00002320
  @nx_type 30

  @packet       0
  @full_len     1
  @buffer_id    2
  @table_id     3
  @cookie       4
  @reason       5
  @metadata     6
  @userdata     7
  @continuation 8

  @nxcpt_bridge      0x8000
  @nxcpt_stack       0x8001
  @nxcpt_mirrors     0x8002
  @nxcpt_conntracked 0x8003
  @nxcpt_table_id    0x8004
  @nxcpt_cookie      0x8005
  @nxcpt_actions     0x8006
  @nxcpt_action_set  0x8007

  @prop_header_length 4

  def ofp_type, do: 4

  def read(<<@experimenter::32, @nx_type::32, props_bin::bytes>>) do
    %NxPacketIn2{}
    |> decode_props(props_bin)
  end

  ## private functions

  defp decode_props(pktin, ""), do: pktin
  defp decode_props(pktin, <<@packet::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    packet_length = length - @prop_header_length
    <<packet::size(packet_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_props(%{pktin|packet: packet}, rest)
  end
  defp decode_props(pktin, <<@full_len::16, _length::16, full_len::32, rest::bytes>>) do
    decode_props(%{pktin|full_len: full_len}, rest)
  end
  defp decode_props(pktin, <<@buffer_id::16, _length::16, buffer_id::32, rest::bytes>>) do
    decode_props(%{pktin|buffer_id: buffer_id}, rest)
  end
  defp decode_props(pktin, <<@table_id::16, _length::16, table_id::8, _::24, rest::bytes>>) do
     decode_props(%{pktin|table_id: table_id}, rest)
  end
  defp decode_props(pktin, <<@cookie::16, _length::16, _::32, cookie::64, rest::bytes>>) do
    decode_props(%{pktin|cookie: cookie}, rest)
  end
  defp decode_props(pktin, <<@reason::16, _length::16, reason_int::8, _::24, rest::bytes>>) do
    reason = Openflow.Enums.to_atom(reason_int, :packet_in_reason)
    decode_props(%{pktin|reason: reason}, rest)
  end
  defp decode_props(pktin, <<@metadata::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    match_field_length = length - @prop_header_length
    <<match_fields_bin::size(match_field_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    match_len = 4 + byte_size(match_fields_bin)
    padding = Openflow.Utils.pad_length(match_len, 8)
    match_bin = (<<1::16, match_len::16, match_fields_bin::bytes, 0::size(padding)-unit(8)>>)
    {fields, _rest} = Openflow.Match.read(match_bin)
    decode_props(%{pktin|metadata: fields}, rest)
  end
  defp decode_props(pktin, <<@userdata::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    userdata_length = length - @prop_header_length
    <<userdata::size(userdata_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_props(%{pktin|userdata: userdata}, rest)
  end
  defp decode_props(pktin, <<@continuation::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length - 4
    <<_pad::32, data::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    pktin
    |> decode_continuations(data)
    |> decode_props(rest)
  end
  defp decode_props(pktin, <<_::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length
    <<_data::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_props(pktin, rest)
  end

  defp decode_continuations(pktin, ""), do: pktin
  defp decode_continuations(pktin, <<@nxcpt_bridge::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length
    <<bridge::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin|continuation_bridge: bridge}, rest)
  end
  defp decode_continuations(pktin, <<@nxcpt_stack::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = (length - @prop_header_length) * 8
    <<stack::size(data_length), _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin|continuation_stack: pktin.continuation_stack ++ [stack]}, rest)
  end
  defp decode_continuations(pktin, <<@nxcpt_mirrors::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length
    <<mirrors::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin|continuation_mirrors: mirrors}, rest)
  end
  defp decode_continuations(pktin, <<@nxcpt_conntracked::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length
    <<_::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin|continuation_conntracked: true}, rest)
  end
  defp decode_continuations(pktin, <<@nxcpt_table_id::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    <<table_id::8, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin|continuation_table_id: table_id}, rest)
  end
  defp decode_continuations(pktin, <<@nxcpt_cookie::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    <<cookie::64, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin|continuation_cookie: cookie}, rest)
  end
  defp decode_continuations(pktin, <<@nxcpt_actions::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length - 4
    <<_pad::32, actions::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin|continuation_actions: Openflow.Action.read(actions)}, rest)
  end
  defp decode_continuations(pktin, <<@nxcpt_action_set::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length
    <<action_set::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin|continuation_action_set: action_set}, rest)
  end
  defp decode_continuations(pktin, _) do
    decode_continuations(pktin, "")
  end
end
