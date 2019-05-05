defmodule OfpPortStatsTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Port.Request" do
    test "with default values" do
      port_stats =
        %Openflow.Multipart.Port.Request{}
        |> Map.to_list()
        |> Openflow.Multipart.Port.Request.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert port_stats.xid == 0
      assert port_stats.port_number == :any
    end
  end

  describe "Openflow.Multipart.Port.Reply" do
    test "with test packet_data" do
      port_stats =
        "test/packet_data/4-30-ofp_port_stats_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.Port.Reply{
        aux_id: nil,
        datapath_id: nil,
        flags: [],
        ports: [
          %Openflow.Multipart.PortStats{
            collisions: 0,
            duration_nsec: 0,
            duration_sec: 0,
            port_number: 7,
            rx_bytes: 0,
            rx_crc_err: 0,
            rx_dropped: 0,
            rx_errors: 0,
            rx_frame_err: 0,
            rx_over_err: 0,
            rx_packets: 0,
            tx_bytes: 336,
            tx_dropped: 0,
            tx_errors: 0,
            tx_packets: 4
          },
          %Openflow.Multipart.PortStats{
            collisions: 0,
            duration_nsec: 0,
            duration_sec: 0,
            port_number: 6,
            rx_bytes: 336,
            rx_crc_err: 0,
            rx_dropped: 0,
            rx_errors: 0,
            rx_frame_err: 0,
            rx_over_err: 0,
            rx_packets: 4,
            tx_bytes: 336,
            tx_dropped: 0,
            tx_errors: 0,
            tx_packets: 4
          }
        ],
        version: 4,
        xid: 0
      } = port_stats
    end
  end
end
