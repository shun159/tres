defmodule Tres.MessageHelper do
  defmacro __using__(_) do
    quote location: :keep do
      defp send_flow_mod_add(datapath_id, options \\ []) do
        flow_mod = %Openflow.FlowMod{
          cookie: options[:cookie] || 0,
          priority: options[:priority] || 0,
          table_id: options[:table_id] || 0,
          command: :add,
          idle_timeout: options[:idle_timeout] || 0,
          hard_timeout: options[:hard_timeout] || 0,
          buffer_id: :no_buffer,
          out_port: :any,
          out_group: :any,
          flags: options[:flags] || [],
          match: options[:match] || Openflow.Match.new(),
          instructions: options[:instructions] || []
        }

        send_message(flow_mod, datapath_id, Keyword.get(options, :blocking, false))
      end

      defp send_flow_mod_modify(datapath_id, options \\ []) do
        command = Tres.Utils.flow_command(:modify, options)

        flow_mod = %Openflow.FlowMod{
          xid: options[:xid] || 0,
          cookie: options[:cookie] || 0,
          table_id: options[:table_id] || 0,
          command: command,
          idle_timeout: options[:idle_timeout] || 0,
          hard_timeout: options[:hard_timeout] || 0,
          out_port: :any,
          out_group: :any,
          match: options[:match] || Openflow.Match.new(),
          instructions: options[:instructions] || []
        }

        send_message(flow_mod, datapath_id, Keyword.get(options, :blocking, false))
      end

      defp send_flow_mod_delete(datapath_id, options \\ []) do
        command = Tres.Utils.flow_command(:delete, options)

        flow_mod = %Openflow.FlowMod{
          xid: options[:xid] || 0,
          cookie: options[:cookie] || 0,
          cookie_mask: options[:cookie_mask] || 0,
          table_id: options[:table_id] || :all,
          command: command,
          out_port: options[:out_port] || :any,
          out_group: options[:out_group] || :any,
          match: options[:match] || Openflow.Match.new()
        }

        send_message(flow_mod, datapath_id, Keyword.get(options, :blocking, false))
      end

      defp send_packet_out(datapath_id, options \\ []) do
        packet_out = %Openflow.PacketOut{
          xid: options[:xid] || 0,
          buffer_id: options[:buffer_id] || :no_buffer,
          in_port: options[:in_port] || :controller,
          actions: options[:actions] || [],
          data: options[:data] || ""
        }

        send_message(packet_out, datapath_id, Keyword.get(options, :blocking, false))
      end

      defp send_group_mod_add(datapath_id, options \\ []) do
        group_mod =
          Openflow.GroupMod.new(
            xid: options[:xid] || 0,
            command: :add,
            type: options[:type] || :all,
            group_id: options[:group_id] || 0,
            buckets: options[:buckets] || []
          )

        send_message(group_mod, datapath_id, Keyword.get(options, :blocking, false))
      end

      defp send_group_mod_delete(datapath_id, options \\ []) do
        group_mod =
          Openflow.GroupMod.new(
            xid: options[:xid] || 0,
            command: :delete,
            group_id: options[:group_id] || :all
          )

        send_message(group_mod, datapath_id, Keyword.get(options, :blocking, false))
      end

      defp send_group_mod_modify(datapath_id, options \\ []) do
        group_mod =
          Openflow.GroupMod.new(
            xid: options[:xid] || 0,
            command: :modify,
            type: options[:type] || :all,
            group_id: options[:group_id] || 0,
            buckets: options[:buckets] || []
          )

        send_message(group_mod, datapath_id, Keyword.get(options, :blocking, false))
      end

      defp send_role_request(datapath_id, options) do
        role_request =
          Openflow.Role.Request.new(
            xid: options[:xid] || 0,
            role: options[:role] || :nochange,
            generation_id: options[:generation_id] || 0
          )

        send_message(role_request, datapath_id, Keyword.get(options, :blocking, false))
      end

      defp send_meter_mod_add(datapath_id, options \\ []) do
        meter_mod =
          Openflow.MeterMod.new(
            xid: options[:xid] || 0,
            command: :add,
            flags: options[:flags] || [],
            meter_id: options[:meter_id] || 0,
            bands: options[:bands] || []
          )

        send_message(meter_mod, datapath_id, options[:blocking] || false)
      end

      defp send_meter_mod_modify(datapath_id, options \\ []) do
        meter_mod =
          Openflow.MeterMod.new(
            xid: options[:xid] || 0,
            command: :modify,
            flags: options[:flags] || [],
            meter_id: options[:meter_id] || 0,
            bands: options[:bands] || []
          )

        send_message(meter_mod, datapath_id, options[:blocking] || false)
      end

      defp send_meter_mod_delete(datapath_id, options \\ []) do
        meter_mod =
          Openflow.MeterMod.new(
            xid: options[:xid] || 0,
            command: :delete,
            meter_id: options[:meter_id] || 0
          )

        send_message(meter_mod, datapath_id, options[:blocking] || false)
      end

      defp send_nx_resume(datapath_id, options) do
        resume = Openflow.NxResume.new(options)
        send_message(resume, datapath_id, options[:blocking] || false)
      end
    end
  end
end
