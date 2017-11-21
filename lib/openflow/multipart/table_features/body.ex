defmodule Openflow.Multipart.TableFeatures.Body do
  defstruct [
    table_id:              0,
    name:                 "",
    metadata_match:        0,
    metadata_write:        0,
    config:               [],
    max_entries:           0,
    instructions:        nil,
    instructions_miss:   nil,
    next_tables:         nil,
    next_tables_miss:    nil,
    write_actions:       nil,
    write_actions_miss:  nil,
    apply_actions:       nil,
    apply_actions_miss:  nil,
    match:               nil,
    wildcards:           nil,
    write_setfield:      nil,
    write_setfield_miss: nil,
    apply_setfield:      nil,
    apply_setfield_miss: nil
  ]

  alias __MODULE__

  @max_table_name_len    32
  @prop_header_length     4
  @table_features_length 64

  @instructions         0
  @instructions_miss    1
  @next_tables          2
  @next_tables_miss     3
  @write_actions        4
  @write_actions_miss   5
  @apply_actions        6
  @apply_actions_miss   7
  @match                8
  @wildcards           10
  @write_setfield      12
  @write_setfield_miss 13
  @apply_setfield      14
  @apply_setfield_miss 15

  @prop_keys [
    :instructions,
    :instructions_miss,
    :next_tables,
    :next_tables_miss,
    :write_actions,
    :write_actions_miss,
    :apply_actions,
    :apply_actions_miss,
    :match,
    :wildcards,
    :write_setfield,
    :write_setfield_miss,
    :apply_setfield,
    :apply_setfield_miss
  ]

  def new(options) do
    %Body{
      table_id:            options[:table_id]       || 0,
      name:                options[:name]           || "",
      metadata_match:      options[:metadata_match] || 0,
      metadata_write:      options[:metadata_write] || 0,
      config:              options[:config]         || [],
      max_entries:         options[:max_entries]    || 0,
      instructions:        options[:instructions],
      instructions_miss:   options[:instructions_miss],
      next_tables:         options[:next_tables],
      next_tables_miss:    options[:next_tables_miss],
      write_actions:       options[:write_actions],
      write_actions_miss:  options[:write_actions_miss],
      apply_actions:       options[:apply_actions],
      apply_actions_miss:  options[:apply_actions_miss],
      match:               options[:match],
      wildcards:           options[:wildcards],
      write_setfield:      options[:write_setfield],
      write_setfield_miss: options[:write_setfield_miss],
      apply_setfield:      options[:apply_setfield],
      apply_setfield_miss: options[:apply_setfield_miss]
    }
  end

  def read(binary) do
    do_read([], binary)
  end

  def to_binary(features) do
    do_to_binary("", features)
  end

  # private functions

  defp do_to_binary(acc, []), do: acc
  defp do_to_binary(acc, [table|rest]) do
    do_to_binary(<<acc::bytes, (encode(table))::bytes>>, rest)
  end

  defp do_read(acc, ""), do: Enum.reverse(acc)
  defp do_read(acc, <<length::16, _::bytes>> = binary) do
    <<features_bin::size(length)-bytes, rest::bytes>> = binary
    do_read([decode(features_bin)|acc], rest)
  end

  defp decode(<<_length::16, table_id::8, _::size(5)-unit(8),
                name_bin::size(@max_table_name_len)-bytes,
                metadata_match::64, metadata_write::64,
                config_int::32, max_entries::32, props_bin::bytes>>) do
    name = Openflow.Utils.decode_string(name_bin)
    config = Openflow.Enums.int_to_flags(config_int, :table_config)
    body = %Body{table_id:             table_id,
                 name:                     name,
                 metadata_match: metadata_match,
                 metadata_write: metadata_write,
                 config:                 config,
                 max_entries:       max_entries}
    decode_props(body, props_bin)
  end

  defp encode(table) do
    filter_fn = fn(key) -> not is_nil(Map.get(table, key)) end
    keys = Enum.filter(@prop_keys, filter_fn)
    props_bin = encode_props("", table, keys)
    length = @table_features_length + byte_size(props_bin)
    %Body{table_id:             table_id,
          name:                     name,
          metadata_match: metadata_match,
          metadata_write: metadata_write,
          config:                 config,
          max_entries:       max_entries} = table
    config_int = Openflow.Enums.flags_to_int(config, :table_config)
    name_bin = Openflow.Utils.encode_string(name, @max_table_name_len)
    <<length::16, table_id::8, 0::size(5)-unit(8),
      name_bin::bytes, metadata_match::64, metadata_write::64,
      config_int::32, max_entries::32, props_bin::bytes>>
  end

  defp decode_props(body, ""), do: body
  defp decode_props(body, <<type_int::16, length::16, tail::bytes>>)
  when type_int == @instructions or type_int == @instructions_miss do
    pad_length = Openflow.Utils.pad_length(length, 8)
    value_length = length - @prop_header_length
    <<instructions_bin::size(value_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    instructions = decode_instructions([], instructions_bin)
    type = Openflow.Enums.to_atom(type_int, :table_feature_prop_type)
    body
    |> struct(%{type => instructions})
    |> decode_props(rest)
  end
  defp decode_props(body, <<type_int::16, length::16, tail::bytes>>)
  when type_int == @next_tables or type_int == @next_tables_miss do
    pad_length = Openflow.Utils.pad_length(length, 8)
    value_length = length - @prop_header_length
    <<next_tables_bin::size(value_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    next_tables = for <<table_id::8 <- next_tables_bin>>, do: table_id
    type = Openflow.Enums.to_atom(type_int, :table_feature_prop_type)
    body
    |> struct(%{type => next_tables})
    |> decode_props(rest)
  end
  defp decode_props(body, <<type_int::16, length::16, tail::bytes>>)
  when type_int == @write_actions or
       type_int == @write_actions_miss or
       type_int == @apply_actions or
       type_int == @apply_actions_miss do
    pad_length = Openflow.Utils.pad_length(length, 8)
    value_length = length - @prop_header_length
    <<actions_bin::size(value_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    actions = decode_actions([], actions_bin)
    type = Openflow.Enums.to_atom(type_int, :table_feature_prop_type)
    body
    |> struct(%{type => actions})
    |> decode_props(rest)
  end
  defp decode_props(body, <<type_int::16, length::16, tail::bytes>>)
  when type_int == @match or
       type_int == @wildcards or
       type_int == @write_setfield or
       type_int == @write_setfield_miss or
       type_int == @apply_setfield or
       type_int == @apply_setfield_miss do
    pad_length = Openflow.Utils.pad_length(length, 8)
    value_length = length - @prop_header_length
    <<matches_bin::size(value_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    matches = decode_matches([], matches_bin)
    type = Openflow.Enums.to_atom(type_int, :table_feature_prop_type)
    body
    |> struct(%{type => matches})
    |> decode_props(rest)
  end
  defp decode_props(body, <<_type_int::16, length::16, tail::bytes>>) do
    pad_length = Openflow.Utils.pad_length(length, 8)
    value_length = length - @prop_header_length
    <<_::size(value_length)-bytes, _::size(pad_length)-unit(8), rest::bytes>> = tail
    decode_props(body, rest)
  end

  defp encode_props(acc, _table, []), do: acc
  defp encode_props(acc, table, [type|rest])
  when type == :instructions or type == :instructions_miss do
    type_int = Openflow.Enums.to_int(type, :table_feature_prop_type)
    instructions_bin = encode_instructions("", Map.get(table, type))
    length = @prop_header_length + byte_size(instructions_bin)
    pad_length = Openflow.Utils.pad_length(length, 8)
    body = <<instructions_bin::bytes, 0::size(pad_length)-unit(8)>>
    encode_props(<<acc::bytes, type_int::16, length::16, body::bytes>>, table, rest)
  end
  defp encode_props(acc, table, [type|rest])
  when type == :next_tables or type == :next_tables_miss do
    type_int = Openflow.Enums.to_int(type, :table_feature_prop_type)
    next_tables_bin = to_string(Map.get(table, type))
    length = @prop_header_length + byte_size(next_tables_bin)
    pad_length = Openflow.Utils.pad_length(length, 8)
    body = <<next_tables_bin::bytes, 0::size(pad_length)-unit(8)>>
    encode_props(<<acc::bytes, type_int::16, length::16, body::bytes>>, table, rest)
  end
  defp encode_props(acc, table, [type|rest])
  when (type == :write_actions or
        type == :write_actions_miss or
        type == :apply_actions or
        type == :apply_actions_miss) do
    type_int = Openflow.Enums.to_int(type, :table_feature_prop_type)
    actions_bin = encode_actions("", Map.get(table, type))
    length = @prop_header_length + byte_size(actions_bin)
    pad_length = Openflow.Utils.pad_length(length, 8)
    body = <<actions_bin::bytes, 0::size(pad_length)-unit(8)>>
    encode_props(<<acc::bytes, type_int::16, length::16, body::bytes>>, table, rest)
  end
  defp encode_props(acc, table, [type|rest])
  when (type == :match or
        type == :wildcards or
        type == :write_setfield or
        type == :write_setfield_miss or
        type == :apply_setfield or
        type == :apply_setfield_miss) do
    type_int = Openflow.Enums.to_int(type, :table_feature_prop_type)
    matches_bin = encode_matches("", Map.get(table, type))
    length = @prop_header_length + byte_size(matches_bin)
    pad_length = Openflow.Utils.pad_length(length, 8)
    body = <<matches_bin::bytes, 0::size(pad_length)-unit(8)>>
    encode_props(<<acc::bytes, type_int::16, length::16, body::bytes>>, table, rest)
  end

  defp decode_instructions(acc, ""), do: Enum.reverse(acc)
  defp decode_instructions(acc, <<0xffff::16, _::16, exp_id::32, rest::bytes>>) do
    decode_instructions([Openflow.Instruction.Experimenter.new(exp_id)|acc], rest)
  end
  defp decode_instructions(acc, <<type_int::16, _::16, rest::bytes>>) do
    instruction = Openflow.Enums.to_atom(type_int, :instruction_type)
    decode_instructions([instruction|acc], rest)
  end

  defp encode_instructions(acc, []), do: acc
  defp encode_instructions(acc, [%Openflow.Instruction.Experimenter{exp_id: exp_id}|rest]) do
    encode_instructions(<<acc::bytes, 0xffff::16, 8::16, exp_id::32>>, rest)
  end
  defp encode_instructions(acc, [type|rest]) do
    type_int = Openflow.Enums.to_int(type, :instruction_type)
    encode_instructions(<<acc::bytes, type_int::16, 4::16>>, rest)
  end

  defp decode_actions(acc, ""), do: Enum.reverse(acc)
  defp decode_actions(acc, <<0xffff::16, _::16, exp_id::32, rest::bytes>>) do
    decode_actions([Openflow.Action.Experimenter.new(exp_id)|acc], rest)
  end
  defp decode_actions(acc, <<type_int::16, _::16, rest::bytes>>) do
    action = Openflow.Enums.to_atom(type_int, :action_type)
    decode_actions([action|acc], rest)
  end

  defp encode_actions(acc, []), do: acc
  defp encode_actions(acc, [%Openflow.Action.Experimenter{exp_id: exp_id}|rest]) do
    encode_actions(<<acc::bytes, 0xffff::16, 8::16, exp_id::32>>, rest)
  end
  defp encode_actions(acc, [type|rest]) do
    type_int = Openflow.Enums.to_int(type, :action_type)
    encode_actions(<<acc::bytes, type_int::16, 4::16>>, rest)
  end

  defp decode_matches(acc, ""), do: Enum.reverse(acc)
  defp decode_matches(acc, binary) do
    length = Openflow.Match.header_size(binary)
    <<header_bin::size(length)-bytes, rest::bytes>> = binary
    field = Openflow.Match.codec_header(header_bin)
    decode_matches([field|acc], rest)
  end

  defp encode_matches(acc, []), do: acc
  defp encode_matches(acc, [field|rest]) do
    header_bin = Openflow.Match.codec_header(field)
    encode_matches(<<acc::bytes, header_bin::bytes>>, rest)
  end
end
