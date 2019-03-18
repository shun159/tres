defmodule Openflow.Action.NxDecTtlCntIds do
  defstruct(ids: [])

  @experimenter 0x00002320
  @nxast 21

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(ids \\ []) do
    %NxDecTtlCntIds{ids: ids}
  end

  def to_binary(%NxDecTtlCntIds{ids: ids}) do
    n_controllers = length(ids)
    ids_bin = Enum.reduce(ids, <<>>, fn id, acc -> <<acc::bytes, id::16>> end)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      n_controllers::16,
      0::size(4)-unit(8),
      ids_bin::bytes
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, n_controllers::16, body::bitstring>>) do
    n_controllers_len = n_controllers * 16
    <<0::size(4)-unit(8), ids_bin::size(n_controllers_len)-bits, _::bitstring>> = body
    ids = for <<id::16 <- ids_bin>>, do: id
    %NxDecTtlCntIds{ids: ids}
  end
end
