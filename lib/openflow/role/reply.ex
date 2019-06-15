defmodule Openflow.Role.Reply do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    # virtual field
    aux_id: 0,
    role: :nochange,
    generation_id: 0
  )

  alias __MODULE__

  def ofp_type, do: 25

  def read(<<role_int::32, 0::size(4)-unit(8), generation_id::64>>) do
    role = Openflow.Enums.to_atom(role_int, :controller_role)
    %Reply{role: role, generation_id: generation_id}
  end
end
