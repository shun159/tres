defmodule OVSDB.OpenvSwitch do
  use GenServer

  defmodule State do
    defstruct [
      server:      nil,
      client_pid:  nil,
      monitor_pid: nil,
      ovs_uuid:    nil
    ]
  end

  @database "Open_vSwitch"

  @open_vswitch "Open_vSwitch"
  @interface    "Interface"
  @port         "Port"
  @controller   "Controller"
  @bridge       "Bridge"

  def start_link(server) do
    GenServer.start_link(__MODULE__, [server])
  end

  def find_by_name(pid, table, name) do
    GenServer.call(pid, {:find_by_name, table, name})
  end

  def add_br(pid, bridge, options \\ []) do
    br_uuids = GenServer.call(pid, {:sync_get, @open_vswitch, "bridges"})
    add_br_options = [
      bridge:     bridge,
      controller: options[:controller] || "tcp:127.0.0.1:6653",
      protocol:   options[:protocol] || "OpenFlow13",
      fail_mode:  options[:fail_mode] || "standalone",
      br_uuids:   br_uuids
    ]
    GenServer.call(pid, {:add_br, add_br_options})
  end

  def del_br(pid, bridge) do
    case find_by_name(pid, @bridge, bridge) do
      %{"_uuid" => uuid} ->
        new_bridges =
          case GenServer.call(pid, {:sync_get, @open_vswitch, "bridges"}) do
            ["set", bridges] -> %{"bridges" => ["set", bridges -- [uuid]]}
            ^uuid            -> %{"bridges" => ["set", []]}
            curr_bridges     -> %{"bridges" => curr_bridges}
          end
        GenServer.call(pid, {:del_br, new_bridges})
      :not_found ->
        {:error, :not_found}
    end
  end

  def init([server]) do
    state = server
    |> String.to_charlist
    |> init_client
    {:ok, state}
  end

  def handle_call({:sync_get, table, col_name}, _from, state) do
    [%{"rows" => [%{^col_name => values}|_]}] =
      [col_name]
      |> :eovsdb_op.select(table, [])
      |> xact(state.client_pid)
    {:reply, values, state}
  end
  def handle_call({:add_br, options}, _from, state) do
    %State{client_pid: pid, ovs_uuid: ovs} = state
    br_iface = %{name: options[:bridge], type: :internal}
    br_port = %{name: options[:bridge], interfaces: ["named-uuid", "brinterface"]}
    controller = %{target: options[:controller]}
    new_bridge = %{
      name:       options[:bridge],
      ports:      ["named-uuid", "brport"],
      controller: ["named-uuid", "brcontroller"],
      fail_mode:  options[:fail_mode],
      protocols:  options[:protocol]
    }
    named_uuid = ["named-uuid", "bridge"]
    new_bridges =
      case options[:br_uuids] do
        ["set", []]          -> %{bridges: named_uuid}
        ["set", bridges]     -> %{bridges: ["set", bridges ++ [named_uuid]]}
        ["uuid", _] = bridge -> %{bridges: ["set", [bridge] ++ [named_uuid]]}
      end
    next_config = [{"next_cfg", "+=", 1}]
    eq_ovs_uuid = [{"_uuid", "==", ovs}]
    replies = xact([
      :eovsdb_op.insert(@interface, br_iface, "brinterface"),
      :eovsdb_op.insert(@port, br_port, "brport"),
      :eovsdb_op.insert(@controller, controller, "brcontroller"),
      :eovsdb_op.insert(@bridge, new_bridge, "bridge"),
      :eovsdb_op.update(@open_vswitch, eq_ovs_uuid, new_bridges),
      :eovsdb_op.mutate(@open_vswitch, eq_ovs_uuid, next_config)
    ], pid)
    {:reply, replies, state}
  end
  def handle_call({:del_br, new_bridges}, _from, state) do
    %State{client_pid: pid, ovs_uuid: ovs} = state
    eq_ovs_uuid = [{"_uuid", "==", ovs}]
    next_config = [{"next_cfg", "+=", 1}]
    replies = xact([
      :eovsdb_op.update(@open_vswitch, eq_ovs_uuid, new_bridges),
      :eovsdb_op.mutate(@open_vswitch, eq_ovs_uuid, next_config)
    ], pid)
    {:reply, replies, state}
  end
  def handle_call({:find_by_name, table, name}, _from, state) do
    %State{client_pid: pid} = state
    query = :eovsdb_op.select('*', table, [{"name", "==", name}])
    reply = case xact(query, pid) do
              [%{"rows" => []}] -> :not_found
              [%{"rows" => [row]}] -> row
            end
    {:reply, reply, state}
  end

  def handle_cast({:async_get, "_uuid"}, state) do
    [%{"rows" => [%{"_uuid" => values}|_]}] =
      ["_uuid"]
      |> :eovsdb_op.select(@open_vswitch, [])
      |> xact(state.client_pid)
    {:noreply, %{state|ovs_uuid: values}}
  end

  # private functions

  defp init_client(server) do
    {:ok, pid} = :eovsdb_client.connect(server, [database: @database])
    :eovsdb_client.regist_schema(pid)
    :ok = GenServer.cast(self(), {:async_get, "_uuid"})
    %State{server: server, client_pid: pid}
  end

  defp xact(query, pid) when is_list(query) do
    {:ok, res} = :eovsdb_client.transaction(pid, query)
    res
  end
  defp xact(query, pid) when is_map(query) do
    xact([query], pid)
  end
end
