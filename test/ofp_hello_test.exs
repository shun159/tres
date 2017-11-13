defmodule OfpHelloTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_HELLO packet" do
      {:ok, hello, ""} =
        "test/packet_data/ofp_hello.raw"
        |> File.read!
        |> Openflow.read
      assert hello.version == 4
      assert hello.xid == 0
      assert hello.elements == [versionbitmap: [30, 10, 9, 3, 2, 1]]
    end
  end

  describe "Openflow.to_binary/1" do
    test "with %Openflow.Hello{}" do
      hello = Openflow.Hello.new([30, 10, 9, 3, 2, 1])
      expect =
        "test/packet_data/ofp_hello.raw"
        |> File.read!
      assert Openflow.to_binary(hello) == expect
    end
  end
end
