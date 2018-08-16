defmodule OVSDB.OpenvSwitch do
  use GenServer

  defmodule State do
    defstruct server: nil,
              client_pid: nil,
              monitor_pid: nil,
              ovs_uuid: nil
  end

  @database "Open_vSwitch"

  @open_vswitch "Open_vSwitch"
  @interface "Interface"
  @port "Port"
  @controller "Controller"
  @bridge "Bridge"

  def find_by_name(pid, table, name) do
    GenServer.call(pid, {:find_by_name, table, name})
  end

  # API functions

  @doc """
  Create a bridge:

  ## options:
      iex> OpenvSwitch.add_br(
             client_pid,
             name: "br0",
             fail_mode: "standalone",
             datapath_id: "0000000000000001",
             disable_in_band: "true"
           )
  """
  def add_br(pid, [_|_] = options) do
    br_uuids = GenServer.call(pid, {:sync_get, @open_vswitch, "bridges"})

    add_br_options = [
      bridge: options[:name],
      fail_mode: options[:fail_mode]  || "standalone",
      datapath_id: options[:datapath_id],
      disable_in_band: options[:disable_in_band],
      br_uuids: br_uuids
    ]

    GenServer.call(pid, {:add_br, add_br_options})
  end

  @doc """
  Delete a bridge

     iex> OpenvSwitch.del_br(client_pid, "br0")
  """
  def del_br(pid, bridge) do
    case find_by_name(pid, @bridge, bridge) do
      %{"_uuid" => uuid} ->
        new_bridges =
          case GenServer.call(pid, {:sync_get, @open_vswitch, "bridges"}) do
            ["set", bridges] -> %{"bridges" => ["set", bridges -- [uuid]]}
            ^uuid -> %{"bridges" => ["set", []]}
            curr_bridges -> %{"bridges" => curr_bridges}
          end

        GenServer.call(pid, {:del_br, new_bridges})

      :not_found ->
        {:error, :not_found}
    end
  end

  @doc """
  Set a controller to the switch

     iex> OpenvSwitch.set_controller(
            client_pid,
            bridge: "br0",
            target: "tcp:127.0.0.1:6653",
            connection_mode: "out-of-band",
            controller_rate_limit: 100,
            controller_burst_limit: 25,
            protocol: "OpenFlow13"
          )
  """
  def set_controller(pid, [_|_] = options) do
    case find_by_name(pid, @bridge, options[:bridge]) do
      :not_found ->
        {:error, :not_found}
      %{"_uuid" => _uuid} ->
        set_ctl_opts = [
          bridge: options[:bridge],
          target: options[:target] || "tcp:127.0.0.1:6653",
          connection_mode: options[:connection_mode] || "out-of-band",
          controller_rate_limit: options[:controller_rate_limit] || 1000,
          controller_burst_limit: options[:controller_burst_limit] || 100,
          protocol: options[:protocol] || "OpenFlow13",
        ]

        GenServer.call(pid, {:set_controller, set_ctl_opts})
    end
  end

  @doc """
     iex> OpenvSwitch.add_port(
            client_pid,
            bridge: "br0",
            name: "vxlan5",
            type: "vxlan",
            remote_ip: "flow",
            ofport_request: 99
          )
  """
  def add_port(pid, [_|_] = options) do
    case find_by_name(pid, @bridge, options[:bridge]) do
      :not_found ->
        {:error, :not_found}
      %{"_uuid" => _uuid, "ports" => ports} ->
        port_opts = [
          bridge: options[:bridge],
          name: options[:name],
          type: options[:type] || "system",
          ofport_request: options[:ofport_request],
          remote_ip: options[:remote_ip],
          local_ip: options[:local_ip],
          in_key: options[:in_key],
          out_key: options[:out_key],
          key: options[:key],
          tos: options[:tos],
          ttl: options[:ttl],
          df_default: options[:df_default],
          csum: options[:csum],
          peer_cert: options[:peer_cert],
          certificate: options[:certificate],
          private_key: options[:private_key],
          psk: options[:psk],
          ingress_policing_rate: options[:ingress_policing_rate] || 0,
          ingress_policing_burst: options[:ingress_policing_burst] || 0,
          ports: ports
        ]

        GenServer.call(pid, {:add_port, port_opts})
    end
  end

  @doc """
      iex> OpenvSwitch.del_port(client_pid, bridge: "br0", port: "vxlan5")
  """
  def del_port(pid, [_|_] = options) do
    case find_by_name(pid, @bridge, options[:bridge]) do
      :not_found ->
        {:error, :not_found}
      %{"_uuid" => _uuid, "ports" => ports} ->
        case find_by_name(pid, @port, options[:port]) do
          :not_found ->
            {:error, :not_found}
          %{"_uuid" => port_uuid} ->
            new_ports = del_elem_from_set(ports, port_uuid)

            port_opts = [
              bridge: options[:bridge],
              ports: new_ports
            ]

            GenServer.call(pid, {:del_port, port_opts})
        end
    end
  end

  # GenServer callback functions

  def start_link(server) do
    GenServer.start_link(__MODULE__, [server])
  end

  def init([server]) do
    state =
      server
      |> String.to_charlist()
      |> init_client

    {:ok, state}
  end

  def handle_call({:sync_get, table, col_name}, _from, state) do
    [%{"rows" => [%{^col_name => values} | _]}] =
      [col_name]
      |> :eovsdb_op.select(table, [])
      |> xact(state.client_pid)

    {:reply, values, state}
  end

  def handle_call({:add_br, options}, _from, state) do
    %State{client_pid: pid, ovs_uuid: ovs} = state
    br_iface = %{name: options[:bridge], type: :internal}
    br_port = %{name: options[:bridge], interfaces: ["named-uuid", "interface"]}

    other_config = [
      ["datapath-id", options[:datapath_id]],
      ["dp-desc", options[:dp_desc]],
      ["disable-in-band", options[:disable_in_band]],
      ["in-band-queue", options[:in_band_queue]]
    ]

    new_bridge = %{
      name: options[:bridge],
      ports: ["named-uuid", "port"],
      fail_mode: options[:fail_mode],
      other_config: make_ovsdb_map(other_config)
    }

    named_uuid = ["named-uuid", "bridge"]
    new_bridges = %{bridges: add_elem_to_set(options[:br_uuids], named_uuid)}

    next_config = [{"next_cfg", "+=", 1}]
    eq_ovs_uuid = [{"_uuid", "==", ovs}]

    replies =
      xact(
        [
          :eovsdb_op.insert(@interface, br_iface, "interface"),
          :eovsdb_op.insert(@port, br_port, "port"),
          :eovsdb_op.insert(@bridge, new_bridge, "bridge"),
          :eovsdb_op.update(@open_vswitch, eq_ovs_uuid, new_bridges),
          :eovsdb_op.mutate(@open_vswitch, eq_ovs_uuid, next_config)
        ],
        pid
      )

    {:reply, replies, state}
  end

  def handle_call({:del_br, new_bridges}, _from, state) do
    %State{client_pid: pid, ovs_uuid: ovs} = state
    eq_ovs_uuid = [{"_uuid", "==", ovs}]
    next_config = [{"next_cfg", "+=", 1}]

    replies =
      xact(
        [
          :eovsdb_op.update(@open_vswitch, eq_ovs_uuid, new_bridges),
          :eovsdb_op.mutate(@open_vswitch, eq_ovs_uuid, next_config)
        ],
        pid
      )

    {:reply, replies, state}
  end

  def handle_call({:del_port, options}, _from, state) do
    %State{client_pid: pid, ovs_uuid: ovs} = state
    eq_br_name = [{"name", "==", options[:bridge]}]
    eq_ovs_uuid = [{"_uuid", "==", ovs}]
    next_config = [{"next_cfg", "+=", 1}]

    bridge = %{ports: options[:ports]}

    replies =
      xact([
        :eovsdb_op.update(@bridge, eq_br_name, bridge),
        :eovsdb_op.mutate(@open_vswitch, eq_ovs_uuid, next_config)
      ], pid)

    {:reply, replies, state}
  end

  def handle_call({:set_controller, options}, _from, state) do
    %State{client_pid: pid, ovs_uuid: ovs} = state
    controller = %{
      target: options[:target],
      connection_mode: options[:connection_mode],
      controller_rate_limit: options[:controller_rate_limit],
      controller_burst_limit: options[:controller_burst_limit],
    }

    bridge = %{
      protocols: options[:protocol],
      controller: ["named-uuid", "controller"],
    }

    replies =
      xact([
        :eovsdb_op.insert(@controller, controller, "controller"),
        :eovsdb_op.update(@bridge, [{"name", "==", options[:bridge]}], bridge),
        :eovsdb_op.mutate(@open_vswitch, [{"_uuid", "==", ovs}], [{"next_cfg", "+=", 1}])
      ], pid)

    {:reply, replies, state}
  end

  def handle_call({:add_port, options}, _from, state) do
    %State{client_pid: pid, ovs_uuid: ovs} = state

    port = %{
      name: options[:name],
      interfaces: ["named-uuid", "interface"],
    }

    iface_options = [
      ["remote_ip", options[:remote_ip]],
      ["local_ip", options[:local_ip]],
      ["in_key", options[:in_key]],
      ["out_key", options[:out_key]],
      ["key", options[:key]],
      ["tos", options[:tos]],
      ["ttl", options[:ttl]],
      ["df_default", options[:df_default]],
      ["csum", options[:csum]],
      ["peer_cert", options[:peer_cert]],
      ["certificate", options[:certificate]],
      ["private_key", options[:private_key]],
      ["psk", options[:psk]]
    ]

    interface = %{
      name: options[:name],
      type: options[:type],
      ingress_policing_rate: options[:ingress_policing_rate],
      ingress_policing_burst: options[:ingress_policing_burst],
      ofport_request: make_ovsdb_set(options[:ofport_request]),
      options: make_ovsdb_map(iface_options)
    }

    bridge = %{ports: add_elem_to_set(options[:ports], ["named-uuid", "port"])}

    next_config = [{"next_cfg", "+=", 1}]
    eq_br_name = [{"name", "==", options[:bridge]}]
    eq_ovs_uuid = [{"_uuid", "==", ovs}]

    replies =
      xact(
        [
          :eovsdb_op.insert(@interface, interface, "interface"),
          :eovsdb_op.insert(@port, port, "port"),
          :eovsdb_op.update(@bridge, eq_br_name, bridge),
          :eovsdb_op.mutate(@open_vswitch, eq_ovs_uuid, next_config)
        ],
        pid
      )

    {:reply, replies, state}
  end

  def handle_call({:find_by_name, table, name}, _from, state) do
    %State{client_pid: pid} = state
    reply = do_find_by_name(pid, table, name)
    {:reply, reply, state}
  end

  def handle_cast({:async_get, "_uuid"}, state) do
    [%{"rows" => [%{"_uuid" => values} | _]}] =
      ["_uuid"]
      |> :eovsdb_op.select(@open_vswitch, [])
      |> xact(state.client_pid)

    {:noreply, %{state | ovs_uuid: values}}
  end

  # private functions

  defp init_client(server) do
    {:ok, pid} = :eovsdb_client.connect(server, database: @database)
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

  defp do_find_by_name(pid, table, name) do
    query = :eovsdb_op.select('*', table, [{"name", "==", name}])
    case xact(query, pid) do
      [%{"rows" => []}] -> :not_found
      [%{"rows" => [row]}] -> row
    end
  end

  defp make_ovsdb_map(map), do: make_ovsdb_map([], map)

  defp make_ovsdb_map(acc, []), do: ["map", Enum.reverse(acc)]
  defp make_ovsdb_map(acc, [[_key, nil]|rest]), do: make_ovsdb_map(acc, rest)
  defp make_ovsdb_map(acc, [attr|rest]), do: make_ovsdb_map([attr|acc], rest)

  defp make_ovsdb_set(nil), do: ["set", []]
  defp make_ovsdb_set([_|_] = list), do: ["set", list]
  defp make_ovsdb_set(value), do: value

  defp add_elem_to_set(["set", []], value), do: value
  defp add_elem_to_set(["set", values], value), do: ["set", values ++ [value]]
  defp add_elem_to_set(["uuid", _] = uuid, value), do: ["set", [uuid] ++ [value]]

  defp del_elem_from_set(["set", values], value), do: ["set", values -- [value]]
  defp del_elem_from_set(["uuid", _], _value), do: ["set", []]
end
