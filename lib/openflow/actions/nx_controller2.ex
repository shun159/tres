defmodule Openflow.Action.NxController2 do
  defstruct(
    max_len: :no_buffer,
    id: 0,
    reason: :action,
    userdata: "",
    pause: false,
    meter_id: 0
  )

  @experimenter 0x00002320
  @nxast 37

  @prop_header_size 4

  @prop_max_len 0
  @prop_ctl_id 1
  @prop_reason 2
  @prop_userdata 3
  @prop_pause 4
  @prop_meter_id 5

  @nx_ctlr_no_meter 0

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ []) do
    %NxController2{
      max_len: options[:max_len] || :no_buffer,
      id: options[:id] || 0,
      reason: options[:reason] || :action,
      userdata: options[:userdata],
      pause: options[:pause] || false,
      meter_id: options[:meter_id] || @nx_ctlr_no_meter
    }
  end

  def to_binary(%NxController2{} = ctl) do
    props_bin = encode_props(ctl)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      0::size(6)-unit(8),
      props_bin::bytes
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, 0::size(6)-unit(8), body::bytes>>) do
    %NxController2{}
    |> decode_prop(body)
  end

  # private functions

  defp encode_props(ctl) do
    ctl
    |> Map.from_struct()
    |> Enum.reduce(<<>>, &encode_prop/2)
  end

  defp encode_prop({:max_len, value}, acc)
       when value != :no_buffer or value < 0xFFFF do
    pad_length = 2
    prop_length = @prop_header_size + 2 + pad_length
    max_len_int = Openflow.Utils.get_enum(value, :controller_max_len)

    <<
      acc::bytes,
      @prop_max_len::16,
      prop_length::16,
      max_len_int::16,
      0::size(pad_length)-unit(8)
    >>
  end

  defp encode_prop({:id, value}, acc) do
    pad_length = 2
    prop_length = @prop_header_size + 2 + pad_length

    <<
      acc::bytes,
      @prop_ctl_id::16,
      prop_length::16,
      value::16,
      0::size(pad_length)-unit(8)
    >>
  end

  defp encode_prop({:reason, reason}, acc)
       when reason != :action do
    padding_length = 3
    prop_length = @prop_header_size + 1 + padding_length
    reason_int = Openflow.Utils.get_enum(reason, :packet_in_reason)

    <<
      acc::bytes,
      @prop_reason::16,
      prop_length::16,
      reason_int::8,
      0::size(padding_length)-unit(8)
    >>
  end

  defp encode_prop({:userdata, value}, acc)
       when byte_size(value) > 0 do
    prop_length = @prop_header_size + byte_size(value)
    padding_length = Openflow.Utils.padding(prop_length, 8)

    <<
      acc::bytes,
      @prop_userdata::16,
      prop_length::16,
      value::bytes,
      0::size(padding_length)-unit(8)
    >>
  end

  defp encode_prop({:pause, true}, acc) do
    padding_length = 4
    prop_length = @prop_header_size + padding_length

    <<
      acc::bytes,
      @prop_pause::16,
      prop_length::16,
      0::size(padding_length)-unit(8)
    >>
  end

  defp encode_prop({:meter_id, value}, acc)
       when value != @nx_ctlr_no_meter do
    prop_length = @prop_header_size + 4

    <<
      acc::bytes,
      @prop_meter_id::16,
      prop_length::16,
      value::32
    >>
  end

  defp encode_prop(_, acc) do
    acc
  end

  defp decode_prop(ctl, ""), do: ctl

  defp decode_prop(
         ctl,
         <<
           @prop_max_len::16,
           _prop_length::16,
           max_len_int::16,
           _::size(2)-unit(8),
           rest::bytes
         >>
       ) do
    max_len = Openflow.Utils.get_enum(max_len_int, :controller_max_len)
    decode_prop(%{ctl | max_len: max_len}, rest)
  end

  defp decode_prop(
         ctl,
         <<@prop_reason::16, _prop_length::16, reason_int::8, _::size(3)-unit(8), rest::bytes>>
       ) do
    reason = Openflow.Utils.get_enum(reason_int, :packet_in_reason)
    decode_prop(%{ctl | reason: reason}, rest)
  end

  defp decode_prop(
         ctl,
         <<@prop_ctl_id::16, _prop_length::16, controller_id::16, _::size(2)-unit(8),
           rest::bytes>>
       ) do
    decode_prop(%{ctl | id: controller_id}, rest)
  end

  defp decode_prop(
         ctl,
         <<@prop_userdata::16, prop_length::16, remains::bytes>>
       ) do
    userdata_len = prop_length - 4
    padding_length = Openflow.Utils.padding(prop_length, 8)
    <<userdata::size(userdata_len)-bytes, _::size(padding_length)-unit(8), rest::bytes>> = remains
    decode_prop(%{ctl | userdata: userdata}, rest)
  end

  defp decode_prop(ctl, <<@prop_pause::16, _::16, 0::size(4)-unit(8), rest::bytes>>) do
    decode_prop(%{ctl | pause: true}, rest)
  end

  defp decode_prop(ctl, <<@prop_meter_id::16, _::16, meter_id::32, rest::bytes>>) do
    decode_prop(%{ctl | meter_id: meter_id}, rest)
  end
end
