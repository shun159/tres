defmodule OfpPortModTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_PORT_MOD packet(1)" do
      binary = File.read!("test/packet_data/4-22-ofp_port_mod.packet")
      {:ok, port_mod, ""} = Openflow.read(binary)

      assert port_mod.version == 4
      assert port_mod.xid == 0
      assert port_mod.number == 1
      assert port_mod.hw_addr == "001100001111"
      assert port_mod.config == []
      assert port_mod.mask == []
      assert port_mod.advertise == [:fiber]
      assert Openflow.to_binary(port_mod) == binary
    end
  end

  test "with OFP_PORT_MOD packet(2)" do
    binary = File.read!("test/packet_data/libofproto-OFP13-port_mod.packet")
    {:ok, port_mod, ""} = Openflow.read(binary)

    assert port_mod.version == 4
    assert port_mod.xid == 0
    assert port_mod.number == 1
    assert port_mod.hw_addr == "aabbcc998877"
    assert port_mod.config == [:port_down]
    assert port_mod.mask == [:port_down]
    assert port_mod.advertise == [:"100mb_fd", :copper, :autoneg]
    assert Openflow.to_binary(port_mod) == binary
  end
end
