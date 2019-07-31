defmodule OfpFlowStatsTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Flow.Request" do
    test "with default values" do
      flow_stats =
        %Openflow.Multipart.Flow.Request{}
        |> Map.to_list()
        |> Openflow.Multipart.Flow.Request.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert flow_stats.xid == 0
      assert flow_stats.table_id == :all
      assert flow_stats.out_port == :any
      assert flow_stats.out_group == :any
      assert flow_stats.cookie == 0
      assert flow_stats.cookie_mask == 0
      assert flow_stats.match == []
    end
  end
end
