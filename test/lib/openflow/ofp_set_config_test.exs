defmodule OfpSetConfigTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_SET_CONFIG packet" do
      {:ok, %Openflow.SetConfig{} = config, ""} =
        "test/packet_data/ofp_set_config.raw"
        |> File.read!()
        |> Openflow.read()

      assert config.version == 4
      assert config.xid == 0
      assert config.flags == []
      assert config.miss_send_len == 128
    end
  end

  describe "Openflow.to_binary/1" do
    test "with %Openflow.SetConfig{}" do
      config = %Openflow.SetConfig{
        version: 4,
        xid: 0,
        flags: [],
        miss_send_len: 128
      }

      expect =
        "test/packet_data/ofp_set_config.raw"
        |> File.read!()

      assert Openflow.to_binary(config) == expect
    end
  end
end
