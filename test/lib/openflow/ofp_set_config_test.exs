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

    test "with a flag option" do
      binary = <<0x04, 0x09, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x0d, 0x00, 0x02, 0xff, 0xe5>>

      set_config =
        binary
        |> Openflow.read()
        |> Kernel.elem(1)

      assert set_config.version == 4
      assert set_config.xid == 13
      assert set_config.flags == [:fragment_reassemble]
      assert set_config.miss_send_len == :max
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

    test "with a flag option" do
      binary = <<0x04, 0x09, 0x00, 0x0c, 0x00, 0x00, 0x00, 0x0d, 0x00, 0x02, 0xff, 0xe5>>
      set_config = Openflow.SetConfig.new(xid: 13, flags: [:fragment_reassemble], miss_send_len: :max)
      ^binary = Openflow.to_binary(set_config)
    end
  end
end
