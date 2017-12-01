defmodule Heckle.PipelineProfiles do
  use Tres.Controller

  def of_aruba do
    [
      TableFeatures.Body.new(
        table_id:       0,
        name:           "classifier",
        max_entries:    10,
        config:         [:table_miss_mask], # deprecated mask.
        match:          [:in_port, :vlan_vid, :eth_src],
        wildcards:      [:in_port, :vlan_vid, :eth_src],
        instructions:   [GotoTable, ApplyActions],
        apply_actions:  [Output, PushVlan, SetField, PopVlan],
        apply_setfield: [:eth_dst, :vlan_vid],
        next_tables:    [1],
      ),
      TableFeatures.Body.new(
        table_id:       1,
        name:           "process",
        max_entries:    10,
        config:         [:table_miss_mask],
        match:          [:eth_src, :masked_eth_dst, :vlan_vid, :eth_type, :ipv4_src, :ipv4_dst],
        wildcards:      [:eth_src, :masked_eth_dst, :vlan_vid, :eth_type, :ipv4_src, :ipv4_dst],
        instructions:   [ApplyActions],
        apply_actions:  [SetField, PopVlan, PushVlan, Output],
        apply_setfield: [:eth_src, :eth_dst, :vlan_vid, :ipv4_src, :ipv4_dst],
        next_tables:    [],
      )
    ]
  end
end
