defmodule Openflow.NxResume do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    # packet_in properties:
    packet: nil,
    full_len: nil,
    buffer_id: nil,
    table_id: nil,
    cookie: nil,
    reason: nil,
    metadata: nil,
    userdata: nil,
    # continuation properties:
    continuation_bridge: nil,
    continuation_stack: nil,
    continuation_conntracked: nil,
    continuation_mirrors: nil,
    continuation_table_id: nil,
    continuation_cookie: nil,
    continuation_actions: nil,
    continuation_action_set: nil
  )

  alias __MODULE__

  @encode_keys ~w(
    packet
    full_len
    buffer_id
    table_id
    cookie
    reason
    metadata
    userdata
  )a

  @continuation_keys ~w(
    continuation_bridge
    continuation_stack
    continuation_conntracked
    continuation_table_id
    continuation_cookie
    continuation_actions
    continuation_mirrors
    continuation_action_set
  )a

  @experimenter 0x00002320
  @nx_type 28

  @packet 0
  @full_len 1
  @buffer_id 2
  @table_id 3
  @cookie 4
  @reason 5
  @metadata 6
  @userdata 7
  @continuation 8

  @nxcpt_bridge 0x8000
  @nxcpt_stack 0x8001
  @nxcpt_mirrors 0x8002
  @nxcpt_conntracked 0x8003
  @nxcpt_table_id 0x8004
  @nxcpt_cookie 0x8005
  @nxcpt_actions 0x8006
  @nxcpt_action_set 0x8007

  @prop_header_length 4

  def ofp_type, do: 4

  def new(options \\ []) do
    packet_in = options[:packet_in] || %Openflow.NxPacketIn2{}
    packet = options[:packet] || packet_in.packet

    %NxResume{
      packet: packet,
      table_id: packet_in.table_id,
      cookie: packet_in.cookie,
      metadata: options[:metadata] || packet_in.metadata,
      userdata: packet_in.userdata,
      continuation_bridge: packet_in.continuation_bridge,
      continuation_stack: packet_in.continuation_stack,
      continuation_conntracked: packet_in.continuation_conntracked,
      continuation_table_id: packet_in.continuation_table_id,
      continuation_cookie: packet_in.continuation_cookie,
      continuation_actions: packet_in.continuation_actions,
      continuation_action_set: packet_in.continuation_action_set,
      continuation_mirrors: packet_in.continuation_mirrors
    }
  end

  def to_binary(%NxResume{} = pin) do
    props_bin = encode_props("", pin, @encode_keys)
    continuations_bin = encode_continuations("", pin, @continuation_keys)
    <<@experimenter::32, @nx_type::32, props_bin::bytes, continuations_bin::bytes>>
  end

  def read(<<@experimenter::32, @nx_type::32, props_bin::bytes>>) do
    %NxResume{}
    |> decode_props(props_bin)
  end

  ## private functions

  defp encode_props(acc, _pin, []), do: acc

  defp encode_props(acc, %NxResume{packet: packet} = pin, [:packet | rest])
       when not is_nil(packet) and is_binary(packet) do
    length = @prop_header_length + byte_size(packet)
    pad_length = Openflow.Utils.pad_length(length, 8)
    binary = <<@packet::16, length::16, packet::bytes, 0::size(pad_length)-unit(8)>>
    encode_props(<<acc::bytes, binary::bytes>>, pin, rest)
  end

  defp encode_props(acc, %NxResume{full_len: full_len} = pin, [:full_len | rest])
       when not is_nil(full_len) and is_integer(full_len) do
    length = @prop_header_length + 4
    binary = <<@full_len::16, length::16, full_len::32>>
    encode_props(<<acc::bytes, binary::bytes>>, pin, rest)
  end

  defp encode_props(acc, %NxResume{buffer_id: buffer_id} = pin, [:buffer_id | rest])
       when not is_nil(buffer_id) do
    length = @prop_header_length + 4
    buffer_id_int = Openflow.Utils.get_enum(buffer_id, :buffer_id)
    binary = <<@buffer_id::16, length::16, buffer_id_int::32>>
    encode_props(<<acc::bytes, binary::bytes>>, pin, rest)
  end

  defp encode_props(acc, %NxResume{table_id: table_id} = pin, [:table_id | rest])
       when not is_nil(table_id) and is_integer(table_id) do
    length = @prop_header_length + 4
    binary = <<@table_id::16, length::16, table_id::8, 0::24>>
    encode_props(<<acc::bytes, binary::bytes>>, pin, rest)
  end

  defp encode_props(acc, %NxResume{cookie: cookie} = pin, [:cookie | rest])
       when not is_nil(cookie) and is_integer(cookie) do
    length = @prop_header_length + 4 + 8
    pad_length = Openflow.Utils.pad_length(length, 8)
    binary = <<@cookie::16, length::16, 0::32, cookie::64, 0::size(pad_length)-unit(8)>>
    encode_props(<<acc::bytes, binary::bytes>>, pin, rest)
  end

  defp encode_props(acc, %NxResume{metadata: metadata} = pin, [:metadata | rest])
       when not is_nil(metadata) and is_list(metadata) do
    pad_match_bin =
      metadata
      |> Openflow.Match.new()
      |> Openflow.Match.to_binary()

    <<1::16, match_len_with_header::16, padded_match_bin::bytes>> = pad_match_bin
    match_len = match_len_with_header - 4
    <<match_bin::size(match_len)-bytes, _pad::bytes>> = padded_match_bin
    length = @prop_header_length + match_len
    pad_length = Openflow.Utils.pad_length(length, 8)
    binary = <<@metadata::16, length::16, match_bin::bytes, 0::size(pad_length)-unit(8)>>
    encode_props(<<acc::bytes, binary::bytes>>, pin, rest)
  end

  defp encode_props(acc, %NxResume{userdata: userdata} = pin, [:userdata | rest])
       when not is_nil(userdata) and is_binary(userdata) do
    length = @prop_header_length + byte_size(userdata)
    pad_length = Openflow.Utils.pad_length(length, 8)
    binary = <<@userdata::16, length::16, userdata::bytes, 0::size(pad_length)-unit(8)>>
    encode_props(<<acc::bytes, binary::bytes>>, pin, rest)
  end

  defp encode_props(acc, pin, [_ | rest]) do
    encode_props(acc, pin, rest)
  end

  defp encode_continuations(acc, _pin, []) do
    if byte_size(acc) > 0 do
      length = @prop_header_length + byte_size(acc) + 4
      pad_length = Openflow.Utils.pad_length(length, 8)
      <<@continuation::16, length::16, 0::32, acc::bytes, 0::size(pad_length)-unit(8)>>
    else
      <<>>
    end
  end

  defp encode_continuations(
         acc,
         %NxResume{continuation_bridge: br} = pin,
         [:continuation_bridge | rest]
       )
       when not is_nil(br) do
    length =  byte_size(br) + @prop_header_length
    pad_length = Openflow.Utils.pad_length(length, 8)
    br_bin = <<br::16-bytes, 0::size(pad_length)-unit(8)>>
    binary = <<@nxcpt_bridge::16, length::16, br_bin::bytes, acc::bytes>>
    encode_continuations(binary, pin, rest)
  end

  defp encode_continuations(
         acc,
         %NxResume{continuation_stack: stack} = pin,
         [:continuation_stack | rest]
       )
       when not is_nil(stack) do
    length = @prop_header_length + byte_size(stack)
    pad_length = Openflow.Utils.pad_length(length, 8)
    stack_bin = <<stack::bytes, 0::size(pad_length)-unit(8), acc::bytes>>
    binary = <<@nxcpt_stack::16, length::16, stack_bin::bytes, acc::bytes>>
    encode_continuations(binary, pin, rest)
  end

  defp encode_continuations(
         acc,
         %NxResume{continuation_mirrors: mirrors} = pin,
         [:continuation_mirrors | rest]
       )
       when not is_nil(mirrors) do
    length = @prop_header_length + byte_size(mirrors)
    pad_length = Openflow.Utils.pad_length(length, 8)
    mirrors_bin = <<mirrors::bytes, 0::size(pad_length)-unit(8), acc::bytes>>
    binary = <<@nxcpt_mirrors::16, length::16, mirrors_bin::bytes, acc::bytes>>

    encode_continuations(binary, pin, rest)
  end

  defp encode_continuations(
         acc,
         %NxResume{continuation_conntracked: true} = pin,
         [:continuation_conntracked | rest]
       ) do
    length = @prop_header_length + 1
    pad_length = Openflow.Utils.pad_length(length, 8)
    conntracked_bin = <<1::size(1)-unit(8), 0::size(pad_length)-unit(8), acc::bytes>>
    binary = <<@nxcpt_conntracked::16, length::16, conntracked_bin::bytes, acc::bytes>>

    encode_continuations(binary, pin, rest)
  end

  defp encode_continuations(
         acc,
         %NxResume{continuation_table_id: table_id} = pin,
         [:continuation_table_id | rest]
       )
       when not is_nil(table_id) do
    length = @prop_header_length + 1
    pad_length = Openflow.Utils.pad_length(length, 8)
    table_id_bin = <<table_id::8, 0::size(pad_length)-unit(8), acc::bytes>>
    binary = <<@nxcpt_table_id::16, length::16, table_id_bin::bytes, acc::bytes>>

    encode_continuations(binary, pin, rest)
  end

  defp encode_continuations(
         acc,
         %NxResume{continuation_cookie: cookie} = pin,
         [:continuation_cookie | rest]
       )
       when not is_nil(cookie) do
    length = @prop_header_length + 8
    pad_length = Openflow.Utils.pad_length(length, 8)
    cookie_bin = <<cookie::64, 0::size(pad_length)-unit(8), acc::bytes>>
    binary = <<@nxcpt_cookie::16, length::16, cookie_bin::bytes, acc::bytes>>

    encode_continuations(binary, pin, rest)
  end

  defp encode_continuations(
         acc,
         %NxResume{continuation_actions: actions} = pin,
         [:continuation_actions | rest]
       )
       when not is_nil(actions) do
    actions_bin = Openflow.Action.to_binary(actions)
    length = @prop_header_length + byte_size(actions_bin) + 4
    pad_length = Openflow.Utils.pad_length(length, 8)
    padded_actions_bin = <<0::32, actions_bin::bytes, 0::size(pad_length)-unit(8)>>
    binary = <<@nxcpt_actions::16, length::16, padded_actions_bin::bytes, acc::bytes>>
    encode_continuations(binary, pin, rest)
  end

  defp encode_continuations(
         acc,
         %NxResume{continuation_action_set: action_set} = pin,
         [:continuation_action_set | rest]
       )
       when not is_nil(action_set) do
    length = @prop_header_length + byte_size(action_set)
    pad_length = Openflow.Utils.pad_length(length, 8)
    action_set_bin = <<action_set::bytes, 0::size(pad_length)-unit(8), acc::bytes>>
    binary = <<@nxcpt_action_set::16, length::16, action_set_bin::bytes, acc::bytes>>
    encode_continuations(binary, pin, rest)
  end

  defp encode_continuations(acc, pin, [_ | rest]) do
    encode_continuations(acc, pin, rest)
  end

  defp decode_props(pktin, ""), do: pktin

  defp decode_props(pktin, <<@packet::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    packet_length = length - @prop_header_length
    <<packet::size(packet_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_props(%{pktin | packet: packet}, rest)
  end

  defp decode_props(pktin, <<@full_len::16, _length::16, full_len::32, rest::bytes>>) do
    decode_props(%{pktin | full_len: full_len}, rest)
  end

  defp decode_props(pktin, <<@buffer_id::16, _length::16, buffer_id::32, rest::bytes>>) do
    decode_props(%{pktin | buffer_id: buffer_id}, rest)
  end

  defp decode_props(pktin, <<@table_id::16, _length::16, table_id::8, _::24, rest::bytes>>) do
    decode_props(%{pktin | table_id: table_id}, rest)
  end

  defp decode_props(pktin, <<@cookie::16, _length::16, _::32, cookie::64, rest::bytes>>) do
    decode_props(%{pktin | cookie: cookie}, rest)
  end

  defp decode_props(pktin, <<@reason::16, _length::16, reason_int::8, _::24, rest::bytes>>) do
    reason = Openflow.Enums.to_atom(reason_int, :packet_in_reason)
    decode_props(%{pktin | reason: reason}, rest)
  end

  defp decode_props(pktin, <<@metadata::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    match_field_length = length - @prop_header_length

    <<match_fields_bin::size(match_field_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> =
      tail

    match_len = 4 + byte_size(match_fields_bin)
    padding = Openflow.Utils.pad_length(match_len, 8)
    match_bin = <<1::16, match_len::16, match_fields_bin::bytes, 0::size(padding)-unit(8)>>
    {fields, _rest} = Openflow.Match.read(match_bin)
    decode_props(%{pktin | metadata: fields}, rest)
  end

  defp decode_props(pktin, <<@userdata::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    userdata_length = length - @prop_header_length
    <<userdata::size(userdata_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_props(%{pktin | userdata: userdata}, rest)
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
    decode_continuations(%{pktin | continuation_bridge: bridge}, rest)
  end

  defp decode_continuations(pktin, <<@nxcpt_stack::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = (length - @prop_header_length) * 8
    <<stack::size(data_length), _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin | continuation_stack: pktin.continuation_stack ++ [stack]}, rest)
  end

  defp decode_continuations(pktin, <<@nxcpt_mirrors::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length
    <<mirrors::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin | continuation_mirrors: mirrors}, rest)
  end

  defp decode_continuations(pktin, <<@nxcpt_conntracked::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length
    <<_::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin | continuation_conntracked: true}, rest)
  end

  defp decode_continuations(pktin, <<@nxcpt_table_id::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    <<table_id::8, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin | continuation_table_id: table_id}, rest)
  end

  defp decode_continuations(pktin, <<@nxcpt_cookie::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    <<cookie::64, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin | continuation_cookie: cookie}, rest)
  end

  defp decode_continuations(pktin, <<@nxcpt_actions::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length - 4

    <<_pad::32, actions::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> =
      tail

    decode_continuations(%{pktin | continuation_actions: Openflow.Action.read(actions)}, rest)
  end

  defp decode_continuations(pktin, <<@nxcpt_action_set::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    data_length = length - @prop_header_length
    <<action_set::size(data_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_continuations(%{pktin | continuation_action_set: action_set}, rest)
  end

  defp decode_continuations(pktin, _) do
    decode_continuations(pktin, "")
  end
end
