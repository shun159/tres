defmodule Tres.IPv4Address do
  @moduledoc """
  IP Address Utils
  """

  use Bitwise

  @typep in_addr :: {byte, byte, byte, byte}
  @typep in_addr_str :: String.t()

  @doc """
      iex> {{192, 168, 0, 1}, {255, 255, 255, 255}} = IPv4Address.parse("192.168.0.1")
      iex> {{192, 168, 0, 1}, {255, 255, 255, 0}} = IPv4Address.parse("192.168.0.1/24")
  """
  @spec parse(in_addr_str) :: {in_addr, in_addr}
  def parse(addr) do
    case String.split(addr, ~r/\//) do
      [^addr] ->
        {:ok, ipaddr} = addr |> to_charlist |> :inet.parse_address()
        {ipaddr, {255, 255, 255, 255}}
      [netaddr, cidr_str] ->
        cidr = String.to_integer(cidr_str)
        mask = (0xFFFFFFFF >>> (32 - cidr)) <<< (32 - cidr)
        <<m1, m2, m3, m4>> = <<mask::32>>
        {:ok, ipaddr} = netaddr |> to_charlist |> :inet.parse_address()
        {ipaddr, {m1, m2, m3, m4}}
    end
  end

  @doc """
      iex> "192.168.0.1" = IPv4Address.to_str({192, 168, 0, 1})
  """
  @spec to_str(in_addr | in_addr_str) :: in_addr_str
  def to_str(addr) when is_binary(addr) do
    addr
  end

  def to_str(addr) when is_tuple(addr) do
    "#{:inet.ntoa(addr)}"
  end

  @doc """
      iex> 0xc0a80001 = IPv4Address.to_int({192, 168, 0, 1})
  """
  @spec to_int(in_addr) :: 0..0xFFFFFFFF
  def to_int({a, b, c, d}) do
    <<a, b, c, d>> |> :binary.decode_unsigned(:big)
  end

  @doc """
      iex> true = IPv4Address.is_private?({192, 168, 0, 1})
  """
  @spec is_private?(in_addr) :: boolean
  def is_private?(addr) do
    ipaddr_int = to_int(addr)
    priv_class_a?(ipaddr_int) or priv_class_b?(ipaddr_int) or priv_class_c?(ipaddr_int)
  end

  @doc """
      iex> false = IPv4Address.is_loopback?({192, 168, 0, 1})
      iex> true = IPv4Address.is_loopback?({127, 0, 0, 1})
  """
  @spec is_loopback?(in_addr) :: boolean
  def is_loopback?({127, _, _, _}), do: true
  def is_loopback?({_, _, _, _}), do: false

  @doc """
      iex> false = IPv4Address.is_multicast?({192, 168, 0, 1})
      iex> true = IPv4Address.is_multicast?({224, 0, 0, 1})
  """
  @spec is_multicast?(in_addr) :: boolean
  def is_multicast?(in_addr) do
    in_addr
    |> to_int
    |> mcast_class_d?
  end

  @doc """
      iex> false = IPv4Address.is_broadcast?({192, 168, 0, 1})
      iex> true = IPv4Address.is_broadcast?({255, 255, 255, 255})
  """
  @spec is_broadcast?(in_addr) :: boolean
  def is_broadcast?({255, _, _, _}), do: true
  def is_broadcast?({_, _, _, _}), do: false

  # private functions

  @class_a_subnet 0xFF000000
  @class_b_subnet 0xFFF00000
  @class_c_subnet 0xFFFF0000
  @class_d_subnet 0xE0000000

  @class_a_start_addr 167_772_160
  @class_b_start_addr 2_886_729_728
  @class_c_start_addr 3_232_235_520

  defp priv_class_a?(ipaddr_int), do: (ipaddr_int &&& @class_a_subnet) == @class_a_start_addr

  defp priv_class_b?(ipaddr_int), do: (ipaddr_int &&& @class_b_subnet) == @class_b_start_addr

  defp priv_class_c?(ipaddr_int), do: (ipaddr_int &&& @class_c_subnet) == @class_c_start_addr

  defp mcast_class_d?(ipaddr_int), do: (ipaddr_int &&& @class_d_subnet) == @class_d_subnet
end
