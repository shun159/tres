defmodule OfpTableModTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_TABLE_MOD packet(1)" do
      binary = File.read!("test/packet_data/libofproto-OFP13-table_mod.packet")
      {:ok, table_mod, ""} = Openflow.read(binary)

      assert table_mod.version == 4
      assert table_mod.xid == 0
      assert table_mod.table_id == :all
      assert table_mod.config == 0
      assert Openflow.to_binary(table_mod) == binary
    end
  end

  test "with OFP_TABLE_MOD packet(2)" do
    binary = File.read!("test/packet_data/4-23-ofp_table_mod.packet")
    {:ok, table_mod, ""} = Openflow.read(binary)

    assert table_mod.version == 4
    assert table_mod.xid == 0
    assert table_mod.table_id == :all
    assert table_mod.config == 0
    assert Openflow.to_binary(table_mod) == binary
  end
end
