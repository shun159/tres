defmodule Tres.Utils do
  import Logger

  @connection_manager Tres.SecureChannel
  @default_max_connections 10
  @default_num_acceptors   10
  @default_openflow_port   6633

  def start_openflow_listener do
    max_connections = Application.get_env(:tres, :max_connections, @default_max_connections)
    num_acceptors = Application.get_env(:tres, :num_acceptors, @default_num_acceptors)
    port = Application.get_env(:tres, :port, @default_openflow_port)
    options = [max_connections: max_connections, num_acceptors: num_acceptors, port: port]
    :ranch.start_listener(Tres, :ranch_tcp, options, @connection_manager, [])
  end

  def send_message(message, socket, transport) do
    try do
      packet = Openflow.to_binary(message)
      transport.send(socket, packet)
    catch
      _ ->
        error("[#{__MODULE__}] Unencodable error: #{inspect(message)}")
    end
  end
end
