defmodule OfpMeterModTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.MeterMod" do
    test "with packet_data" do
      meter_mod =
        "test/packet_data/libofproto-OFP13-meter_mod.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)
        |> Map.to_list()
        |> Openflow.MeterMod.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      expect =
        Openflow.MeterMod.new(
          xid: 0,
          meter_id: 100,
          command: :add,
          flags: [:pktps, :burst, :stats],
          bands: [
            Openflow.MeterBand.Drop.new(
              burst_size: 10,
              rate: 1000
            ),
            Openflow.MeterBand.Remark.new(
              burst_size: 10,
              prec_level: 1,
              rate: 1000
            )
          ]
        )

      assert expect.xid == meter_mod.xid
      assert expect.meter_id == meter_mod.meter_id
      assert expect.command == meter_mod.command
      assert expect.flags == meter_mod.flags
      assert expect.bands == meter_mod.bands
    end
  end
end
