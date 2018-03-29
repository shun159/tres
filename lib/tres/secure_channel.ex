defmodule Tres.SecureChannel do
  @behaviour :gen_statem

  import Logger

  alias :tres_xact_kv, as: XACT_KV
  alias :queue, as: Queue
  alias Tres.SecureChannelState, as: State
  alias Tres.SwitchRegistry
  alias Tres.MessageHandlerSup

  @process_flags [
    trap_exit: true,
    message_queue_data: :off_heap
  ]

  @supported_version 4

  @hello_handshake_timeout 1000
  @features_handshake_timeout 1000
  @ping_timeout 5000
  # @transaction_timeout        5000

  @ping_interval 5000
  @ping_fail_max_count 10

  def callback_mode do
    [:handle_event_function, :state_enter]
  end

  def start_link(ref, socket, transport, opts \\ []) do
    init_args = [[ref, socket, transport, opts]]
    :proc_lib.start_link(__MODULE__, :init, init_args)
  end

  def init([ref, socket, transport, _opts]) do
    state_data = init_secure_channel(ref, socket, transport)

    debug(
      "[#{__MODULE__}] TCP connected to Switch on" <>
        " #{state_data.ip_addr}:#{state_data.port}" <> " on #{inspect(self())}"
    )

    :gen_statem.enter_loop(__MODULE__, [], :INIT, state_data, [])
  end

  # TCP handler
  def handle_event(
        :info,
        {:tcp, socket, packet},
        state,
        %State{socket: socket, transport: transport} = state_data
      ) do
    transport.setopts(socket, active: :once)
    handle_packet(packet, state_data, state, [])
  end

  def handle_event(:info, {:tcp_closed, socket}, _state, %State{socket: socket} = state_data) do
    close_connection(:tcp_closed, state_data)
  end

  def handle_event(
        :info,
        {:tcp_error, socket, reason},
        _state,
        %State{socket: socket} = state_data
      ) do
    close_connection({:tcp_error, reason}, state_data)
  end

  def handle_event(
        :info,
        {:DOWN, _ref, :process, _main_pid, _reason} = signal,
        _state,
        state_data
      ) do
    handle_signal(signal, state_data)
  end

  def handle_event(:info, {:EXIT, _pid, _reason} = signal, _state, state_data) do
    handle_signal(signal, state_data)
  end

  def handle_event(type, message, :INIT, state_data) do
    handle_INIT(type, message, state_data)
  end

  def handle_event(type, message, :CONNECTING, state_data) do
    handle_CONNECTING(type, message, state_data)
  end

  def handle_event(type, message, :CONNECTED, state_data) do
    handle_CONNECTED(type, message, state_data)
  end

  def handle_event(type, message, :WAITING, state_data) do
    handle_WATING(type, message, state_data)
  end

  def terminate(reason, state, %State{
        datapath_id: datapath_id,
        aux_id: aux_id,
        xact_kv_ref: kv_ref
      }) do
    warn("[#{__MODULE__}] termiate: #{inspect(reason)} state = #{inspect(state)}")
    true = XACT_KV.drop(kv_ref)
    :ok = SwitchRegistry.unregister({datapath_id, aux_id})
  end

  # private functions

  defp init_secure_channel(ref, socket, transport) do
    init_process(ref)
    :ok = transport.setopts(socket, active: :once)
    kv_ref = XACT_KV.create()
    State.new(ref: ref, socket: socket, transport: transport, xact_kv_ref: kv_ref)
  end

  defp init_process(ref) do
    :ok = :proc_lib.init_ack({:ok, self()})
    :ok = :ranch.accept_ack(ref)
    for {flag, value} <- @process_flags, do: Process.flag(flag, value)
  end

  defp init_handler(state_data) do
    %State{datapath_id: dpid, aux_id: aux_id} = state_data

    case MessageHandlerSup.start_child({dpid, aux_id}) do
      {:ok, pid} ->
        ref = Process.monitor(pid)
        %{state_data | handler_pid: pid, handler_ref: ref}

      {:error, reason} ->
        {:stop, reason}
    end
  end

  # INIT state
  defp handle_INIT(:enter, _old_state, state_data) do
    debug(
      "[#{__MODULE__}] Initiate HELLO handshake: " <> "#{state_data.ip_addr}:#{state_data.port}"
    )

    initiate_hello_handshake(state_data)
  end

  defp handle_INIT(:info, :hello_timeout, state_data) do
    close_connection(:hello_handshake_timeout, state_data)
  end

  defp handle_INIT(:internal, {:openflow, %Openflow.Hello{} = hello}, state_data) do
    handle_hello_handshake_1(hello, state_data)
  end

  defp handle_INIT(:internal, message, _state_data) do
    debug(
      "[#{__MODULE__}] Hello handshake in progress, " <> "dropping message: #{inspect(message)}"
    )

    :keep_state_and_data
  end

  # CONNECTING state
  defp handle_CONNECTING(:enter, :INIT, state_data) do
    debug(
      "[#{__MODULE__}] Initiate FEATURES handshake:" <>
        " #{state_data.ip_addr}:#{state_data.port}"
    )

    initiate_features_handshake(state_data)
  end

  defp handle_CONNECTING(:enter, :WAITING, state_data) do
    debug("[#{__MODULE__}] Re-entered features handshake")
    initiate_features_handshake(state_data)
  end

  defp handle_CONNECTING(:info, :features_timeout, state_data) do
    close_connection(:features_handshake_timeout, state_data)
  end

  defp handle_CONNECTING(
         :internal,
         {:openflow, %Openflow.Features.Reply{} = features},
         state_data
       ) do
    debug(
      "[#{__MODULE__}] Switch connected " <>
        "datapath_id: #{features.datapath_id}" <> " auxiliary_id: #{features.aux_id}"
    )

    _ = maybe_cancel_timer(state_data.timer_ref)
    handle_features_handshake(features, state_data)
  end

  defp handle_CONNECTING(:internal, {:openflow, message}, _state_data) do
    debug(
      "[#{__MODULE__}] Features handshake in progress," <>
        " dropping message: #{inspect(message.__struct__)}"
    )

    :keep_state_and_data
  end

  defp handle_CONNECTING(type, _message, state_data) when type == :cast or type == :call do
    {:keep_state, state_data, [{:postpone, true}]}
  end

  # CONNECTED state
  defp handle_CONNECTED(:enter, :CONNECTING, state_data) do
    case init_handler(state_data) do
      %State{} = new_state_data ->
        start_periodic_idle_check()
        {:keep_state, new_state_data}

      {:stop, reason} ->
        close_connection({:handler_down, reason}, state_data)
    end
  end

  defp handle_CONNECTED(:info, :idle_check, state_data) do
    start_periodic_idle_check()
    new_state_data = maybe_ping(state_data)
    {:keep_state, new_state_data}
  end

  defp handle_CONNECTED(:info, :ping_timeout, state_data) do
    handle_ping_timeout(state_data, :CONNECTED)
  end

  defp handle_CONNECTED(
         :internal,
         {:openflow, %Openflow.Echo.Reply{xid: xid}},
         %State{ping_xid: xid} = state_data
       ) do
    handle_ping_reply(state_data)
  end

  defp handle_CONNECTED(:internal, {:openflow, %Openflow.Echo.Request{} = echo}, state_data) do
    send_echo_reply(echo.xid, echo.data, state_data)
    :keep_state_and_data
  end

  defp handle_CONNECTED(:internal, {:openflow, %Openflow.Barrier.Reply{} = barrier}, state_data) do
    {new_state_data, next_actions} = process_xact(barrier, state_data)
    {:keep_state, new_state_data, next_actions}
  end

  defp handle_CONNECTED(:internal, {:openflow, message}, state_data) do
    %State{datapath_id: dpid, aux_id: aux_id} = state_data
    new_message = %{message | datapath_id: dpid, aux_id: aux_id}

    state_data.xact_kv_ref
    |> XACT_KV.is_exists(message.xid)
    |> handle_message(new_message, state_data)

    :keep_state_and_data
  end

  defp handle_CONNECTED(:internal, {:send_message, message}, state_data) do
    xactional_send_message(message, state_data)
    :keep_state_and_data
  end

  defp handle_CONNECTED({:call, from}, :get_xid, state_data) do
    xid = State.get_transaction_id(state_data.xid)
    {:keep_state_and_data, [{:reply, from, {:ok, xid}}]}
  end

  defp handle_CONNECTED(:cast, {:send_message, message} = action, state_data) do
    new_action_queue =
      if XACT_KV.is_empty(state_data.xact_kv_ref) do
        xactional_send_message(message, state_data)
        state_data.action_queue
      else
        Queue.in(action, state_data.action_queue)
      end

    {:keep_state, %{state_data | action_queue: new_action_queue}}
  end

  # WATING state
  defp handle_WATING(:enter, _state, state_data) do
    warn("[#{__MODULE__}] Possible HANG Detected on datapath_id: #{state_data.datapath_id} !")
    %State{handler_pid: handler_pid, datapath_id: dpid, aux_id: aux_id} = state_data
    send(handler_pid, {:switch_hang, {dpid, aux_id}})
    start_periodic_idle_check()
    :keep_state_and_data
  end

  defp handle_WATING(:info, :idle_check, state_data) do
    start_periodic_idle_check()
    new_state_data = maybe_ping(state_data)
    {:keep_state, new_state_data}
  end

  defp handle_WATING(:info, :ping_timeout, state_data) do
    handle_ping_timeout(state_data, :WAITING)
  end

  defp handle_WATING(:internal, {:openflow, message}, state_data) do
    %State{handler_pid: handler_pid, datapath_id: dpid, aux_id: aux_id} = state_data
    send(handler_pid, %{message | datapath_id: dpid, aux_id: aux_id})
    {:next_state, :CONNECTING, state_data}
  end

  defp handle_WATING(type, message, state_data)
       when type == :cast or type == :call do
    debug("[#{__MODULE__}] Postponed: #{inspect(message)}, now WATING")
    {:keep_state, state_data, [{:postpone, true}]}
  end

  defp handle_packet("", state_data, _state, actions) do
    {:keep_state, %{state_data | ping_fail_count: 0}, Enum.reverse(actions)}
  end

  defp handle_packet(packet, %State{buffer: buffer} = state_data, state, actions) do
    binary = <<buffer::bytes, packet::bytes>>

    case Openflow.read(binary) do
      {:ok, message, leftovers} ->
        debug(
          "[#{__MODULE__}] Received: #{inspect(message.__struct__)}" <>
            "(xid: #{message.xid}) in #{state}"
        )

        action = {:next_event, :internal, {:openflow, message}}
        new_state_data = %{state_data | buffer: "", last_received: :os.timestamp()}
        handle_packet(leftovers, new_state_data, state, [action | actions])

      {:error, :binary_too_small} ->
        handle_packet("", %{state_data | buffer: binary}, state, actions)

      {:error, _reason} ->
        handle_packet("", state_data, state, actions)
    end
  end

  defp handle_message(_in_xact = true, message, state_data) do
    case XACT_KV.get(state_data.xact_kv_ref, message.xid) do
      [{:xact_entry, _xid, prev_message, _orig} | _] ->
        new_message = Openflow.append_body(prev_message, message)
        XACT_KV.update(state_data.xact_kv_ref, message.xid, new_message)

      _ ->
        XACT_KV.delete(state_data.xact_kv_ref, message.xid)
    end
  end

  defp handle_message(_in_xact = false, message, state_data),
    do: send(state_data.handler_pid, message)

  defp process_xact(%Openflow.Barrier.Reply{xid: xid}, state_data) do
    :ok =
      state_data.xact_kv_ref
      |> XACT_KV.get(xid)
      |> Enum.each(&process_xact_entry(&1, state_data))

    pop_action_queue(state_data)
  end

  defp process_xact_entry({:xact_entry, xid, message, _orig}, state_data) do
    unless is_nil(message), do: send(state_data.handler_pid, message)
    XACT_KV.delete(state_data.xact_kv_ref, xid)
  end

  defp pop_action_queue(%State{action_queue: queue} = state_data) do
    {next_actions, new_queue} =
      case Queue.out(queue) do
        {:empty, action_queue} ->
          {[], action_queue}

        {{:value, next_action}, action_queue} ->
          {[{:next_event, :internal, next_action}], action_queue}
      end

    {%{state_data | action_queue: new_queue}, next_actions}
  end

  defp initiate_hello_handshake(state_data) do
    send_hello(state_data)
    ref = Process.send_after(self(), :hello_timeout, @hello_handshake_timeout)
    {:keep_state, %{state_data | timer_ref: ref}}
  end

  defp handle_hello_handshake_1(hello, state_data) do
    maybe_cancel_timer(state_data.timer_ref)
    State.set_transaction_id(state_data.xid, hello.xid)

    if Openflow.Hello.supported_version?(hello) do
      {:next_state, :CONNECTING, %{state_data | timer_ref: nil}}
    else
      close_connection(:failed_version_negotiation, state_data)
    end
  end

  defp initiate_features_handshake(state_data) do
    new_xid = State.increment_transaction_id(state_data.xid)
    send_features(new_xid, state_data)
    ref = Process.send_after(self(), :features_timeout, @features_handshake_timeout)
    {:keep_state, %{state_data | timer_ref: ref}}
  end

  defp handle_features_handshake(
         %Openflow.Features.Reply{datapath_id: datapath_id, aux_id: aux_id},
         state_data
       ) do
    {:ok, _} = SwitchRegistry.register({datapath_id, aux_id})

    new_state_data = %{
      state_data
      | datapath_id: datapath_id,
        aux_id: aux_id,
        timer_ref: nil,
        main_monitor_ref: monitor_connection(datapath_id, aux_id)
    }

    {:next_state, :CONNECTED, new_state_data}
  end

  defp monitor_connection(datapath_id, aux_id) when aux_id > 0,
    do: SwitchRegistry.monitor(datapath_id)

  defp monitor_connection(_datapath_id, _aux_id), do: nil

  defp send_hello(state_data) do
    @supported_version
    |> Openflow.Hello.new()
    |> send_message(state_data)
  end

  defp send_features(xid, state_data) do
    %{Openflow.Features.Request.new() | xid: xid}
    |> send_message(state_data)
  end

  defp send_echo_reply(xid, data, state_data) do
    %{Openflow.Echo.Reply.new(data) | xid: xid}
    |> send_message(state_data)
  end

  defp send_echo_request(xid, data, state_data) do
    %{Openflow.Echo.Request.new(data) | xid: xid}
    |> send_message(state_data)
  end

  defp start_periodic_idle_check do
    Process.send_after(self(), :idle_check, @ping_interval)
  end

  defp maybe_ping(state_data) do
    case should_be_ping?(state_data) do
      true -> send_ping(state_data)
      false -> state_data
    end
  end

  defp should_be_ping?(%State{last_received: last_received, aux_id: 0}) do
    :timer.now_diff(:os.timestamp(), last_received) > 1000 * @ping_interval
  end

  defp should_be_ping?(_) do
    false
  end

  defp send_ping(%State{xid: table_ref} = state_data) do
    xid = State.increment_transaction_id(table_ref)
    send_echo_request(xid, "", state_data)
    ping_ref = Process.send_after(self(), :ping_timeout, @ping_timeout)
    %{state_data | ping_timer_ref: ping_ref, ping_xid: xid}
  end

  defp handle_ping_timeout(%State{ping_fail_count: fail_count} = state_data, :CONNECTED)
       when fail_count > @ping_fail_max_count do
    {:next_state, :WAITING, %{state_data | ping_fail_count: fail_count + 1}}
  end

  defp handle_ping_timeout(%State{ping_fail_count: fail_count} = state_data, :WAITING)
       when fail_count > @ping_fail_max_count do
    close_connection(:ping_failed, state_data)
  end

  defp handle_ping_timeout(state_data, _) do
    {:keep_state, %{state_data | ping_fail_count: state_data.ping_fail_count + 1}}
  end

  defp handle_ping_reply(state_data) do
    :ok = maybe_cancel_timer(state_data.ping_timer_ref)
    {:keep_state, %{state_data | ping_timer_ref: nil, ping_xid: nil}}
  end

  defp xactional_send_message(%{xid: 0} = message, state_data) do
    xid = State.increment_transaction_id(state_data.xid)

    messages = [
      %{message | xid: xid},
      %{Openflow.Barrier.Request.new() | xid: xid}
    ]

    XACT_KV.insert(state_data.xact_kv_ref, xid, message)
    send_message(messages, state_data)
  end

  defp xactional_send_message(%{xid: xid} = message, state_data) do
    _ = State.set_transaction_id(state_data.xid, xid)

    messages = [
      %{message | xid: xid},
      %{Openflow.Barrier.Request.new() | xid: xid}
    ]

    XACT_KV.insert(state_data.xact_kv_ref, xid, message)
    send_message(messages, state_data)
  end

  defp send_message(message, %State{socket: socket, transport: transport}) do
    if is_list(message) do
      for message <- message,
          do:
            debug("[#{__MODULE__}] Sending: #{inspect(message.__struct__)}(xid: #{message.xid})")
    else
      debug("[#{__MODULE__}] Sending: #{inspect(message.__struct__)}(xid: #{message.xid})")
    end

    Tres.Utils.send_message(message, socket, transport)
  end

  defp maybe_cancel_timer(ref) when not is_reference(ref), do: :ok

  defp maybe_cancel_timer(ref) do
    Process.cancel_timer(ref)
    :ok
  end

  defp handle_signal(
         {:DOWN, mon_ref, :process, _main_pid, reason},
         %State{main_monitor_ref: mon_ref} = state_data
       ) do
    close_connection({:main_closed, reason}, state_data)
  end

  defp handle_signal(
         {:DOWN, handler_ref, :process, _main_pid, reason},
         %State{handler_ref: handler_ref} = state_data
       ) do
    close_connection({:handler_down, reason}, state_data)
  end

  defp handle_signal({:EXIT, _pid, reason}, state_data) do
    close_connection({:trap_detected, reason}, state_data)
  end

  defp close_connection(:failed_version_negotiation, state_data) do
    warn("[#{__MODULE__}] connection terminated: Version negotiation failed")
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection(:hello_handshake_timeout, state_data) do
    warn("[#{__MODULE__}] connection terminated: Hello handshake timed out")
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection(:features_timeout, state_data) do
    warn("[#{__MODULE__}] connection terminated: Features handshake timed out")
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection(:handler_error = disconnected_reason, state_data) do
    warn("[#{__MODULE__}] connection terminated: Got handler error")
    %State{handler_pid: handler_pid} = state_data
    send(handler_pid, {:switch_disconnected, disconnected_reason})
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection(:ping_failed = disconnected_reason, state_data) do
    warn("[#{__MODULE__}] connection terminated: Exceeded to max_ping_fail_count")
    %State{handler_pid: handler_pid} = state_data
    send(handler_pid, {:switch_disconnected, disconnected_reason})
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection({:main_closed = disconnected_reason, reason}, state_data) do
    warn("[#{__MODULE__}] connection terminated: Main connection down by #{reason}")
    %State{handler_pid: handler_pid} = state_data
    send(handler_pid, {:switch_disconnected, disconnected_reason})
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection({:handler_down = _disconnected_reason, reason}, state_data) do
    warn("[#{__MODULE__}] connection terminated: Handler process down by #{reason}")
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection({:trap_detected = disconnected_reason, reason}, state_data) do
    warn("[#{__MODULE__}] connection terminated: Trapped by #{reason}")
    %State{handler_pid: handler_pid} = state_data
    send(handler_pid, {:switch_disconnected, disconnected_reason})
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection(:tcp_closed = disconnected_reason, state_data) do
    warn("[#{__MODULE__}] connection terminated: TCP Closed by peer")
    %State{handler_pid: handler_pid} = state_data
    send(handler_pid, {:switch_disconnected, disconnected_reason})
    {:stop, :normal, %{state_data | socket: nil}}
  end

  defp close_connection({:tcp_error, reason} = disconnected_reason, state_data) do
    warn("[#{__MODULE__}] connection terminated: TCP Error occured: #{reason}")
    %State{handler_pid: handler_pid} = state_data
    send(handler_pid, {:switch_disconnected, disconnected_reason})
    {:stop, :normal, %{state_data | socket: nil}}
  end
end
