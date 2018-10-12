defmodule EvpnRouter.GoBGP.NativeUtils do
  use Rustler, otp_app: :evpn_router, crate: :evpn_router

  @spec get_route_family(String.t()) :: {:ok, non_neg_integer()}
  def get_route_family(_p0) do
    {:error, :nif_error}
  end
end
