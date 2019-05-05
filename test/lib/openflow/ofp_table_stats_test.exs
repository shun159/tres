defmodule OfpTableStatsTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Table.Request" do
    test "with default values" do
      table_stats =
        %Openflow.Multipart.Table.Request{}
        |> Map.to_list()
        |> Openflow.Multipart.Table.Request.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert table_stats.xid == 0
    end
  end

  describe "Openflow.Multipart.Table.Reply" do
    test "with test packet_data" do
      table_stats =
        "test/packet_data/4-28-ofp_table_stats_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.Table.Reply{
        aux_id: nil,
        datapath_id: nil,
        flags: [],
        tables: [
          %Openflow.Multipart.TableStats{
            active_count: 4,
            lookup_count: 4,
            matched_count: 4,
            table_id: 0
          },
          %Openflow.Multipart.TableStats{
            active_count: 4,
            lookup_count: 4,
            matched_count: 4,
            table_id: 1
          }
        ],
        version: 4,
        xid: 0
      } = table_stats
    end
  end
end
