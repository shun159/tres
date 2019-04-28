defmodule OfpGroupModTest do
  use ExUnit.Case
  doctest Openflow

  describe "Openflow.read/1" do
    test "with OFP_GROUP_MOD packet" do
      binary = File.read!("test/packet_data/4-21-ofp_group_mod.packet")
      {:ok, _group_mod, ""} = Openflow.read(binary)

      group_mod =
        binary
        |> Openflow.read()
        |> elem(1)
        |> Map.to_list()
        |> Openflow.GroupMod.new()
        |> Openflow.to_binary()
        |> Openflow.read()
        |> elem(1)

      assert group_mod.version == 4
      assert group_mod.xid == 0
      assert group_mod.command == :add
      assert group_mod.type == :all
      assert group_mod.group_id == 1

      assert group_mod.buckets == [
               Openflow.Bucket.new(
                 weight: 1,
                 watch_port: 1,
                 watch_group: 1,
                 actions: [Openflow.Action.Output.new(2)]
               )
             ]

      assert Openflow.to_binary(group_mod) == binary
    end
  end
end
