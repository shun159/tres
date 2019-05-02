defmodule OfpAggregateTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Aggregate.Request" do
    test "with default values" do
      aggregate =
        %Openflow.Multipart.Aggregate.Request{}
        |> Map.to_list()
        |> Openflow.Multipart.Aggregate.Request.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert aggregate.xid == 0
      assert aggregate.table_id == :all
      assert aggregate.out_port == :any
      assert aggregate.out_group == :any
      assert aggregate.cookie == 0
      assert aggregate.cookie_mask == 0
      assert aggregate.match == []
    end
  end

  describe "Openflow.Multipart.Aggregate.Reply" do
    test "with default values" do
      aggregate =
        %Openflow.Multipart.Aggregate.Reply{}
        |> Map.to_list()
        |> Openflow.Multipart.Aggregate.Reply.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> Kernel.elem(1)

      assert aggregate.xid == 0
      assert aggregate.packet_count == 0
      assert aggregate.byte_count == 0
      assert aggregate.flow_count == 0
    end
  end
end
