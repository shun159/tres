defmodule Tres.SecureChannelTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  @datapath_id "0000000000000001"

  @host 'localhost'
  @port 6653
  @client_opts [:binary, {:packet, 0}]

  describe "Tres.SecureChannel" do
    test "if hello message sending is slow" do
      {:ok, socket} = connect()
      _ = :gen_tcp.recv(socket, 0)

      fn -> Process.sleep(4000) end
      |> capture_log()
      |> Kernel.=~("connection terminated: Hello handshake timed out")
      |> assert()

      _ = :gen_tcp.close(socket)
    end
  end

  # Helper

  defp connect do
    {:ok, _socket} = :gen_tcp.connect(@host, @port, @client_opts)
  end

  defp close(socket) do
    :ok = :gen_tcp.close(socket)
  end

  defp send_msg(socket, msg) do
    :ok = :gen_tcp.send(socket, Openflow.to_binary(msg))
  end
end
