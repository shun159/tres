defmodule Openflow.Action.NxConjunction do
  defstruct(
    clause: 0,
    n_clauses: 0,
    id: 0
  )

  @experimenter 0x00002320
  @nxast 34

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @spec new(Keyword.t()) :: %NxConjunction{}
  def new(options) do
    clause = (options[:clause] || 0) + 1
    n_clauses = options[:n_clauses] || raise "n_clauses must be specified"
    n_clauses >= 2 || raise "n_clauses must be greater than 1"

    (1 <= clause and clause <= n_clauses and 2 <= n_clauses and n_clauses <= 64) ||
      raise "conjunction(id, k/n) must satisfy 1 <= k <= n and 2 <= n <= 64"

    %NxConjunction{
      clause: clause,
      n_clauses: n_clauses,
      id: options[:id] || 0
    }
  end

  def to_binary(%NxConjunction{clause: clause, n_clauses: n_clauses, id: id}) do
    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      clause::8,
      n_clauses::8,
      id::32
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, clause::8, n_clauses::8, id::32>>) do
    %NxConjunction{clause: clause, n_clauses: n_clauses, id: id}
  end
end
