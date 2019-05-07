defmodule Tres.HanderTest do
  use ExUnit.Case

  @datapath_id "0000000000000001"

  setup_all do
    :ok = wait_datapath_is_connected()
    :ok = send_message(Openflow.FlowMod.new(command: :delete, table_id: :all))
    :ok = send_message(Openflow.GroupMod.new(command: :delete, group_id: :all))
    :ok = send_message(Openflow.MeterMod.new(command: :delete, meter_id: :all))
  end

  describe "Openflow RoleRequest message" do
    test "with role and generation_id" do
      send_message(Openflow.Role.Request.new(role: :nochange, generation_id: 1))
      %Openflow.Role.Reply{} = get_message()
    end
  end

  describe "Openflow standard PacketIn message" do
    test "with arp_packet" do
      send_message(
        Openflow.PacketOut.new(
          buffer_id: :no_buffer,
          in_port: :controller,
          actions: [Openflow.Action.Output.new(:controller)],
          data: File.read!("test/packet_data/arp_packet.raw")
        )
      )

      %Openflow.PacketIn{} = get_message()
    end
  end

  describe "Openflow Nicira PacketIn2 message" do
    test "with arp_packet" do
      send_message(Openflow.NxSetPacketInFormat.new(:nxt_packet_in2))

      send_message(
        Openflow.FlowMod.new(
          instructions: Openflow.Instruction.ApplyActions.new(Openflow.Action.NxController2.new())
        )
      )

      send_message(
        Openflow.PacketOut.new(
          buffer_id: :no_buffer,
          in_port: :controller,
          actions: [Openflow.Action.Output.new(:controller)],
          data: File.read!("test/packet_data/arp_packet.raw")
        )
      )

      %Openflow.NxPacketIn2{} = get_message()
    end
  end

  describe "Openflow FlowRemoved message" do
    test "with a flow" do
      send_message(
        Openflow.FlowMod.new(flags: [:send_flow_rem], match: Openflow.Match.new(reg0: 99))
      )

      send_message(Openflow.FlowMod.new(command: :delete, match: Openflow.Match.new(reg0: 99)))
      %Openflow.FlowRemoved{} = get_message()
    end
  end

  describe "Openflow AggregateStats Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.Aggregate.Request.new())
      %Openflow.Multipart.Aggregate.Reply{} = get_message()
    end
  end

  describe "Openflow DescStats Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.Desc.Request.new())
      %Openflow.Multipart.Desc.Reply{} = get_message()
    end
  end

  describe "Openflow FlowStats Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.Flow.Request.new())
      %Openflow.Multipart.Flow.Reply{} = get_message()
    end

    test "with 3000 flows" do
      Enum.each(1..3000, fn n ->
        send_message(Openflow.FlowMod.new(match: Openflow.Match.new(reg0: n)))
      end)

      send_message(Openflow.Multipart.Flow.Request.new())
      %Openflow.Multipart.Flow.Reply{flags: [:more]} = get_message()
    end
  end

  describe "Openflow GroupStats Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.Group.Request.new())
      %Openflow.Multipart.Group.Reply{} = get_message()
    end

    test "with 3000 groups" do
      Enum.each(1..3000, fn n -> send_message(Openflow.GroupMod.new(group_id: n)) end)
      send_message(Openflow.Multipart.Group.Request.new())
      %Openflow.Multipart.Group.Reply{flags: [:more]} = get_message()
    end
  end

  describe "Openflow GroupDesc Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.GroupDesc.Request.new())
      %Openflow.Multipart.GroupDesc.Reply{} = get_message()
    end
  end

  describe "Openflow GroupFeatures Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.GroupFeatures.Request.new())
      %Openflow.Multipart.GroupFeatures.Reply{} = get_message()
    end
  end

  describe "Openflow MeterStats Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.Meter.Request.new())
      %Openflow.Multipart.Meter.Reply{} = get_message()
    end

    test "with 3000 meters" do
      Enum.each(1..3000, fn n ->
        send_message(
          Openflow.MeterMod.new(
            meter_id: n,
            flags: [:pktps, :burst, :stats],
            bands: [Openflow.MeterBand.Drop.new(rate: 1000, burst_size: 10)]
          )
        )
      end)

      send_message(Openflow.Multipart.Meter.Request.new())
      %Openflow.Multipart.Meter.Reply{flags: [:more]} = get_message()
    end
  end

  describe "Openflow PortDescStats Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.PortDesc.Request.new())
      %Openflow.Multipart.PortDesc.Reply{} = get_message()
    end
  end

  describe "Openflow PortStats Reply message" do
    test "with no option" do
      send_message(Openflow.Multipart.Port.Request.new())
      %Openflow.Multipart.Port.Reply{} = get_message()
    end
  end

  # helper

  def wait_datapath_is_connected do
    case Tres.SwitchRegistry.lookup_handler_pid(@datapath_id) do
      nil -> wait_datapath_is_connected()
      pid when is_pid(pid) -> :ok
    end
  end

  def send_message(msg) do
    :ok = Tres.ExampleHandler.send(@datapath_id, msg)
  end

  def get_message do
    Tres.ExampleHandler.get(@datapath_id)
  end
end
