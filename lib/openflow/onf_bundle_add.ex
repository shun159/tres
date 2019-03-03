defmodule Openflow.OnfBundleAdd do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    # bundle header
    bundle_id: 0,
    flags: [],
    message: nil
  )

  alias __MODULE__

  # ONF Experimenter
  @experimenter 0x4F4E4600
  # BUNDLE_ADD
  @onf_type 2301

  @onf_bundle_add_message_size 24

  # experimenter
  def ofp_type, do: 4

  def new(options \\ []) do
    %OnfBundleAdd{
      xid: options[:xid] || 0,
      bundle_id: options[:bundle_id] || 0,
      flags: options[:flags] || [],
      message: options[:message]
    }
  end

  def to_binary(%OnfBundleAdd{} = bundle_add) do
    bundle_id = bundle_add.bundle_id
    message_bin = Openflow.to_binary(%{bundle_add.message | xid: bundle_add.xid})
    length = @onf_bundle_add_message_size + byte_size(message_bin)
    pad_length = Openflow.Utils.pad_length(length, 8)
    flags_int = Openflow.Enums.flags_to_int(bundle_add.flags, :bundle_flags)

    <<@experimenter::32, @onf_type::32, bundle_id::32, 0::2-unit(8),
      flags_int::16, message_bin::bytes, 0::size(pad_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @onf_type::32, bundle_id::32, _pad::16, flags_int::16, message_bin::bytes>>) do
    message = Openflow.read(message_bin)
    flags = Openflow.Enums.int_to_flags(flags_int, :bundle_flags)
    %OnfBundleAdd{bundle_id: bundle_id, flags: flags, message: message}
  end
end
