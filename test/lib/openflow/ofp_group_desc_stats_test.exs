defmodule OfpGroupDescTest do
  use ExUnit.Case

  describe "Openflow.Multipart.GroupDesc.Request" do
    test "with default values" do
      desc = Openflow.Multipart.GroupDesc.Request.new(0)

      desc
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(desc)
      |> assert()
    end
  end

  describe "Openflow.Multipart.GroupDesc.Reply" do
    test "with test packet_data" do
      group_desc_stats =
        "test/packet_data/4-34-ofp_group_desc_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.GroupDesc.Reply{
        aux_id: nil,
        datapath_id: nil,
        flags: [],
        groups: [
          %Openflow.Multipart.GroupDescStats{
            buckets: [
              %Openflow.Bucket{
                actions: [
                  %Openflow.Action.Output{max_len: :no_buffer, port_number: 2}
                ],
                watch_group: 1,
                watch_port: 1,
                weight: 1
              }
            ],
            group_id: 1,
            type: :all
          }
        ],
        version: 4,
        xid: 0
      } = group_desc_stats
    end
  end
end
