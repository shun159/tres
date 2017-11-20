defmodule Openflow.Multipart.GroupFeatures.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    aux_id:       nil,
    flags:        [],
    types:        0,
    capabilities: [],
    max_groups_for_all:           0,
    max_groups_for_select:        0,
    max_groups_for_indirect:      0,
    max_groups_for_fast_failover: 0,
    actions_for_all:              0,
    actions_for_select:           0,
    actions_for_indirect:         0,
    actions_for_fast_failover:    0
  )

  alias __MODULE__

  def ofp_type, do: 18

  def read(<<types_int::32, capabilities_int::32,
             max_groups_for_all_int::32,
             max_groups_for_select_int::32,
             max_groups_for_indirect_int::32,
             max_groups_for_fast_failover_int::32,
             actions_for_all_int::32,
             actions_for_select_int::32,
             actions_for_indirect_int::32,
             actions_for_fast_failover_int::32>>) do
    capabilities = Openflow.Enums.int_to_flags(capabilities_int, :group_capabilities)
    %Reply{types: types_int,
           capabilities: capabilities,
           max_groups_for_all: max_groups_for_all_int,
           max_groups_for_select: max_groups_for_select_int,
           max_groups_for_indirect: max_groups_for_indirect_int,
           max_groups_for_fast_failover: max_groups_for_fast_failover_int,
           actions_for_all: actions_for_all_int,
           actions_for_select: actions_for_select_int,
           actions_for_indirect: actions_for_indirect_int,
           actions_for_fast_failover: actions_for_fast_failover_int}
  end
end
