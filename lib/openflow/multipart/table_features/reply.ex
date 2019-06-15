defmodule Openflow.Multipart.TableFeatures.Reply do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    aux_id: nil,
    flags: [],
    tables: []
  )

  alias __MODULE__
  alias Openflow.Multipart.TableFeatures.Body

  def ofp_type, do: 19

  def read(<<tables_bin::bytes>>) do
    tables = Body.read(tables_bin)
    %Reply{tables: tables}
  end

  def append_body(%Reply{tables: tables} = message, %Reply{flags: [:more], tables: continue}) do
    %{message | tables: [continue | tables]}
  end

  def append_body(%Reply{tables: tables} = message, %Reply{flags: [], tables: continue}) do
    new_tables =
      [continue | tables]
      |> Enum.reverse()
      |> List.flatten()

    %{message | tables: new_tables}
  end
end
