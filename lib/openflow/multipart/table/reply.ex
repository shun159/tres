defmodule Openflow.Multipart.Table.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    aux_id:       nil,
    flags:        [],
    tables:       []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def read(<<tables_bin::bytes>>) do
    tables = Openflow.Multipart.TableStats.read(tables_bin)
    %Reply{tables: tables}
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

defmodule Openflow.Multipart.TableStats do
  defstruct(
    table_id:      0,
    active_count:  0,
    lookup_count:  0,
    matched_count: 0
  )

  alias __MODULE__

  def read(binary) do
    do_read([], binary)
  end

  # private functions

  defp do_read(acc, ""), do: Enum.reverse(acc)
  defp do_read(acc, <<table_stats_bin::24-bytes, rest::bytes>>) do
    do_read([codec(table_stats_bin)|acc], rest)
  end

  defp codec(<<table_id::8, _::size(3)-unit(8), active_count::32, lookup_count::64, matched_count::64>>) do
    %TableStats{table_id: table_id, active_count: active_count,
                lookup_count: lookup_count, matched_count: matched_count}
  end
end
