defmodule Openflow.Action.NxController2 do
  defstruct(
    max_len: :no_buffer,
    id: 0,
    reason: :action,
    userdata: "",
    pause: false
  )

  @experimenter 0x00002320
  @nxast 37

  @prop_header_size 4

  @prop_max_len 0
  @prop_ctl_id 1
  @prop_reason 2
  @prop_userdata 3
  @prop_pause 4

  alias __MODULE__

  def new(options) do
    %NxController2{
      max_len: options[:max_len] || :no_buffer,
      id: options[:id] || 0,
      reason: options[:reason] || :action,
      userdata: options[:userdata],
      pause: options[:pause] || false
    }
  end

  def to_binary(%NxController2{} = ctl) do
    ext_header = <<@experimenter::32, @nxast::16, 0::size(6)-unit(8)>>
    prop_keys = get_prop_key(ctl)
    props_bin = encode_prop("", prop_keys, ctl)
    exp_body = <<ext_header::bytes, props_bin::bytes>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes>>
  end

  def read(<<@experimenter::32, @nxast::16, 0::size(6)-unit(8), body::bytes>>) do
    %NxController2{}
    |> decode_prop(body)
  end

  # private functions

  defp get_prop_key(ctl) do
    ctl
    |> Map.from_struct()
    |> Enum.map(fn {k, v} -> if(not is_nil(v), do: k, else: nil) end)
    |> Enum.filter(fn v -> not is_nil(v) end)
  end

  defp encode_prop(acc, [], _ctl), do: acc

  defp encode_prop(acc, [prop | rest], ctl) do
    value = Map.get(ctl, prop)

    prop_bin =
      cond do
        prop == :max_len and (value != :no_buffer or value < 0xFFFF) ->
          padding_length = 2
          prop_length = @prop_header_size + 2 + padding_length
          max_len_int = Openflow.Utils.get_enum(value, :controller_max_len)
          <<@prop_max_len::16, prop_length::16, max_len_int::16, 0::size(padding_length)-unit(8)>>

        prop == :id ->
          padding_length = 2
          prop_length = @prop_header_size + 2 + padding_length
          <<@prop_ctl_id::16, prop_length::16, value::16, 0::size(padding_length)-unit(8)>>

        prop == :reason and value != :action ->
          padding_length = 3
          prop_length = @prop_header_size + 1 + padding_length
          reason_int = Openflow.Utils.get_enum(value, :packet_in_reason)
          <<@prop_reason::16, prop_length::16, reason_int::8, 0::size(padding_length)-unit(8)>>

        prop == :userdata and byte_size(value) > 0 ->
          prop_length = @prop_header_size + byte_size(value)
          padding_length = Openflow.Utils.padding(prop_length, 8)
          <<@prop_userdata::16, prop_length::16, value::bytes, 0::size(padding_length)-unit(8)>>

        prop == :pause and value == true ->
          padding_length = 4
          prop_length = @prop_header_size + padding_length
          <<@prop_pause::16, prop_length::16, 0::size(padding_length)-unit(8)>>

        true ->
          ""
      end

    encode_prop(<<acc::bytes, prop_bin::bytes>>, rest, ctl)
  end

  defp decode_prop(ctl, ""), do: ctl

  defp decode_prop(ctl, <<prop_type_int::16, _::bytes>> = bin) do
    prop_type = Openflow.Enums.to_atom(prop_type_int, :nx_action_controller2_prop_type)

    case prop_type do
      :max_len ->
        <<@prop_max_len::16, _prop_length::16, max_len_int::16, _::size(2)-unit(8), rest::bytes>> =
          bin

        max_len = Openflow.Utils.get_enum(max_len_int, :controller_max_len)
        decode_prop(struct(ctl, %{max_len: max_len}), rest)

      :controller_id ->
        <<@prop_ctl_id::16, _prop_length::16, controller_id::16, _::size(2)-unit(8), rest::bytes>> =
          bin

        decode_prop(struct(ctl, %{controller_id: controller_id}), rest)

      :reason ->
        <<@prop_reason::16, _prop_length::16, reason_int::8, _::size(3)-unit(8), rest::bytes>> =
          bin

        reason = Openflow.Utils.get_enum(reason_int, :packet_in_reason)
        decode_prop(struct(ctl, %{reason: reason}), rest)

      :userdata ->
        <<@prop_userdata::16, prop_length::16, remains::bytes>> = bin
        userdata_len = prop_length - 4
        padding_length = Openflow.Utils.padding(prop_length, 8)

        <<userdata::size(userdata_len)-bytes, _::size(padding_length)-unit(8), rest::bytes>> =
          remains

        decode_prop(struct(ctl, %{userdata: userdata}), rest)

      :pause ->
        <<@prop_pause::16, _::16, 0::size(4)-unit(8), rest::bytes>> = bin
        decode_prop(struct(ctl, %{pause: true}), rest)
    end
  end
end
