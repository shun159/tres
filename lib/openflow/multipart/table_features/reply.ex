defmodule Openflow.Multipart.TableFeatures.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    aux_id:       nil,
    flags:        [],
    tables:       []
  )

  alias __MODULE__
  alias Openflow.Multipart.TableFeatures.Body

  def ofp_type, do: 18

  def new(tables \\ []) do
    %Reply{tables: tables}
  end

  def read(<<tables_bin::bytes>>) do
    tables = Body.read(tables_bin)
    %Reply{tables: tables}
  end

  def to_binary(msg) do
    header_bin = Openflow.Multipart.Reply.header(msg)
    %Reply{tables: tables} = msg
    tables_bin = Openflow.Multipart.TableFeatures.Body.to_binary(tables)
    <<header_bin::bytes, tables_bin::bytes>>
  end

  def append_body(%Reply{tables: tables} = message, %Reply{flags: [:more], tables: continue}) do
    %{message|tables: [continue|tables]}
  end
  def append_body(%Reply{tables: tables} = message, %Reply{flags: [], tables: continue}) do
    new_tables = [continue|tables]
    |> Enum.reverse
    |> List.flatten
    %{message|tables: new_tables}
  end
end
