defmodule SimpleRouter.MacAddress do
  @moduledoc """
  MAC Address Utils
  """

  use Bitwise

  @mac_addr_pattern ~r/^(?:[0-9a-fA-F][0-9a-fA-F]){6}$/

  @spec bin_to_str(<<_::48>>) :: String.t()
  def bin_to_str(<<_::6-bytes>> = mac) do
    mac
    |> :erlang.binary_to_list()
    |> Enum.reduce("", &to_hex/2)
    |> String.downcase()
  end

  @spec to_a(String.t()) :: [non_neg_integer()]
  def to_a(mac) do
    mac
    |> check_format()
    |> to_a([])
  rescue
    _e in ArgumentError ->
      {:error, :invalid_format}
  end

  @spec to_i(String.t()) :: non_neg_integer()
  def to_i(mac) do
    mac
    |> check_format()
    |> String.to_integer(16)
  rescue
    _e in ArgumentError ->
      {:error, :invalid_format}
  end

  @spec is_broadcast?(String.t()) :: boolean()
  def is_broadcast?(mac) do
    mac
    |> check_format()
    |> to_a()
    |> Enum.at(0)
    |> Kernel.==(0xFF)
  rescue
    _e in ArgumentError ->
      {:error, :invalid_format}
  end

  @spec is_multicast?(String.t()) :: boolean()
  def is_multicast?(mac) do
    mac
    |> check_format()
    |> to_a()
    |> Enum.at(0)
    |> Bitwise.&&&(1)
    |> Kernel.==(1)
  rescue
    _e in ArgumentError ->
      {:error, :invalid_format}
  end

  # private functions

  defp to_a(<<>>, acc), do: Enum.reverse(acc)

  defp to_a(<<octet::2-bytes, rest::bytes>>, acc) do
    to_a(rest, [String.to_integer(octet, 16) | acc])
  end

  @spec to_hex(0..0xFF, String.t()) :: String.t()
  defp to_hex(int, acc), do: "#{acc}#{to_hex(int)}"

  @spec to_hex(0..0xFF) :: String.t()
  defp to_hex(int) do
    int
    |> Integer.to_string(16)
    |> String.pad_leading(2, "0")
  end

  @spec check_format(String.t()) :: String.t() | none()
  defp check_format(mac) when is_binary(mac) do
    if String.match?(mac, @mac_addr_pattern),
      do: mac,
      else: raise(ArgumentError, message: "MAC address should be 12 letters hex string format")
  end
end
