defmodule Openflow.NxSetControllerId do
  defstruct(
    version: 4,
    xid: 0,
    id: 0
  )

  @experimenter 0x00002320
  @nx_type 20

  alias __MODULE__

  def ofp_type, do: 4

  def new(controller_id) do
    %NxSetControllerId{id: controller_id}
  end

  def read(<<@experimenter::32, @nx_type::32, _::size(6)-unit(8), controller_id::16>>) do
    %NxSetControllerId{id: controller_id}
  end

  def to_binary(%NxSetControllerId{id: controller_id}) do
    <<@experimenter::32, @nx_type::32, 0::size(6)-unit(8), controller_id::16>>
  end
end
