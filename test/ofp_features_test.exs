defmodule OfpFeaturesTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_FEATURES_REQUEST packet" do
      {:ok, %Openflow.Features.Request{} = features, ""} =
        "test/packet_data/ofp_features_request.raw"
        |> File.read!()
        |> Openflow.read()

      assert features.version == 4
      assert features.xid == 0
    end

    test "with OFP_FEATURES_REPLY packet" do
      {:ok, %Openflow.Features.Reply{} = features, ""} =
        "test/packet_data/ofp_features_reply.raw"
        |> File.read!()
        |> Openflow.read()

      assert features.version == 4
      assert features.xid == 0
      assert features.datapath_id == "0000000000000001"
      assert features.n_buffers == 255
      assert features.n_tables == 255
      assert features.aux_id == 0

      assert features.capabilities == [
               :flow_stats,
               :table_stats,
               :port_stats,
               :group_stats,
               :queue_stats
             ]
    end
  end

  describe "Openflow.to_binary/1" do
    test "with %Openflow.Features.Request{}" do
      features = %Openflow.Features.Request{
        version: 4,
        xid: 0
      }

      expect =
        "test/packet_data/ofp_features_request.raw"
        |> File.read!()

      assert Openflow.to_binary(features) == expect
    end
  end

  test "with %Openflow.Features.Reply{}" do
    features = %Openflow.Features.Reply{
      version: 4,
      xid: 0,
      datapath_id: "0000000000000001",
      n_buffers: 255,
      n_tables: 255,
      aux_id: 0,
      capabilities: [:flow_stats, :table_stats, :port_stats, :group_stats, :queue_stats]
    }

    expect =
      "test/packet_data/ofp_features_reply.raw"
      |> File.read!()

    assert Openflow.to_binary(features) == expect
  end
end
