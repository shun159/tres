defmodule Openflow.OnfBundleControl do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    # bundle header
    bundle_id: 0,
    type: :open_request,
    flags: []
  )

  alias __MODULE__

  # ONF Experimenter
  @experimenter 0x4F4E4600
  # BUNDLE_CONTROL
  @onf_type 2300

  # experimenter
  def ofp_type, do: 4

  def new(options \\ []) do
    %OnfBundleControl{
      xid: options[:xid] || 0,
      bundle_id: options[:bundle_id] || 0,
      type: options[:type] || :open_request,
      flags: options[:flags] || []
    }
  end

  def to_binary(%OnfBundleControl{} = ctrl) do
    bundle_id = ctrl.bundle_id
    type_int = Openflow.Utils.get_enum(ctrl.type, :bundle_ctrl_type)
    flags_int = Openflow.Enums.flags_to_int(ctrl.flags, :bundle_flags)
    <<@experimenter::32, @onf_type::32, bundle_id::32, type_int::16, flags_int::16>>
  end

  def read(<<@experimenter::32, @onf_type::32, bundle_id::32, type_int::16, flags_int::16>>) do
    type = Openflow.Utils.get_enum(type_int, :bundle_ctrl_type)
    flags = Openflow.Enums.int_to_flags(flags_int, :bundle_flags)
    %OnfBundleControl{bundle_id: bundle_id, type: type, flags: flags}
  end
end
