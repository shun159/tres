defmodule Openflow.Multipart.Flow.Request do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    flags:        [],
    table_id:     :all,
    out_port:     :any,
    out_group:    :any,
    cookie:       0,
    cookie_mask:  0,
    match:        []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(options) do
    table_id = Keyword.get(options, :table_id, :all)
    out_port = Keyword.get(options, :out_port, :any)
    out_group = Keyword.get(options, :out_group, :any)
    cookie = Keyword.get(options, :cookie, 0)
    cookie_mask = Keyword.get(options, :cookie, 0)
    match = Keyword.get(options, :match, [])
    %Request{table_id: table_id,
             out_port: out_port,
             out_group: out_group,
             cookie: cookie,
             cookie_mask: cookie_mask,
             match: match}
  end

  def read(<<table_id_int::8, _::size(3)-unit(8),
             out_port_int::32, out_group_int::32,
             _::size(4)-unit(8), cookie::64,
             cookie_mask::64, match_bin::bytes>>) do
    table_id = Openflow.Utils.get_enum(table_id_int, :table_id)
    out_port = Openflow.Utils.get_enum(out_port_int, :openflow13_port_no)
    out_group = Openflow.Utils.get_enum(out_group_int, :group_id)
    {match, _rest} = Openflow.Match.read(match_bin)
    %Request{table_id: table_id,
             out_port: out_port,
             out_group: out_group,
             cookie: cookie,
             cookie_mask: cookie_mask,
             match: match}
  end

  def to_binary(%Request{table_id: table_id,
                         out_port: out_port,
                         out_group: out_group,
                         cookie: cookie,
                         cookie_mask: cookie_mask,
                         match: match} = msg) do
    table_id_int = Openflow.Utils.get_enum(table_id, :table_id)
    out_port_int = Openflow.Utils.get_enum(out_port, :openflow13_port_no)
    out_group_int = Openflow.Utils.get_enum(out_group, :group_id)
    match_bin = Openflow.Match.to_binary(match)
    body_bin = <<table_id_int::8, 0::size(3)-unit(8),
                 out_port_int::32, out_group_int::32,
                 0::size(4)-unit(8), cookie::64,
                 cookie_mask::64, match_bin::bytes>>
    header_bin = Openflow.Multipart.Request.header(msg)
    <<header_bin::bytes, body_bin::bytes>>
  end
end
