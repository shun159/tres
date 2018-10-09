defmodule SimpleRouter.Config do
  @moduledoc false

  alias Tres.IPv4Address

  @spec interfaces() :: %{String.t() => map()}
  def interfaces do
    :interfaces
    |> get_env(%{})
    |> Enum.reduce(%{}, &interfaces_to_erl/2)
  end

  @spec routes() :: [tuple()]
  def routes do
    :routes
    |> get_env(%{})
    |> Enum.reduce([], &routes_to_erl/2)
  end

  # private functions

  defp interfaces_to_erl({ifname, %{mac_address: mac, ip_address: ip}}, acc) do
    {ipaddr, mask} = IPv4Address.parse(ip)

    entry =
      %{
        mac_address: String.replace(mac, ~r/:/, ""),
        ip_address: ipaddr,
        subnet_mask: mask,
        network_address: IPv4Address.to_network({ipaddr, mask}),
        prefix_length: get_cidr(ip)
    }

    Map.merge(acc, %{ifname => entry})
  end

  defp routes_to_erl({dst, nexthop}, acc) do
    {dstaddr, mask} = IPv4Address.parse(dst)
    {nexthop, _netmask} = IPv4Address.parse(nexthop)
    entry = %{dst: dstaddr, mask: mask, prefix_length: get_cidr(dst), nexthop: nexthop}
    [entry | acc]
  end

  defp get_cidr(ip) do
    case String.split(ip, ~r/\//) do
      [^ip] ->
        32
      [_addr, cidr] ->
        String.to_integer(cidr)
    end
  end

  defp get_env(key, default),
    do: Application.get_env(:simple_router, key, default)
end
