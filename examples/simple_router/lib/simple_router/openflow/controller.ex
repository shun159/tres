defmodule SimpleRouter.Openflow.Controller do
  @moduledoc """
  Emulates Router
  """

  use GenServer
  use Tres.Controller

  import Logger

  alias SimpleRouter.Config
  alias SimpleRouter.Openflow.FlowTables
  alias SimpleRouter.Openflow.GroupTables

  defmodule State do
    @moduledoc false

    defstruct [
      datapath_id: nil,
      ports: %{}
    ]
  end

  def start_link({datapath_id, _aux_id}, _start_args) do
    GenServer.start_link(__MODULE__, [datapath_id])
  end

  def init([datapath_id]) do
    :ok = debug("Switch Connected: datapath_id = #{datapath_id}")
    {:ok, %State{datapath_id: datapath_id}, {:continue, :init_datapath}}
  end

  def handle_continue(:init_datapath, state) do
    :ok = init_datapath(state.datapath_id)
    {:noreply, state, {:continue, :init_interface}}
  end

  def handle_continue(:init_interface, state) do
    port_desc = PortDesc.Request.new()
    :ok = send_message(port_desc, state.datapath_id)
    {:noreply, state}
  end

  def handle_info(%PortDesc.Reply{datapath_id: dpid, ports: ports}, state) do
    :ok = debug("port_reply from dpid: #{dpid}")
    ports = handle_ports(ports)
    routes = Config.routes()
    :ok = FlowTables.classifier(dpid)
    :ok = init_egress_groups(ports, dpid)
    :ok = init_interface_lookup_flows(ports, dpid)
    :ok = init_arp_handler_flows(ports, dpid)
    :ok = init_egress_flows(ports, dpid)
    :ok = init_connected_routes(ports, dpid)
    :ok = init_static_routes(routes, dpid)
    {:noreply, %{state | ports: ports}}
  end

  def handle_info(%NxPacketIn2{userdata: <<"ARP_missing", arp_req::bytes>>} = pin, state) do
    :ok = debug("ARP Entry missing: #{inspect(pin)}")
    nexthop_address = pin.metadata[:reg0]

    send_packet_out(
      packet_in: pin,
      metadata: Keyword.replace!(pin.metadata, :in_port, :controller),
      data: <<arp_req::bytes, nexthop_address::32>>
    )

    {:noreply, state}
  end

  def handle_info(info, state) do
    :ok = warn("Unhandled info received: #{inspect(info)}")
    {:noreply, state}
  end

  # private functions

  @spec handle_ports([%Openflow.Port{}]) :: [map()]
  defp handle_ports(ports) do
    ifaces = Config.interfaces()
    handle_ports([], ports, ifaces)
  end

  defp handle_ports(acc, [], _ifaces), do: acc

  defp handle_ports(acc0, [port|rest], ifaces) do
    case Map.get(ifaces, port.name) do
      iface0 when is_map(iface0) ->
        iface = Map.merge(iface0, %{number: port.number})
        handle_ports([iface|acc0], rest, ifaces)
      _ ->
        handle_ports(acc0, rest, ifaces)
    end
  end

  @spec init_egress_groups([map()], String.t()) :: :ok
  defp init_egress_groups(ifaces, datapath_id),
    do: Enum.each(ifaces, &GroupTables.egress(&1, datapath_id))

  @spec init_interface_lookup_flows([map()], String.t()) :: :ok
  defp init_interface_lookup_flows(ifaces, datapath_id),
    do: Enum.each(ifaces, &FlowTables.lookup_iface(&1, datapath_id))

  @spec init_arp_handler_flows([map()], String.t()) :: :ok
  defp init_arp_handler_flows(ifaces, datapath_id),
    do: Enum.each(ifaces, &FlowTables.arp_handlers(&1, datapath_id))

  @spec init_egress_flows([map()], String.t()) :: :ok
  defp init_egress_flows(ifaces, datapath_id),
    do: Enum.each(ifaces, &FlowTables.egress(&1, datapath_id))

  @spec init_connected_routes([map()], String.t()) :: :ok
  defp init_connected_routes(ifaces, datapath_id),
    do: Enum.each(ifaces, &FlowTables.connected_route(&1, datapath_id))

  @spec init_static_routes([map()], String.t()) :: :ok
  defp init_static_routes(routes, datapath_id),
    do: Enum.each(routes, &FlowTables.static_route(&1, datapath_id))

  @spec init_datapath(String.t()) :: :ok
  defp init_datapath(datapath_id) do
    :ok = set_config(datapath_id)
    :ok = set_packet_in_format(datapath_id)
  end

  @spec set_config(String.t()) :: :ok
  defp set_config(datapath_id) do
    set_config = SetConfig.new(miss_send_len: :no_buffer)
    :ok = send_message(set_config, datapath_id)
  end

  @spec set_packet_in_format(String.t()) :: :ok
  defp set_packet_in_format(datapath_id) do
    pin_format = NxSetPacketInFormat.new(:nxt_packet_in2)
    :ok = send_message(pin_format, datapath_id)
  end
end
