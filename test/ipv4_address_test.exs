defmodule IPv4AddressTest do
  use ExUnit.Case, async: false

  describe "IPv4Address.parse/1" do
    test "with host(/32) address string" do
      expect = {{192, 168, 10, 1}, {255, 255, 255, 255}}
      ipaddr = "192.168.10.1"
      assert Tres.IPv4Address.parse(ipaddr) == expect
    end

    test "with network(/24) address string" do
      expect = {{192, 168, 10, 0}, {255, 255, 255, 0}}
      ipaddr = "192.168.10.0/24"
      assert Tres.IPv4Address.parse(ipaddr) == expect
    end
  end
end
