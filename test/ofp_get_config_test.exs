defmodule OfpGetConfigTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_GET_CONFIG_REQUEST packet" do
      {:ok, %Openflow.GetConfig.Request{} = config, ""} =
        "test/packet_data/ofp_get_config_request.raw"
        |> File.read!
        |> Openflow.read
      assert config.version == 4
      assert config.xid == 0
    end

    test "with OFP_GET_CONFIG_REPLY packet" do
      {:ok, %Openflow.GetConfig.Reply{} = config, ""} =
        "test/packet_data/ofp_get_config_reply.raw"
        |> File.read!
        |> Openflow.read
      assert config.version == 4
      assert config.xid == 0
      assert config.flags == []
      assert config.miss_send_len == 128
    end
  end

  describe "Openflow.to_binary/1" do
    test "with %Openflow.GetConfig.Request{}" do
      config = %Openflow.GetConfig.Request{
        version: 4,
        xid: 0
      }
      expect =
        "test/packet_data/ofp_get_config_request.raw"
        |> File.read!
      assert Openflow.to_binary(config) == expect
    end

    test "with %Openflow.GetConfig.Reply{}" do
      config = %Openflow.GetConfig.Reply{
        version: 4,
        xid: 0,
        flags: [],
        miss_send_len: 128
      }
      expect =
        "test/packet_data/ofp_get_config_reply.raw"
        |> File.read!
      assert Openflow.to_binary(config) == expect
    end
  end
end
