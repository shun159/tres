defmodule Heckle.PipelineProfiles do
  use Tres.Controller

  def of_aruba do
    [
      TableFeatures.Body.new(
        table_id:       0,
        name:           "classifier",
        max_entries:    10,
        config:         [:table_miss_mask], # deprecated mask.
        match:          [:in_port, :masked_eth_src],
        wildcards:      [:in_port, :masked_eth_src],
        instructions:   [GotoTable],
        write_actions:  [Output],
        next_tables:    [1],
      ),
      TableFeatures.Body.new(
        table_id:       1,
        name:           "NAT",
        max_entries:    10,
        config:         [:table_miss_mask],
        match:          [:eth_dst, :eth_src, :eth_type, :ipv4_src, :ipv4_dst],
        wildcards:      [:eth_dst, :eth_src, :eth_type, :ipv4_src, :ipv4_dst],
        instructions:   [ApplyActions],
        write_actions:  [SetField, PopVlan, PushVlan, Output],
        apply_setfield: [:eth_dst, :vlan_vid, :ipv4_src, :ipv4_dst],
        next_tables:    [],
      )
    ]
  end
end
