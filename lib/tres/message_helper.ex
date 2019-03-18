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

        case options[:bundle_id] do
          nil ->
            send_message(flow_mod, datapath_id, Keyword.get(options, :blocking, false))

          bundle_id when is_integer(bundle_id) ->
            bundle =
              Openflow.OnfBundleAdd.new(
                bundle_id: bundle_id,
                flags: options[:bundle_flags] || [],
                message: flow_mod
              )

            send_message(bundle, datapath_id, Keyword.get(options, :blocking, false))
        end
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

        case options[:bundle_id] do
          nil ->
            send_message(flow_mod, datapath_id, Keyword.get(options, :blocking, false))

          bundle_id when is_integer(bundle_id) ->
            bundle =
              Openflow.OnfBundleAdd.new(
                bundle_id: bundle_id,
                flags: options[:bundle_flags] || [],
                message: flow_mod
              )

            send_message(bundle, datapath_id, Keyword.get(options, :blocking, false))
        end
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

        case options[:bundle_id] do
          nil ->
            send_message(flow_mod, datapath_id, Keyword.get(options, :blocking, false))

          bundle_id when is_integer(bundle_id) ->
            bundle =
              Openflow.OnfBundleAdd.new(
                bundle_id: bundle_id,
                flags: options[:bundle_flags] || [],
                message: flow_mod
              )

            send_message(bundle, datapath_id, Keyword.get(options, :blocking, false))
        end
      end

      defp send_packet_out(options \\ []) do
        case options[:packet_in] do
          %Openflow.PacketIn{} = pin ->
            send_packet_out(
              pin.datapath_id,
              xid: options[:xid] || 0,
              buffer_id: options[:buffer_id],
              in_port: options[:in_port],
              actions: options[:actions],
              data: options[:data] || pin.data,
              blocking: options[:blocking]
            )

          %Openflow.NxPacketIn2{continuation_bridge: nil} = pin ->
            send_packet_out(
              pin.datapath_id,
              xid: options[:xid] || 0,
              buffer_id: options[:buffer_id],
              in_port: options[:in_port],
              actions: options[:actions],
              data: options[:data] || pin.packet,
              blocking: options[:blocking]
            )

          %Openflow.NxPacketIn2{} = pin ->
            send_nx_resume(
              pin.datapath_id,
              xid: options[:xid] || 0,
              packet_in: options[:packet_in],
              packet: options[:data] || pin.packet,
              metadata: options[:metadata] || pin.metadata,
              blocking: options[:blocking]
            )
        end
      end

      defp send_packet_out(datapath_id, options) do
        packet_out = %Openflow.PacketOut{
          xid: options[:xid] || 0,
          buffer_id: options[:buffer_id] || :no_buffer,
          in_port: options[:in_port] || :controller,
          actions: options[:actions] || [],
          data: options[:data] || ""
        }

        case options[:bundle_id] do
          nil ->
            send_message(packet_out, datapath_id, Keyword.get(options, :blocking, false))

          bundle_id when is_integer(bundle_id) ->
            bundle =
              Openflow.OnfBundleAdd.new(
                bundle_id: bundle_id,
                flags: options[:bundle_flags],
                message: packet_out
              )

            send_message(bundle, datapath_id, Keyword.get(options, :blocking, false))
        end
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

        case options[:bundle_id] do
          nil ->
            send_message(group_mod, datapath_id, Keyword.get(options, :blocking, false))

          bundle_id when is_integer(bundle_id) ->
            bundle =
              Openflow.OnfBundleAdd.new(
                bundle_id: bundle_id,
                flags: options[:bundle_flags] || [],
                message: group_mod
              )

            send_message(bundle, datapath_id, Keyword.get(options, :blocking, false))
        end
      end

      defp send_group_mod_delete(datapath_id, options \\ []) do
        group_mod =
          Openflow.GroupMod.new(
            xid: options[:xid] || 0,
            command: :delete,
            group_id: options[:group_id] || :all
          )

        case options[:bundle_id] do
          nil ->
            send_message(group_mod, datapath_id, Keyword.get(options, :blocking, false))

          bundle_id when is_integer(bundle_id) ->
            bundle =
              Openflow.OnfBundleAdd.new(
                bundle_id: bundle_id,
                flags: options[:bundle_flags] || [],
                message: group_mod
              )

            send_message(bundle, datapath_id, Keyword.get(options, :blocking, false))
        end
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

        case options[:bundle_id] do
          nil ->
            send_message(group_mod, datapath_id, Keyword.get(options, :blocking, false))

          bundle_id when is_integer(bundle_id) ->
            bundle =
              Openflow.OnfBundleAdd.new(
                bundle_id: bundle_id,
                flags: options[:bundle_flags] || [],
                message: group_mod
              )

            send_message(bundle, datapath_id, Keyword.get(options, :blocking, false))
        end
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

      # ONF Bundle Control

      defp onf_bundle_open(datapath_id, options \\ []) do
        options2 = Keyword.merge(options, type: :open_request)
        bundle = Openflow.OnfBundleControl.new(options2)
        send_message(bundle, datapath_id)
      end

      defp onf_bundle_close(datapath_id, options) do
        options2 = Keyword.merge(options, type: :close_request)
        bundle = Openflow.OnfBundleControl.new(options2)
        send_message(bundle, datapath_id)
      end

      defp onf_bundle_commit(datapath_id, options) do
        options2 = Keyword.merge(options, type: :commit_request)
        bundle = Openflow.OnfBundleControl.new(options2)
        send_message(bundle, datapath_id)
      end

      defp onf_bundle_discard(datapath_id, options) do
        options2 = Keyword.merge(options, type: :discard_request)
        bundle = Openflow.OnfBundleControl.new(options2)
        send_message(bundle, datapath_id)
      end
    end
  end
end
