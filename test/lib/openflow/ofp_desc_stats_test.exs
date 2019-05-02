defmodule OfpDescTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Desc.Request" do
    test "with default values" do
      desc = Openflow.Multipart.Desc.Request.new(0)

      desc
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(desc)
      |> assert()
    end
  end

  describe "Openflow.Multipart.Desc.Reply" do
    test "with default values" do
      desc =
        %Openflow.Multipart.Desc.Reply{
          dp_desc: "None",
          hw_desc: "Open vSwitch",
          mfr_desc: "Nicira, Inc.",
          serial_num: "None",
          sw_desc: "2.11.0"
        }
        |> Map.to_list()
        |> Openflow.Multipart.Desc.Reply.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert desc.xid == 0
      assert desc.mfr_desc == "Nicira, Inc."
      assert desc.dp_desc == "None"
      assert desc.hw_desc == "Open vSwitch"
      assert desc.sw_desc == "2.11.0"
      assert desc.serial_num == "None"
    end
  end
end
