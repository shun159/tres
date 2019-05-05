defmodule Openflow.Multipart.TableFeatures.Request do
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

  def ofp_type, do: 18

  def new(options \\ []) do
    %Request{
      flags: options[:flags] || [],
      xid: options[:xid] || 0,
      tables: options[:tables] || []
    }
  end

  def read(<<tables_bin::bytes>>) do
    tables = Body.read(tables_bin)
    %Request{tables: tables}
  end

  def to_binary(msg) do
    header_bin = Openflow.Multipart.Request.header(msg)
    %Request{tables: tables} = msg
    tables_bin = Openflow.Multipart.TableFeatures.Body.to_binary(tables)
    <<header_bin::bytes, tables_bin::bytes>>
  end
end
