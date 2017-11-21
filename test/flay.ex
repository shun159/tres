defmodule Flay do
  use GenServer
  use Tres.Controller

  import Logger

  defmodule State do
    defstruct [
      datapath_id: nil,
      tester_pid:  nil,
      conn_ref:    nil,
      reply_to:    nil
    ]
  end

  def start_link(datapath, args) do
    GenServer.start_link(__MODULE__, [datapath, args], name: __MODULE__)
  end

  def init(args) do
    state = init_controller(args)
    init_bridge(state.datapath_id)
    {:ok, state}
  end

  def handle_call(:port_desc_stats, from, state) do
    send_message(PortDesc.Request.new, state.datapath_id)
    {:noreply, %{state|reply_to: from}}
  end
  def handle_call(:desc_stats, from, state) do
    send_message(Desc.Request.new, state.datapath_id)
    {:noreply, %{state|reply_to: from}}
  end
  def handle_call(:flow_stats, from, state) do
    send_message(Flow.Request.new, state.datapath_id)
    {:noreply, %{state|reply_to: from}}
  end

  def handle_cast({:register_pid, tester_pid}, state) do
    {:noreply, %{state|tester_pid: tester_pid}}
  end
  def handle_cast({:flow_install, flow_opts, tester_pid}, state) do
    send_flow_mod_add(state.datapath_id, flow_opts)
    flow_opts_to_ofp_print(flow_opts)
    {:noreply, %{state|tester_pid: tester_pid}}
  end
  def handle_cast(:flow_del, state) do
    send_flow_mod_delete(state.datapath_id, match: Match.new)
    {:noreply, state}
  end

  def handle_info(%ErrorMsg{} = error, state) do
    send(state.tester_pid, error)
    {:noreply, state}
  end
  def handle_info(%PacketIn{} = pktin, state) do
    send(state.tester_pid, pktin)
    {:noreply, state}
  end
  def handle_info(%PortDesc.Reply{} = desc, state) do
    GenServer.reply(state.reply_to, desc)
    {:noreply, %{state|reply_to: nil}}
  end
  def handle_info(%Desc.Reply{} = desc, state) do
    GenServer.reply(state.reply_to, desc)
    {:noreply, %{state|reply_to: nil}}
  end
  def handle_info(%Flow.Reply{} = desc, state) do
    GenServer.reply(state.reply_to, desc)
    {:noreply, %{state|reply_to: nil}}
  end
  # `Catch all` function is required.
  def handle_info(info, state) do
    # :ok = warn("[#{__MODULE__}] unhandled message #{inspect(info)}")
    {:noreply, state}
  end

  # private functions

  defp flow_opts_to_ofp_print(flow_opts) do
    flow_opts
    |> FlowMod.new
    |> Openflow.to_binary
    |> binary_to_space_delimited_hex
    |> ofp_print_cmd
    |> IO.inspect
  end

  defp ofp_print_cmd(print_args) do
    IO.inspect("\n")
    {result, _code} = System.cmd("ovs-ofctl", ["ofp-print", "#{print_args}"])
    result
  end

  defp binary_to_space_delimited_hex(binary) do
    binary
    |> split_to_hex_string
    |> Enum.join(" ")
    |> String.downcase
  end

  defp split_to_hex_string(binary) do
    for <<int <- binary>>, do: integer_to_hex(int)
  end

  defp integer_to_hex(int) do
    case Integer.to_string(int, 16) do
      <<d>> -> <<48, d>>
      dd    -> dd
    end
  end

  defp init_controller([datapath_id, tester_pid]) do
    conn_ref = SwitchRegistry.monitor(datapath_id)
    %State{
      datapath_id: datapath_id,
      tester_pid:  tester_pid,
      conn_ref:    conn_ref
    }
  end

  defp init_bridge(datapath_id) do
    send_flow_mod_delete(datapath_id, table_id: :all)
  end
end
