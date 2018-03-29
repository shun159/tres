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

  def new(options \\ []) do
    role = Keyword.get(options, :role, :nochange)
    generation_id = Keyword.get(options, :generation_id, 0)
    %Reply{role: role, generation_id: generation_id}
  end

  def read(<<role_int::32, 0::size(4)-unit(8), generation_id::64>>) do
    role = Openflow.Enums.to_atom(role_int, :controller_role)
    %Reply{role: role, generation_id: generation_id}
  end

  def to_binary(%Reply{role: role, generation_id: generation_id}) do
    role_int = Openflow.Enums.to_int(role, :controller_role)
    <<role_int::32, 0::size(4)-unit(8), generation_id::64>>
  end
end
