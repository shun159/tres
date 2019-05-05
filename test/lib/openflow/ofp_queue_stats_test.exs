defmodule OfpQueueStatsTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Queue.Request" do
    test "with default values" do
      queue_stats =
        %Openflow.Multipart.Queue.Request{}
        |> Map.to_list()
        |> Openflow.Multipart.Queue.Request.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert queue_stats.xid == 0
      assert queue_stats.port_number == :any
      assert queue_stats.queue_id == :all
    end
  end

  describe "Openflow.Multipart.Queue.Reply" do
    test "with test packet_data" do
      queue_stats =
        "test/packet_data/4-38-ofp_queue_stats_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.Queue.Reply{
        aux_id: nil,
        datapath_id: nil,
        flags: [],
        queues: [
          %Openflow.Multipart.QueueStats{
            duration_nsec: 0,
            duration_sec: 0,
            port_number: 7,
            queue_id: 1,
            tx_bytes: 0,
            tx_errors: 0,
            tx_packets: 0
          },
          %Openflow.Multipart.QueueStats{
            duration_nsec: 0,
            duration_sec: 0,
            port_number: 6,
            queue_id: 1,
            tx_bytes: 0,
            tx_errors: 0,
            tx_packets: 0
          },
          %Openflow.Multipart.QueueStats{
            duration_nsec: 0,
            duration_sec: 0,
            port_number: 7,
            queue_id: 2,
            tx_bytes: 0,
            tx_errors: 0,
            tx_packets: 0
          }
        ],
        version: 4,
        xid: 0
      } = queue_stats
    end
  end
end
