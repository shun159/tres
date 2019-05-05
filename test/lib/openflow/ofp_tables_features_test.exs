defmodule OfpTableFeaturesTest do
  use ExUnit.Case

  describe "Openflow.Multipart.Table.Request" do
    test "with default values" do
      table_features =
        "test/packet_data/4-55-ofp_table_features_request.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      table_features
      |> Map.to_list()
      |> Openflow.Multipart.TableFeatures.Request.new()
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(table_features)
      |> assert()
    end
  end

  describe "Openflow.Multipart.Table.Reply" do
    test "with default values" do
      "test/packet_data/4-56-ofp_table_features_reply.packet"
      |> File.read!()
      |> Openflow.read()
      |> Kernel.elem(1)
    end
  end
end
