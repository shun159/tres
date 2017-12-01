defmodule Heckle.Controller do
  use GenServer
  use Bitwise
  use Tres.Controller

  import Logger

  alias Heckle.PipelineProfiles
  alias Heckle.FlowPatterns

  defmodule State do
    defstruct [
      dpid:              nil,
      conn_ref:          nil,
      access_port1_name: nil,
      access_port2_name: nil,
      trunk_port_name:   nil,
      access_port1:      nil,
      access_port2:      nil,
      trunk_port:        nil,
      vlan_tagging:      nil,
      vlan_id:           nil,
      receiver_mac:      nil,
      receiver_ip:       nil,
      sender_mac:        nil,
      inside_local:      nil,
      outside_local:     nil,
      flow_pattern:      nil
    ]
  end

  def start_link(dpid, args) do
    GenServer.start(__MODULE__, [dpid, args])
  end

  def init([{dpid, _aux_id}, [dpid]]) do
    :ok = info("Switch Ready: dpid: #{inspect(dpid)} on #{inspect(self())}")
    state = init_state(dpid)
    {:ok, state}
  end
  def init([{dpid, _aux_id}, [_dpid]]) do
    :ok = info("Switch Ready: dpid: #{inspect(dpid)} but not acceptable")
    :ignore
  end

  def handle_cast(:send_flows, state) do
    state
    |> FlowPatterns.flows
    |> Enum.each(&send_flow_mod_add(state.dpid, &1))
    {:noreply, state}
  end

  def handle_info(%Desc.Reply{mfr_desc: "Aruba"} = desc, %State{dpid: dpid} = state) do
    info("Switch Desc: mfr = #{desc.mfr_desc} hw = #{desc.hw_desc} sw = #{desc.sw_desc}")
    :ok = PipelineProfiles.of_aruba()
    |> TableFeatures.Request.new
    |> send_message(dpid)
    {:noreply, state}
  end
  def handle_info(%Desc.Reply{} = desc, state) do
    :ok = info("Switch Desc: mfr = #{desc.mfr_desc} hw = #{desc.hw_desc} sw = #{desc.sw_desc}")
    :ok = GenServer.cast(self(), :send_flows)
    {:noreply, state}
  end
  def handle_info(%TableFeatures.Reply{xid: xid}, state) do
    :ok = info("Pipeline modification is success (xid: #{xid})")
    :ok = GenServer.cast(self(), :send_flows)
    {:noreply, state}
  end
  def handle_info(%PortDesc.Reply{ports: ports}, state) do
    info("Received Port Desc")
    access_port1 = Enum.find(ports, fn(port) -> port.name == state.access_port1_name end)
    access_port2 = Enum.find(ports, fn(port) -> port.name == state.access_port2_name end)
    trunk_port = Enum.find(ports, fn(port) -> port.name == state.trunk_port_name end)
    :ok = desc_stats_request(state.dpid)
    {:noreply, %{state|access_port1: access_port1, access_port2: access_port2, trunk_port: trunk_port}}
  end
  def handle_info(%ErrorMsg{code: code, type: type, data: data, xid: xid}, state) do
    :ok = warn("Request Failed(xid: #{xid}):"<>
               " code: #{code}"<>
               " type: #{type}"<>
               " data: #{inspect(data)}"<>
               " dpid: #{inspect(state.dpid)}")
    {:stop, :request_failed, state}
  end
  def handle_info({:'DOWN', ref, :process, _pid, _reason}, %State{conn_ref: ref} = state) do
    :ok = debug("Switch Disconnected: dpid: #{inspect(state.dpid)}")
    {:stop, :normal, state}
  end
  def handle_info(_info, state) do
    {:noreply, state}
  end

  # private functions
  defp init_state(dpid) do
    :ok = init_datapath(dpid)
    conn_ref = SwitchRegistry.monitor(dpid)
    config = Application.get_all_env(:heckle)
    %State{
      dpid:              dpid,
      conn_ref:          conn_ref,
      access_port1_name: config[:access_port1],
      access_port2_name: config[:access_port2],
      trunk_port_name:   config[:vlan_trunk],
      vlan_tagging:      config[:vlan_tagging] || true,
      vlan_id:           0x1000 ||| (config[:vlan_id] || 0),
      receiver_mac:      config[:receiver_mac],
      receiver_ip:       config[:receiver_ip],
      sender_mac:        config[:sender_mac],
      inside_local:      config[:inside_local],
      outside_local:     config[:outside_local],
      flow_pattern:      config[:flow_pattern] || :nat
    }
  end

  defp init_datapath(dpid) do
    :ok = send_flow_mod_delete(dpid)
    :ok = port_desc_stats_request(dpid)
    :ok = set_config(dpid)
  end

  defp desc_stats_request(dpid) do
    :ok = send_message(Desc.Request.new, dpid)
  end

  defp port_desc_stats_request(dpid) do
    :ok = send_message(PortDesc.Request.new, dpid)
  end

  defp set_config(dpid) do
    :ok = send_message(SetConfig.new(miss_send_len: :no_buffer), dpid)
  end
end