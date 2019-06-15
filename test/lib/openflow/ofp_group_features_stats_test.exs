defmodule OfpGroupFeaturesTest do
  use ExUnit.Case

  describe "Openflow.Multipart.GroupFeatures.Request" do
    test "with default values" do
      features = Openflow.Multipart.GroupFeatures.Request.new(0)

      features
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(features)
      |> assert()
    end
  end

  describe "Openflow.Multipart.GroupFeatures.Reply" do
    test "with test packet_data" do
      group_features_stats =
        "test/packet_data/4-32-ofp_group_features_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.GroupFeatures.Reply{
        actions_for_all: [
          Openflow.Action.Output,
          Openflow.Action.CopyTtlOut,
          Openflow.Action.CopyTtlIn,
          Openflow.Action.SetMplsTtl,
          Openflow.Action.DecMplsTtl,
          Openflow.Action.PushVlan,
          Openflow.Action.PopVlan,
          Openflow.Action.PushMpls,
          Openflow.Action.PopMpls,
          Openflow.Action.SetQueue,
          Openflow.Action.Group,
          Openflow.Action.SetNwTtl,
          Openflow.Action.DecNwTtl,
          Openflow.Action.SetField
        ],
        actions_for_fast_failover: [
          Openflow.Action.Output,
          Openflow.Action.CopyTtlOut,
          Openflow.Action.CopyTtlIn,
          Openflow.Action.SetMplsTtl,
          Openflow.Action.DecMplsTtl,
          Openflow.Action.PushVlan,
          Openflow.Action.PopVlan,
          Openflow.Action.PushMpls,
          Openflow.Action.PopMpls,
          Openflow.Action.SetQueue,
          Openflow.Action.Group,
          Openflow.Action.SetNwTtl,
          Openflow.Action.DecNwTtl,
          Openflow.Action.SetField
        ],
        actions_for_indirect: [
          Openflow.Action.Output,
          Openflow.Action.CopyTtlOut,
          Openflow.Action.CopyTtlIn,
          Openflow.Action.SetMplsTtl,
          Openflow.Action.DecMplsTtl,
          Openflow.Action.PushVlan,
          Openflow.Action.PopVlan,
          Openflow.Action.PushMpls,
          Openflow.Action.PopMpls,
          Openflow.Action.SetQueue,
          Openflow.Action.Group,
          Openflow.Action.SetNwTtl,
          Openflow.Action.DecNwTtl,
          Openflow.Action.SetField
        ],
        actions_for_select: [
          Openflow.Action.Output,
          Openflow.Action.CopyTtlOut,
          Openflow.Action.CopyTtlIn,
          Openflow.Action.SetMplsTtl,
          Openflow.Action.DecMplsTtl,
          Openflow.Action.PushVlan,
          Openflow.Action.PopVlan,
          Openflow.Action.PushMpls,
          Openflow.Action.PopMpls,
          Openflow.Action.SetQueue,
          Openflow.Action.Group,
          Openflow.Action.SetNwTtl,
          Openflow.Action.DecNwTtl,
          Openflow.Action.SetField
        ],
        aux_id: nil,
        capabilities: [:select_weight, :chaining],
        datapath_id: nil,
        flags: [],
        max_groups_for_all: 16_777_216,
        max_groups_for_fast_failover: 16_777_216,
        max_groups_for_indirect: 16_777_216,
        max_groups_for_select: 16_777_216,
        types: [:all, :select, :indirect, :fast_failover],
        version: 4,
        xid: 0
      } = group_features_stats
    end
  end
end
