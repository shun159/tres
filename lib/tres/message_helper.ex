defmodule Tres.MessageHelper do
  defmacro __using__(_) do
    quote location: :keep do
      defp send_flow_mod_add(datapath_id, options) do
        flow_mod = %Openflow.FlowMod{
          cookie:   options[:cookie] || 0,
          priority: options[:priority] || 0,
          table_id: options[:table_id] || 0,
          command: :add,
          idle_timeout: options[:idle_timeout] || 0,
          hard_timeout: options[:hard_timeout] || 0,
          buffer_id: :no_buffer,
          out_port: :any,
          out_group:  :any,
          flags: options[:flags] || [],
          match: options[:match] || Openflow.Match.new,
          instructions: options[:instructions] || [],
        }
        send_message(flow_mod, datapath_id)
      end

      defp send_flow_mod_modify(datapath_id, options) do
        command = Tres.Utils.flow_command(options, :modify)
        flow_mod = %Openflow.FlowMod{
          cookie:   options[:cookie] || 0,
          table_id: options[:table_id] || 0,
          command: command,
          idle_timeout: options[:idle_timeout] || 0,
          hard_timeout: options[:hard_timeout] || 0,
          out_port: :any,
          out_group: :any,
          match: options[:match] || Openflow.Match.new,
          instructions: options[:instructions] || [],
        }
        send_message(flow_mod, datapath_id)
      end

      defp send_flow_mod_delete(datapath_id, options) do
        command = Tres.Utils.flow_command(options, :delete)
        flow_mod = %Openflow.FlowMod{
          cookie:   options[:cookie] || 0,
          cookie_mask: options[:cookie_mask] || 0,
          table_id: options[:table_id] || :all,
          command: command,
          out_port: options[:out_port] || :any,
          out_group: options[:out_group] || :any,
          match: options[:match] || Openflow.Match.new
        }
        send_message(flow_mod, datapath_id)
      end

      defp send_packet_out(datapath_id, options) do
        packet_out = %Openflow.PacketOut{
          buffer_id: options[:buffer_id] || :no_buffer,
          in_port: options[:in_port] || :controller,
          actions: options[:actions] || [],
          data: options[:data] || ""
        }
        send_message(packet_out, datapath_id)
      end

      defp send_group_mod_add(datapath_id, options) do
        group_mod = Openflow.GroupMod.new(
          command: :add,
          type: options[:type] || :all,
          group_id: options[:group_id] || 0,
          buckets: options[:buckets] || []
        )
        send_message(group_mod, datapath_id)
      end

      defp send_group_mod_delete(datapath_id, group_id) do
        group_mod = Openflow.GroupMod.new(command: :delete, group_id: group_id)
        send_message(group_mod, datapath_id)
      end

      defp send_group_mod_modify(datapath_id, options) do
        group_mod = Openflow.GroupMod.new(
          command: :modify,
          type: options[:type] || :all,
          group_id: options[:group_id] || 0,
          buckets: options[:buckets] || []
        )
        send_message(group_mod, datapath_id)
      end
    end
  end
end
