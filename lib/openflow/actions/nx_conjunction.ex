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

  def new(options \\ []) do
    n_clauses = options[:n_clauses] || raise "n_clauses must be specified"
    n_clauses >= 2 || raise "n_clauses must be greater than 1"

    %NxConjunction{
      clause: (options[:clause] || 0) + 1,
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
