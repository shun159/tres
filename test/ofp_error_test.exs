defmodule OfpErrorTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_ERROR packet" do
      {:ok, error, ""} =
        "test/packet_data/ofp_error.raw"
        |> File.read!()
        |> Openflow.read()

      assert error.version == 4
      assert error.xid == 0
      assert error.type == :bad_action
      assert error.code == :unsupported_order
      assert error.data == "fugafuga"
    end
  end

  describe "Openflow.to_binary/1" do
    test "with %Openflow.Error{}" do
      error = %Openflow.ErrorMsg{
        version: 4,
        xid: 0,
        type: :bad_action,
        code: :unsupported_order,
        data: "fugafuga"
      }

      expect =
        "test/packet_data/ofp_error.raw"
        |> File.read!()

      assert Openflow.to_binary(error) == expect
    end

    test "with experimenter %Openflow.Error{}" do
      error = %Openflow.ErrorMsg{
        version: 4,
        xid: 0,
        type: :experimenter,
        exp_type: 1,
        experimenter: 0xDEADBEEF,
        data: "hogehoge"
      }

      expect = <<
        4,
        1,
        0,
        24,
        0,
        0,
        0,
        0,
        255,
        255,
        0,
        1,
        222,
        173,
        190,
        239,
        104,
        111,
        103,
        101,
        104,
        111,
        103,
        101
      >>

      assert Openflow.to_binary(error) == expect
    end
  end
end
