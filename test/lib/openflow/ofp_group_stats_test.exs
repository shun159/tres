defmodule OfpGroupStatsTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Group.Request" do
    test "with default values" do
      group_stats =
        %Openflow.Multipart.Group.Request{}
        |> Map.to_list()
        |> Openflow.Multipart.Group.Request.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert group_stats.xid == 0
      assert group_stats.group_id == :all
    end
  end

  describe "Openflow.Multipart.Group.Reply" do
    test "with test packet_data" do
      group_stats =
        "test/packet_data/4-58-ofp_group_stats_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.Group.Reply{
        aux_id: nil,
        datapath_id: nil,
        flags: [],
        groups: [
          %Openflow.Multipart.GroupStats{
            bucket_stats: [%{byte_count: 2345, packet_count: 234}],
            byte_count: 12345,
            duration_nsec: 609_036_000,
            duration_sec: 9,
            group_id: 1,
            packet_count: 123,
            ref_count: 2
          }
        ],
        version: 4,
        xid: 0
      } = group_stats
    end
  end
end
