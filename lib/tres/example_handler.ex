defmodule Tres.ExampleHandler do
  use GenServer
  use Tres.Controller

  import Logger

  defmodule State do
    defstruct datapath_id: nil,
              aux_id: nil,
              conn_ref: nil
  end

  def start_link(datapath, args) do
    GenServer.start_link(__MODULE__, [datapath, args])
  end

  def init([{datapath_id, aux_id}, _args]) do
    info(
      "[#{__MODULE__}] Switch Ready: " <>
        "datapath_id: #{datapath_id} " <> "aux_id: #{aux_id} " <> "on #{inspect(self())}"
    )

    _ = send_desc_stats_request(datapath_id)
    _ = send_port_desc_stats_request(datapath_id)
    state = %State{datapath_id: datapath_id, aux_id: aux_id}
    {:ok, state}
  end

  def handle_info(%PortDesc.Reply{datapath_id: datapath_id} = desc, state) do
    handle_port_desc_stats_reply(desc, datapath_id)
    {:noreply, state}
  end

  def handle_info(%Desc.Reply{datapath_id: datapath_id} = desc, state) do
    handle_desc_stats_reply(desc, datapath_id)
    {:noreply, state}
  end

  def handle_info({:switch_disconnected, reason}, state) do
    :ok =
      warn("[#{__MODULE__}] Switch Disconnected: datapath_id: #{state.datapath_id} by #{reason}")

    {:stop, :normal, state}
  end

  def handle_info({:switch_hang, _datapath_id}, state) do
    :ok = warn("[#{__MODULE__}] Switch possible hang: datapath_id: #{state.datapath_id}")
    {:noreply, state}
  end

  # `Catch all` function is required.
  def handle_info(info, state) do
    :ok = warn("[#{__MODULE__}] unhandled message #{inspect(info)}: #{state.datapath_id}")
    {:noreply, state}
  end

  # private functions

  defp send_desc_stats_request(datapath_id) do
    Desc.Request.new()
    |> send_message(datapath_id)
  end

  defp send_port_desc_stats_request(datapath_id) do
    PortDesc.Request.new()
    |> send_message(datapath_id)
  end

  defp handle_desc_stats_reply(desc, datapath_id) do
    info(
      "[#{__MODULE__}] Switch Desc: " <>
        "mfr = #{desc.mfr_desc} " <>
        "hw = #{desc.hw_desc} " <> "sw = #{desc.sw_desc} " <> "for #{datapath_id}"
    )
  end

  defp handle_port_desc_stats_reply(port_desc, datapath_id) do
    for port <- port_desc.ports do
      info(
        "[#{__MODULE__}] Switch has port: " <>
          "number = #{port.number} " <>
          "hw_addr = #{port.hw_addr} " <>
          "name = #{port.name} " <>
          "config = #{inspect(port.config)} " <>
          "current_speed = #{port.current_speed} " <> "on #{datapath_id}"
      )
    end
  end
end
