defmodule Pf do
  use GenServer

  defmodule State do
    defstruct [
      ifname:     nil,
      pcap_ref:   nil,
      tester_pid: nil
    ]
  end

  def start_link(ifname, pid) do
    ifname = String.to_charlist(ifname)
    GenServer.start_link(__MODULE__, [ifname, pid])
  end

  def init([ifname, pid]) do
    {:ok, pid} = :epcap.start_link(interface: ifname, chroot: 'priv/tmp', inject: true)
    %State{pcap_ref: pid, ifname: ifname, tester_pid: pid}
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
    send(state.tester_pid, data)
    {:noreply, state}
  end
  def handle_info(_info, state) do
    {:noreply, state}
  end
end
