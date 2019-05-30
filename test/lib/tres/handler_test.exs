defmodule Tres.HanderTest do
  use ExUnit.Case, async: false

  @datapath_id "0000000000000001"

  setup_all do
    :ok = wait_datapath_is_connected()
    :ok = send_message(Openflow.FlowMod.new(command: :delete, table_id: :all))
    :ok = send_message(Openflow.GroupMod.new(command: :delete, group_id: :all))
    :ok = send_message(Openflow.MeterMod.new(command: :delete, meter_id: :all))
  end

  describe "Openflow RoleRequest message" do
    test "with role and generation_id" do
      {:ok, %Openflow.Role.Reply{}} =
        sync_send_message(Openflow.Role.Request.new(role: :nochange, generation_id: 1))
    end
  end

  describe "Openflow TableMod message" do
    test "with table_id" do
      {:ok, :noreply} = sync_send_message(Openflow.TableMod.new(table_id: :all))
    end
  end

  describe "Openflow NxSetControllerId message" do
    test "with controller_id" do
      {:ok, :noreply} = sync_send_message(Openflow.NxSetControllerId.new(0))
    end
  end

  describe "Openflow Error message" do
    test "with a flow" do
      send_message(Openflow.FlowMod.new(match: Openflow.Match.new(arp_tpa: {10, 10, 10, 10})))
      %Openflow.ErrorMsg{} = get_message()
    end
  end

  describe "Openflow AsyncConfig message" do
    test "with master and slave config" do
      send_message(
        Openflow.SetAsync.new(
          flow_removed_mask_master: [:idle_timeout, :hard_timeout, :delete, :group_delete],
          flow_removed_mask_slave: [],
          packet_in_mask_master: [:no_match, :action],
          packet_in_mask_slave: [],
          port_status_mask_master: [:add, :delete, :modify],
          port_status_mask_slave: []
        )
      )

      {:ok,
       %Openflow.GetAsync.Reply{
         flow_removed_mask_master: [:idle_timeout, :hard_timeout, :delete, :group_delete],
         flow_removed_mask_slave: [],
         packet_in_mask_master: [:no_match, :action],
         packet_in_mask_slave: [],
         port_status_mask_master: [:add, :delete, :modify],
         port_status_mask_slave: []
       }} = sync_send_message(Openflow.GetAsync.Request.new())
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
          priority: 0xFFFF,
          match: Openflow.Match.new(in_port: 0xF, reg0: 99, eth_type: 0x0806),
          instructions:
            Openflow.Instruction.ApplyActions.new([
              Openflow.Action.NxController2.new(pause: true),
              Openflow.Action.NxResubmitTable.new()
            ])
        )
      )

      send_message(
        Openflow.PacketOut.new(
          buffer_id: :no_buffer,
          in_port: 0xF,
          actions: [
            Openflow.Action.SetField.new(reg0: 99),
            Openflow.Action.Output.new(:table)
          ],
          data: File.read!("test/packet_data/arp_packet.raw")
        )
      )

      %Openflow.NxPacketIn2{} = packet_in2 = get_message()
      {:ok, :noreply} = sync_send_message(Openflow.NxResume.new(packet_in: packet_in2))
      %Openflow.NxPacketIn2{} = get_message()
      send_message(Openflow.NxSetPacketInFormat.new(:standard))
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

  def sync_send_message(msg) do
    Tres.SwitchRegistry.send_message(msg, @datapath_id, true)
  end

  def send_message(msg) do
    :ok = Tres.ExampleHandler.send(@datapath_id, msg)
  end

  def get_message do
    Tres.ExampleHandler.get(@datapath_id)
  end
end
