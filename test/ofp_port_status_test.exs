defmodule OfpPortStatusTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_PORT_STATUS packet" do
      {:ok, port_status, ""} =
        "test/packet_data/libofproto-OFP13-port_status.packet"
        |> File.read!
        |> Openflow.read

      assert port_status.version == 4
      assert port_status.xid == 0
      assert port_status.reason == :modify
      assert port_status.port.number == 1
      assert port_status.port.hw_addr == "ffffffffffff"
      assert port_status.port.name == "eth0"
      assert port_status.port.config == []
      assert port_status.port.state == [:live]
      assert port_status.port.current_features == [:"100mb_fd", :copper, :autoneg]
      assert port_status.port.advertised_features == [:"100mb_fd", :copper, :autoneg]
      assert port_status.port.peer_features == [:"100mb_fd", :copper, :autoneg]
      assert port_status.port.current_speed == 50_000
      assert port_status.port.max_speed == 100_000
    end

    test "with OFP_PORT_STATUS packet(with kanji port name)" do
      {:ok, port_status, ""} =
        "test/packet_data/4-39-ofp_port_status.packet"
        |> File.read!
        |> Openflow.read

      assert port_status.version == 4
      assert port_status.xid == 0
      assert port_status.reason == :add
      assert port_status.port.number == 7
      assert port_status.port.hw_addr == "f20ba4d03f70"
      assert port_status.port.name == "私のポート"
      assert port_status.port.config == []
      assert port_status.port.state == [:live]
      assert port_status.port.current_features == [:"100mb_fd", :copper, :autoneg]
      assert port_status.port.advertised_features == [:copper, :autoneg]
      assert port_status.port.peer_features == [:"100mb_fd", :copper, :autoneg]
      assert port_status.port.current_speed == 5_000
      assert port_status.port.max_speed == 5_000
    end
  end
end
