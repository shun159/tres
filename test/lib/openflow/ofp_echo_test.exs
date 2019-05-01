defmodule OfpEchoTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.Echo.Request" do
    test "with xid and data options" do
      echo = Openflow.Echo.Request.new(xid: 1, data: "echo")

      echo
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(echo)
      |> assert()
    end

    test "with data options" do
      echo = Openflow.Echo.Request.new("echo")

      echo
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(echo)
      |> assert()
    end
  end

  describe "Openflow.Echo.Reply" do
    test "with xid and data options" do
      echo = Openflow.Echo.Reply.new(xid: 1, data: "echo")

      echo
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(echo)
      |> assert()
    end

    test "with data options" do
      echo = Openflow.Echo.Reply.new("echo")

      echo
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(echo)
      |> assert()
    end
  end

  describe "Openflow.read/1" do
    test "with OFP_ECHO_REQUEST packet" do
      {:ok, %Openflow.Echo.Request{} = echo, ""} =
        "test/packet_data/ofp_echo_request.raw"
        |> File.read!()
        |> Openflow.read()

      expect = Openflow.Echo.Request.new()

      assert echo.version == expect.version
      assert echo.xid == expect.xid
      assert echo.data == expect.data
    end

    test "with OFP_ECHO_REPLY packet" do
      {:ok, %Openflow.Echo.Reply{} = echo, ""} =
        "test/packet_data/ofp_echo_reply.raw"
        |> File.read!()
        |> Openflow.read()

      expect = Openflow.Echo.Reply.new()

      assert echo.version == expect.version
      assert echo.xid == expect.xid
      assert echo.data == expect.data
    end
  end

  describe "Openflow.to_binary/1" do
    test "with %Openflow.Echo.Request{}" do
      echo = %Openflow.Echo.Request{
        version: 4,
        xid: 0,
        data: ""
      }

      expect =
        "test/packet_data/ofp_echo_request.raw"
        |> File.read!()

      assert Openflow.to_binary(echo) == expect
    end

    test "with %Openflow.Echo.Reply{}" do
      echo = %Openflow.Echo.Reply{
        version: 4,
        xid: 0,
        data: ""
      }

      expect =
        "test/packet_data/ofp_echo_reply.raw"
        |> File.read!()

      assert Openflow.to_binary(echo) == expect
    end
  end
end
