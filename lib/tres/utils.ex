defmodule Tres.Utils do
  import Logger

  @connection_manager Tres.SecureChannel
  @default_max_connections 10
  @default_num_acceptors   10
  @default_openflow_port   6633

  def get_callback_module do
    cb_mod = get_config(:callback_module, Tres.ExampleHandler)
    cb_args = get_config(:callback_args, [])
    {cb_mod, cb_args}
  end

  def start_openflow_listener do
    max_connections = get_config(:max_connections, @default_max_connections)
    num_acceptors = get_config(:num_acceptors, @default_num_acceptors)
    port = get_config(:port, @default_openflow_port)
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

  def is_multipart?(message) do
    message.__struct__
    |> Module.split
    |> Enum.at(1)
    |> String.match?(~r/Multipart/)
  end

  def flow_command(:delete, options) do
    if Keyword.get(options, :strict, false) do
      :delete_strict
    else
      :delete
    end
  end
  def flow_command(:modify, options) do
    if Keyword.get(options, :strict, false) do
      :modify_strict
    else
      :modify
    end
  end

  # private functions
  defp get_config(item, default) do
    Application.get_env(:tres, item, default)
  end
end
