defmodule Openflow.Multipart.Reply do
  def ofp_type, do: 19

  def read(<<type_int::16, flags_int::16, _::size(4)-unit(8), reply_bin::bytes>>) do
    codec = Openflow.Enums.to_atom(type_int, :multipart_reply_codec)
    flags = Openflow.Enums.int_to_flags(flags_int, :multipart_reply_flags)
    reply = codec.read(reply_bin)
    %{reply | flags: flags}
  end

  def to_binary(%{__struct__: codec, flags: flags} = msg) do
    flags_int = Openflow.Enums.flags_to_int(flags, :multipart_reply_flags)
    type_int = Openflow.Enums.to_int(codec, :multipart_reply_codec)

    case codec.to_binary(msg) do
      reply_bin when is_binary(reply_bin) ->
        <<type_int::16, flags_int::16, 0::size(4)-unit(8), reply_bin::bytes>>

      {:error, reason} ->
        {:error, reason}
    end
  end

  def header(%{__struct__: codec, flags: flags}) do
    flags_int = Openflow.Enums.flags_to_int(flags, :multipart_reply_flags)
    type_int = Openflow.Enums.to_int(codec, :multipart_reply_codec)
    <<type_int::16, flags_int::16, 0::size(4)-unit(8)>>
  end
end
