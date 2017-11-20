defmodule Openflow.Match do
  @match_size  8
  @header_size 4

  defstruct([
    type:   :oxm,
    fields: []
  ])

  alias __MODULE__

  def new(fields \\ []) do
    oxm_fields =
      fields
      |> keyword_to_oxm_fields([])
    %Match{type: :oxm, fields: oxm_fields}
  end

  def read(binary) do
    <<1::16, no_pad_len::16, binary1::binary>> = binary
    padding_length = Openflow.Utils.pad_length(no_pad_len, 8)
    match_field_len = no_pad_len - @header_size
    <<match_fields::size(match_field_len)-binary, _::size(padding_length)-unit(8), rest::bitstring>> = binary1
    {decode_fields(match_fields, []), rest}
  end

  def to_binary(%Match{fields: fields}) do
    fields_bin = encode_fields(fields, <<>>)
    length = byte_size(fields_bin) + @match_size - @header_size
    type_int = Openflow.Enums.to_int(:oxm, :match_type)
    padding = Openflow.Utils.padding(length, 8)
    <<type_int::16, length::16, fields_bin::bytes, 0::size(padding)-unit(8)>>
  end

  def codec_header(oxm_field) when is_atom(oxm_field) do
    case Openflow.Match.Field.vendor_of(oxm_field) do
      oxm_class when oxm_class in [:nxm_0, :nxm_1, :openflow_basic, :packet_register] ->
        oxm_class_int = Openflow.Enums.to_int(oxm_class, :oxm_class)
        oxm_field_int = Openflow.Enums.to_int(oxm_field, oxm_class)
        oxm_length = div(Openflow.Match.Field.n_bits_of(oxm_field), 8)
        <<oxm_class_int::16, oxm_field_int::7, 0::1, oxm_length::8>>
      experimenter when experimenter in [:nicira_ext_match, :onf_ext_match] ->
        oxm_class_int = 0xffff
        experimenter_int = Openflow.Enums.to_int(experimenter, :experimenter_oxm_vendors)
        oxm_field_int = Openflow.Enums.to_int(oxm_field, experimenter)
        oxm_length = div(Openflow.Match.Field.n_bits_of(oxm_field) + 4, 8)
        <<oxm_class_int::16, oxm_field_int::7, 0::1, oxm_length::8, experimenter_int::32>>
    end
  end
  def codec_header(<<oxm_class_int::16, oxm_field_int::7, _oxm_has_mask::1, _oxm_length::8>>) do
    oxm_class = Openflow.Enums.to_atom(oxm_class_int, :oxm_class)
    Openflow.Enums.to_atom(oxm_field_int, oxm_class)
  end
  def codec_header(<<0xffff::16, oxm_field_int::7, _oxm_has_mask::1, _oxm_length::8, experimenter_int::32>>) do
    experimenter = Openflow.Enums.to_atom(experimenter_int, :experimenter_oxm_vendors)
    Openflow.Enums.to_atom(oxm_field_int, experimenter)
  end

  def header_size(<<_oxm_class_int::16, _oxm_field_int::7, _oxm_has_mask::1, _oxm_length::8, _::bytes>>),
    do: 4
  def header_size(<<0xffff::16, _oxm_field_int::7, _oxm_has_mask::1, _oxm_length::8, _exp_int::32, _::bytes>>),
    do: 8

  # private functions

  defp decode_fields(<<>>, acc), do: Enum.reverse(acc)
  defp decode_fields(<<0xffff::16, _::7, 1::1, length::8, vendor_int::32, field_int::16, binary::bytes>>, acc) do
    length = length - 6
    field_len = div(length, 2)
    <<value_bin::size(field_len)-bytes, mask_bin::size(field_len)-bytes, rest::bytes>> = binary
    experimenter = Openflow.Enums.to_atom(vendor_int, :experimenter_oxm_vendors)
    field_name = Openflow.Enums.to_atom(field_int, experimenter)
    value = Openflow.Match.Field.codec(value_bin, field_name)
    mask = Openflow.Match.Field.codec(mask_bin, field_name)
    decode_fields(rest, [{field_name, {value, mask}}|acc])
  end
  defp decode_fields(<<0xffff::16, _::7, 0::1, length::8, vendor_int::32, field_int::16, binary::bytes>>, acc) do
    length = length - 6
    <<value_bin::size(length)-bytes, rest::bytes>> = binary
    experimenter = Openflow.Enums.to_atom(vendor_int, :experimenter_oxm_vendors)
    field_name = Openflow.Enums.to_atom(field_int, experimenter)
    value = Openflow.Match.Field.codec(value_bin, field_name)
    decode_fields(rest, [{field_name, value}|acc])
  end
  defp decode_fields(<<class_int::16, field_int::7, 1::1, length::8, binary::bytes>>, acc) do
    field_len = div(length, 2)
    <<value_bin::size(field_len)-bytes, mask_bin::size(field_len)-bytes, rest::bytes>> = binary
    class = Openflow.Enums.to_atom(class_int, :oxm_class)
    field_name = Openflow.Enums.to_atom(field_int, class)
    value = Openflow.Match.Field.codec(value_bin, field_name)
    mask = Openflow.Match.Field.codec(mask_bin, field_name)
    decode_fields(rest, [{field_name, {value, mask}}|acc])
  end
  defp decode_fields(<<class_int::16, field_int::7, 0::1, length::8, binary::bytes>>, acc) do
    <<value_bin::size(length)-bytes, rest::bytes>> = binary
    class = Openflow.Enums.to_atom(class_int, :oxm_class)
    field_name = Openflow.Enums.to_atom(field_int, class)
    value = Openflow.Match.Field.codec(value_bin, field_name)
    decode_fields(rest, [{field_name, value}|acc])
  end

  defp encode_fields([], acc), do: acc
  defp encode_fields([field|fields], acc) do
    encode_fields(fields, <<acc::bytes, (encode_field(field))::bytes>>)
  end

  defp encode_field(%{class: class, field: field, has_mask: true, value: value, mask: mask})
  when class == :nicira_ext_match or class == :onf_ext_match do
    vendor_int = Openflow.Enums.to_int(class, :experimenter_oxm_vendors)
    field_int = Openflow.Enums.to_int(field, class)
    has_mask_int = 1
    length = (byte_size(value) * 2) + 6
    <<0xffff::16, 0::7, has_mask_int::1, length::8, vendor_int::32, field_int::16, value::bytes, mask::bytes>>
  end
  defp encode_field(%{class: class, field: field, has_mask: false, value: value})
  when class == :nicira_ext_match or class == :onf_ext_match do
    vendor_int = Openflow.Enums.to_int(class, :experimenter_oxm_vendors)
    field_int = Openflow.Enums.to_int(field, class)
    has_mask_int = 0
    length = byte_size(value) + 6
    <<0xffff::16, 0::7, has_mask_int::1, length::8, vendor_int::32, field_int::16, value::bytes>>
  end
  defp encode_field(%{class: class, field: field, has_mask: true, value: value, mask: mask}) do
    class_int = Openflow.Enums.to_int(class, :oxm_class)
    field_int = Openflow.Enums.to_int(field, class)
    has_mask_int = 1
    length = byte_size(value) * 2
    <<class_int::16, field_int::7, has_mask_int::1, length::8, value::bytes, mask::bytes>>
  end
  defp encode_field(%{class: class, field: field, has_mask: false, value: value}) do
    class_int = Openflow.Enums.to_int(class, :oxm_class)
    field_int = Openflow.Enums.to_int(field, class)
    has_mask_int = 0
    length = byte_size(value)
    <<class_int::16, field_int::7, has_mask_int::1, length::8, value::bytes>>
  end

  defp keyword_to_oxm_fields([], acc), do: Enum.reverse(acc)
  defp keyword_to_oxm_fields([{field_name, field_value}|fields], acc) do
    keyword_to_oxm_fields(fields, [oxm_field(field_name, field_value)|acc])
  end

  defp oxm_field(field_name, {value, mask}) do
    value_bin = Openflow.Match.Field.codec(value, field_name)
    mask_bin = Openflow.Match.Field.codec(mask, field_name)
    match_class = Openflow.Match.Field.vendor_of(field_name)
    %{class: match_class, field: field_name, has_mask: true, value: value_bin, mask: mask_bin}
  end
  defp oxm_field(field_name, value) do
    value_bin = Openflow.Match.Field.codec(value, field_name)
    match_class = Openflow.Match.Field.vendor_of(field_name)
    %{class: match_class, field: field_name, has_mask: false, value: value_bin}
  end
end
