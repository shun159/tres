defmodule Pf do
  use GenServer

  import Record
  # Extract Erlang record for msantos/pkt
  for {name, schema} <- extract_all(from_lib: "pkt/include/pkt.hrl") do
    defrecord(name, schema)
  end

  defmodule State do
    defstruct ifname: nil,
              pcap_ref: nil,
              tester_pid: nil
  end

  def inject!(pid, packet, payload \\ "") do
    GenServer.cast(pid, {:inject, {packet, payload}})
  end

  def stop(pid) do
    GenServer.cast(pid, :stop)
  end

  def start_link(ifname) do
    ifname = String.to_charlist(ifname)
    GenServer.start_link(__MODULE__, [ifname, self()])
  end

  def init([ifname, tester_pid]) do
    {:ok, init_pf(ifname, tester_pid)}
  end

  def handle_cast({:inject, {headers, payload}}, state) do
    headers_bin =
      for header <- headers do
        case header do
          ether() -> :pkt.ether(header)
          {:"802.1q", _, _, _, _} = vlan -> :pkt_802_1q.codec(vlan)
          arp() -> :pkt.arp(header)
          ipv4() -> :pkt.ipv4(header)
          lldp() -> :pkt.lldp(header)
          udp() -> :pkt.udp(header)
          tcp() -> :pkt.tcp(header)
        end
      end

    binary = Enum.join(headers_bin, "")
    :epcap.send(state.pcap_ref, <<binary::bytes, payload::bytes>>)
    {:noreply, state}
  end

  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end

  def handle_cast(_req, state) do
    {:noreply, state}
  end

  def handle_info({:packet, _dlt, _time, _len, data}, state) do
    packet = :pkt.decapsulate(data)
    packet_len = length(packet)
    send(state.tester_pid, {to_string(state.ifname), Enum.take(packet, packet_len - 1)})
    {:noreply, state}
  end

  def handle_info(_info, state) do
    {:noreply, state}
  end

  # private functions

  defp init_pf(ifname, tester_pid) do
    {:ok, epcap_pid} = :epcap.start_link(interface: ifname, promiscuous: true, inject: true)
    %State{pcap_ref: epcap_pid, ifname: ifname, tester_pid: tester_pid}
  end
end
