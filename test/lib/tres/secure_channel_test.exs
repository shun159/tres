defmodule Tres.SecureChannelTest do
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  @datapath_id "0000000000000004"

  @host 'localhost'
  @port 6653
  @client_opts [:binary, {:packet, 0}, {:active, true}]

  @ofp_hello 0
  @ofp_echo_request 2
  @ofp_features_request 5

  describe "Tres.SecureChannel" do
    test "if hello message sending is slow" do
      {:ok, socket} = connect()
      assert_receive {:tcp, ^socket, <<4::8, @ofp_hello::8, _::binary>>}, 4000
      assert_receive {:tcp_closed, ^socket}, 4000
    end

    test "if ofp_version in the hello message is mismatched" do
      {:ok, socket} = connect()
      assert_receive {:tcp, ^socket, <<4::8, @ofp_hello::8, _::binary>>}, 4000
      :ok = send_msg(socket, Openflow.Hello.new(0x05))
      assert_receive {:tcp_closed, ^socket}, 4000
    end

    test "if feature_reply message sending is slow" do
      {:ok, socket} = connect()
      assert_receive {:tcp, ^socket, <<4::8, @ofp_hello::8, _::binary>>}, 4000
      :ok = send_msg(socket, Openflow.Hello.new(0x04))
      assert_receive {:tcp, ^socket, <<4::8, @ofp_features_request::8, _::binary>>}, 4000
      assert_receive {:tcp_closed, ^socket}, 4000
    end

    test "if the datapath didn't reply to the ping from controller" do
      {:ok, socket} = connect()
      assert_receive {:tcp, ^socket, <<4::8, @ofp_hello::8, _::binary>>}, 4000
      :ok = send_msg(socket, Openflow.Hello.new(0x04))
      assert_receive {:tcp, ^socket, <<4::8, @ofp_features_request::8, _::binary>>}, 4000
      :ok = send_msg(socket, %Openflow.Features.Reply{datapath_id: @datapath_id})

      # Idle check running after 5sec
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000

      # Controller tries ping to the datapath per five seconds
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp, ^socket, <<4::8, @ofp_echo_request::8, _::binary>>}, 6000
      assert_receive {:tcp_closed, ^socket}, 60_000
    end

    test "if the main connection down" do
      # Main connection
      {:ok, socket_main} = connect()
      assert_receive {:tcp, ^socket_main, <<4::8, @ofp_hello::8, _::binary>>}, 4000
      :ok = send_msg(socket_main, Openflow.Hello.new(0x04))
      assert_receive {:tcp, ^socket_main, <<4::8, @ofp_features_request::8, _::binary>>}, 4000
      :ok = send_msg(socket_main, %Openflow.Features.Reply{datapath_id: @datapath_id})

      # Aux connection(id: 1)
      {:ok, socket_aux} = connect()
      assert_receive {:tcp, ^socket_aux, <<4::8, @ofp_hello::8, _::binary>>}, 4000
      :ok = send_msg(socket_aux, Openflow.Hello.new(0x04))
      assert_receive {:tcp, ^socket_aux, <<4::8, @ofp_features_request::8, _::binary>>}, 4000
      :ok = send_msg(socket_aux, %Openflow.Features.Reply{datapath_id: @datapath_id, aux_id: 1})

      # Close the main connection
      :ok = :gen_tcp.close(socket_main)

      # We expect that the aux connection was closed
      assert_receive {:tcp_closed, ^socket_aux}, 60_000
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
