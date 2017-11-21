defmodule Pf do
  use GenServer

  defmodule State do
    defstruct [
      ifname:     nil,
      pcap_ref:   nil,
      tester_pid: nil
    ]
  end

  def inject!(pid, packet) do
    GenServer.cast(pid, {:inject, packet})
  end

  def start_link(ifname) do
    ifname = String.to_charlist(ifname)
    GenServer.start_link(__MODULE__, [ifname, self()])
  end

  def init([ifname, tester_pid]) do
    {:ok, epcap_pid} =
      :epcap.start_link(
        interface: ifname,
        promiscuous: true,
        inject: true
      )
    state = %State{
      pcap_ref: epcap_pid,
      ifname: ifname,
      tester_pid: tester_pid
    }
    {:ok, state}
  end

  def handle_cast({:inject, packet}, state) do
    :epcap.send(state.pcap_ref, packet)
    {:noreply, state}
  end
  def handle_cast(:stop, state) do
    {:stop, :normal, state}
  end
  def handle_cast(_req, state) do
    {:noreply, state}
  end

  def handle_info({:packet, _dlt, _time, _len, data}, state) do
    pkt = :pkt.decapsulate(data)
    send(state.tester_pid, {pkt, self()})
    {:noreply, state}
  end
  def handle_info(_info, state) do
    {:noreply, state}
  end
end
