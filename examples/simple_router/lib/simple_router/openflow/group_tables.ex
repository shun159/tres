defmodule SimpleRouter.Openflow.GroupTables do
  @moduledoc """
  Group Table Definitions
  """

  use Tres.Controller

  def egress(iface, datapath_id) do
    bucket =
      Openflow.Bucket.new(
        actions: [
          SetField.new(eth_src: iface.mac_address),
          Output.new(iface.number)
        ]
      )

    send_group_mod_add(
      datapath_id,
      type: :indirect,
      group_id: iface.number,
      buckets: [bucket]
    )
  end
end
