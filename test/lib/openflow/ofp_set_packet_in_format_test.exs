defmodule OfpSetPacketInFormatTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.to_binary/1" do
    test "with Openflow.SetPacket_In_Format.new/1" do
      packet_in_format =
        "test/packet_data/nx_set_packet_in_format.raw"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      packet_in_format
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Map.to_list()
      |> Openflow.NxSetPacketInFormat.new()
      |> Kernel.==(packet_in_format)
      |> assert()
    end
  end
end
