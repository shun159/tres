defmodule Openflow do
  @moduledoc "OpenFlow Protocol format codec"

  @ofp_header_size 8

  @spec read(binary()) :: {:ok, map()} | {:error, :binary_too_small}
  def read(binary)
      when byte_size(binary) < @ofp_header_size do
    {:error, :binary_too_small}
  end

  def read(<<_v::8, _t::8, len::16, _x::32, _r::bytes>> = binary)
      when byte_size(binary) < len do
    {:error, :binary_too_small}
  end

  def read(<<ver::8, type::8, len::16, xid::32, binary2::bytes>>) do
    try do
      body_len = len - @ofp_header_size
      <<body_bin::bytes-size(body_len), rest::bytes>> = binary2

      result =
        type
        |> Openflow.Enums.to_atom(:openflow_codec)
        |> do_read(body_bin)

      case result do
        {:ok, struct} -> {:ok, %{struct | version: ver, xid: xid}, rest}
        {:error, reason} -> {:error, reason}
      end
    catch
      _c, reason ->
        {:error, {:malformed_packet, {reason, __STACKTRACE__}}}
    end
  end

  def to_binary(messages) when is_list(messages) do
    binaries = for message <- messages, do: to_binary(message)
    Enum.join(binaries, "")
  end

  def to_binary(%{__struct__: encoder, version: version, xid: xid} = msg) do
    case encoder.to_binary(msg) do
      body_bin when is_binary(body_bin) ->
        length = @ofp_header_size + byte_size(body_bin)
        <<version::8, encoder.ofp_type::8, length::16, xid::32, body_bin::bytes>>

      {:error, reason} ->
        {:error, reason}
    end
  end

  def append_body(nil, message), do: message

  def append_body(message, continue) do
    mod = message.__struct__

    if function_exported?(mod, :append_body, 2) do
      mod.append_body(message, continue)
    else
      message
    end
  end

  # private functions

  defp do_read({:error, reason}, _) do
    {:error, reason}
  end

  defp do_read(decoder, body_bin) do
    case decoder.read(body_bin) do
      {:error, reason} -> {:error, reason}
      result when is_map(result) -> {:ok, result}
    end
  end
end
