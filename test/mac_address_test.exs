defmodule MacAddressTest do
  use ExUnit.Case, async: false

  describe "MacAddr.bin_to_str/1" do
    test "with 48 bit binary" do
      mac_bin = <<0x11, 0x22, 0x33, 0x44, 0x55, 0x66>>
      assert Tres.MacAddress.bin_to_str(mac_bin) == "112233445566"
    end
  end

  describe "MacAddr.to_a/1" do
    test "with String" do
      expect = [0x11, 0x22, 0x33, 0x44, 0x55, 0x66]
      assert Tres.MacAddress.to_a("112233445566") == expect
    end
  end

  describe "MacAddr.to_i/1" do
    test "with String" do
      expect = 0x112233445566
      assert Tres.MacAddress.to_i("112233445566") == expect
    end
  end

  describe "MacAddr.broadcast?/1" do
    test "with unicast" do
      mac = "0e2ecad87537"
      refute Tres.MacAddress.is_broadcast?(mac)
    end

    test "with bcast" do
      mac = "ffffffffffff"
      assert Tres.MacAddress.is_broadcast?(mac)
    end
  end

  describe "MacAddr.multicast?/1" do
    test "with unicast" do
      mac = "0e2ecad87537"
      refute Tres.MacAddress.is_multicast?(mac)
    end

    test "with bcast" do
      mac = "ffffffffffff"
      assert Tres.MacAddress.is_multicast?(mac)
    end

    test "with mcast" do
      mac = "ffffffffffff"
      assert Tres.MacAddress.is_multicast?(mac)
    end
  end
end
