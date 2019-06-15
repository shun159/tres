defmodule OfpMeterStatsTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Meter.Request" do
    test "with default values" do
      meter_stats =
        %Openflow.Multipart.Meter.Request{}
        |> Map.to_list()
        |> Openflow.Multipart.Meter.Request.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert meter_stats.xid == 0
      assert meter_stats.meter_id == :all
    end
  end

  describe "Openflow.Multipart.Meter.Reply" do
    test "with test packet_data" do
      meter_stats =
        "test/packet_data/4-50-ofp_meter_stats_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.Meter.Reply{
        aux_id: nil,
        datapath_id: nil,
        flags: [],
        meters: [
          %Openflow.Multipart.Meter{
            band_stats: [%{byte_band_count: 0, packet_band_count: 0}],
            byte_in_count: 0,
            duration_nsec: 480_000,
            duration_sec: 0,
            flow_count: 0,
            meter_id: 100,
            packet_in_count: 0
          }
        ],
        version: 4,
        xid: 0
      } = meter_stats
    end
  end
end
