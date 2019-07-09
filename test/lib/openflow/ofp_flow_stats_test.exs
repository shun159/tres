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

  describe "Openflow.Multipart.Flow.Reply" do
    test "with test packet_data" do
      flow_stats =
        "test/packet_data/4-12-ofp_flow_stats_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.Flow.Reply{
        aux_id: nil,
        datapath_id: nil,
        flags: [],
        flows: [
          %Openflow.Multipart.FlowStats{
            byte_count: 0,
            cookie: 0,
            duration_nsec: 115_277_000,
            duration_sec: 358,
            flags: [],
            hard_timeout: 0,
            idle_timeout: 0,
            instructions: [],
            match: [],
            packet_count: 0,
            priority: 65535,
            table_id: 0
          },
          %Openflow.Multipart.FlowStats{
            byte_count: 0,
            cookie: 0,
            duration_nsec: 115_055_000,
            duration_sec: 358,
            flags: [],
            hard_timeout: 0,
            idle_timeout: 0,
            instructions: [
              %Openflow.Instruction.ApplyActions{
                actions: [%Openflow.Action.Output{max_len: 0, port_number: :normal}]
              }
            ],
            match: [eth_type: 2054],
            packet_count: 0,
            priority: 65534,
            table_id: 0
          },
          %Openflow.Multipart.FlowStats{
            byte_count: 238,
            cookie: 0,
            duration_nsec: 511_582_000,
            duration_sec: 316_220,
            flags: [],
            hard_timeout: 0,
            idle_timeout: 0,
            instructions: [%Openflow.Instruction.GotoTable{table_id: 1}],
            match: [in_port: 6, eth_src: <<0xF20BA47DF8EA::48>>],
            packet_count: 3,
            priority: 123,
            table_id: 0
          },
          %Openflow.Multipart.FlowStats{
            byte_count: 98,
            cookie: 0,
            duration_nsec: 980_901_000,
            duration_sec: 313_499,
            flags: [],
            hard_timeout: 0,
            idle_timeout: 0,
            instructions: [
              %Openflow.Instruction.WriteActions{
                actions: [
                  %Openflow.Action.SetField{field: [vlan_vid: 258]},
                  %Openflow.Action.CopyTtlOut{},
                  %Openflow.Action.CopyTtlIn{},
                  %Openflow.Action.CopyTtlIn{},
                  %Openflow.Action.PopPbb{},
                  %Openflow.Action.PushPbb{ethertype: 4660},
                  %Openflow.Action.PopMpls{ethertype: 39030},
                  %Openflow.Action.PushMpls{ethertype: 34887},
                  %Openflow.Action.PopVlan{},
                  %Openflow.Action.PushVlan{ethertype: 33024},
                  %Openflow.Action.DecMplsTtl{},
                  %Openflow.Action.SetMplsTtl{ttl: 10},
                  %Openflow.Action.DecNwTtl{},
                  %Openflow.Action.SetNwTtl{ttl: 10},
                  %Openflow.Action.SetQueue{id: 3},
                  %Openflow.Action.Group{id: 99},
                  %Openflow.Action.Output{max_len: :no_buffer, port_number: 6},
                  %Openflow.Action.Experimenter{data: "exp_data", exp_id: 98_765_432},
                  %Openflow.Action.Experimenter{data: "exp_data", exp_id: 8992}
                ]
              },
              %Openflow.Instruction.ApplyActions{
                actions: [
                  %Openflow.Action.SetField{field: [eth_src: <<0x010203040506::48>>]},
                  %Openflow.Action.SetField{field: [onf_pbb_uca: 1]}
                ]
              },
              %Openflow.Instruction.WriteActions{
                actions: [
                  %Openflow.Action.Output{
                    max_len: :no_buffer,
                    port_number: :controller
                  }
                ]
              }
            ],
            match: [],
            packet_count: 1,
            priority: 0,
            table_id: 0
          }
        ],
        version: 4,
        xid: 0
      } = flow_stats
    end
  end
end
