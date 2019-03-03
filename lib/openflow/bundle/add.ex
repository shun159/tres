defmodule Openflow.Bundle.Add do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    # bundle header
    bundle_id: 0,
    flags: [],
    message: nil,
  )

  alias __MODULE__

  # ONF Experimenter
  @experimenter 0x4F4E4600
  # BUNDLE_ADD
  @onf_type 2301

  # experimenter
  def ofp_type, do: 4
end
