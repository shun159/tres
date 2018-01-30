defmodule Openflow.Multipart.Request do
  def ofp_type, do: 18

  def read(<<type_int::16, flags_int::16, _::size(4)-unit(8), request_bin::bytes>>) do
    codec = Openflow.Enums.to_atom(type_int, :multipart_request_codec)
    flags = Openflow.Enums.int_to_flags(flags_int, :multipart_request_flags)
    request = codec.read(request_bin)
    %{request | flags: flags}
  end

  def to_binary(%{__struct__: codec, flags: flags} = msg) do
    flags_int = Openflow.Enums.flags_to_int(flags, :multipart_request_flags)
    type_int = Openflow.Enums.to_int(codec, :multipart_request_codec)

    case codec.to_binary(msg) do
      request_bin when is_binary(request_bin) ->
        <<type_int::16, flags_int::16, 0::size(4)-unit(8), request_bin::bytes>>

      {:error, reason} ->
        {:error, reason}
    end
  end

  def header(%{__struct__: codec, flags: flags}) do
    flags_int = Openflow.Enums.flags_to_int(flags, :multipart_request_flags)
    type_int = Openflow.Enums.to_int(codec, :multipart_request_codec)
    <<type_int::16, flags_int::16, 0::size(4)-unit(8)>>
  end
end
