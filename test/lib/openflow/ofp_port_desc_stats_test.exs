defmodule OfpPortDescTest do
  use ExUnit.Case

  describe "Openflow.Multipart.PortDesc.Request" do
    test "with default values" do
      desc = Openflow.Multipart.PortDesc.Request.new(0)

      desc
      |> Openflow.to_binary()
      |> Openflow.read()
      |> Kernel.elem(1)
      |> Kernel.==(desc)
      |> assert()
    end
  end

  describe "Openflow.Multipart.PortDesc.Reply" do
    test "with test packet_data" do
      port_desc_stats =
        "test/packet_data/4-54-ofp_port_desc_reply.packet"
        |> File.read!()
        |> Openflow.read()
        |> Kernel.elem(1)

      %Openflow.Multipart.PortDesc.Reply{
        aux_id: nil,
        datapath_id: nil,
        flags: [],
        ports: [
          %Openflow.Port{
            advertised_features: [:copper, :autoneg],
            config: [],
            current_features: [:"100mb_fd", :copper, :autoneg],
            current_speed: 5000,
            hw_addr: "f20ba47df8ea",
            max_speed: 5000,
            name: "Port6",
            number: 6,
            peer_features: [:"100mb_fd", :copper, :autoneg],
            state: [:live],
            supported_features: [:"100mb_fd", :copper, :autoneg]
          },
          %Openflow.Port{
            advertised_features: [:copper, :autoneg],
            config: [],
            current_features: [:"100mb_fd", :copper, :autoneg],
            current_speed: 5000,
            hw_addr: "f20ba4d03f70",
            max_speed: 5000,
            name: "Port7",
            number: 7,
            peer_features: [:"100mb_fd", :copper, :autoneg],
            state: [:live],
            supported_features: [:"100mb_fd", :copper, :autoneg]
          }
        ],
        version: 4,
        xid: 0
      } = port_desc_stats
    end
  end
end
