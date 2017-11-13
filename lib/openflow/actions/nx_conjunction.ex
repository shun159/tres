defmodule Openflow.Action.NxConjunction do
  defstruct(
    clause:    0,
    n_clauses: 0,
    id:        0
  )

  @experimenter 0x00002320
  @nxast 34

  alias __MODULE__

  def new(options) do
    clause = Keyword.get(options, :clause, 0)
    n_clauses = Keyword.get(options, :n_clauses, 0)
    id = Keyword.get(options, :id, 0)
    %NxConjunction{clause: clause, n_clauses: n_clauses, id: id}
  end

  def to_binary(%NxConjunction{clause: clause, n_clauses: n_clauses, id: id}) do
    exp_body = <<@experimenter::32, @nxast::16, clause::8, n_clauses::8, id::32>>
    <<0xffff::16, 16::16, exp_body::bytes>>
  end

  def read(<<@experimenter::32, @nxast::16, clause::8, n_clauses::8, id::32>>) do
    %NxConjunction{clause: clause, n_clauses: n_clauses, id: id}
  end
end
