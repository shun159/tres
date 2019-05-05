defmodule Openflow.Multipart.Flow.Request do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    aux_id: nil,
    flags: [],
    table_id: :all,
    out_port: :any,
    out_group: :any,
    cookie: 0,
    cookie_mask: 0,
    match: Openflow.Match.new()
  )

  alias __MODULE__

  @type t :: %Request{
          version: 4,
          datapath_id: String.t(),
          aux_id: 0..0xFF | nil,
          xid: 0..0xFFFFFFFF,
          table_id: 0..0xFF | :all | :max,
          out_port: Openflow.Port.no(),
          out_group: Openflow.GroupMod.id(),
          cookie: 0..0xFFFFFFFFFFFFFFFF,
          cookie_mask: 0..0xFFFFFFFFFFFFFFFF,
          match: %Openflow.Match{fields: [map()], type: :oxm}
        }

  @spec ofp_type() :: 18
  def ofp_type, do: 18

  @spec new(
          xid: 0..0xFFFFFFFF,
          table_id: 0..0xFF | :all | :max,
          out_port: Openflow.Port.no(),
          out_group: Openflow.GroupMod.id(),
          cookie: 0..0xFFFFFFFFFFFFFFFF,
          cookie_mask: 0..0xFFFFFFFFFFFFFFFF,
          match: %Openflow.Match{fields: [map()], type: :oxm}
        ) :: t()
  def new(options \\ []) do
    %Request{
      xid: options[:xid] || 0,
      table_id: options[:table_id] || :all,
      out_port: options[:out_port] || :any,
      out_group: options[:out_group] || :any,
      cookie: options[:cookie] || 0,
      cookie_mask: options[:cookie_mask] || 0,
      match: options[:match] || Openflow.Match.new()
    }
  end

  @spec read(<<_::256, _::_*8>>) :: t()
  def read(<<
        table_id_int::8,
        _::size(3)-unit(8),
        out_port_int::32,
        out_group_int::32,
        _::size(4)-unit(8),
        cookie::64,
        cookie_mask::64,
        match_bin::bytes
      >>) do
    match =
      match_bin
      |> Openflow.Match.read()
      |> Kernel.elem(0)

    %Request{
      table_id: Openflow.Utils.get_enum(table_id_int, :table_id),
      out_port: Openflow.Utils.get_enum(out_port_int, :openflow13_port_no),
      out_group: Openflow.Utils.get_enum(out_group_int, :group_id),
      cookie: cookie,
      cookie_mask: cookie_mask,
      match: match
    }
  end

  @spec to_binary(t()) :: <<_::256, _::_*8>>
  def to_binary(
        %Request{
          table_id: table_id,
          out_port: out_port,
          out_group: out_group,
          cookie: cookie,
          cookie_mask: cookie_mask,
          match: match
        } = msg
      ) do
    <<
      Openflow.Multipart.Request.header(msg)::bytes,
      Openflow.Utils.get_enum(table_id, :table_id)::8,
      0::size(3)-unit(8),
      Openflow.Utils.get_enum(out_port, :openflow13_port_no)::32,
      Openflow.Utils.get_enum(out_group, :group_id)::32,
      0::size(4)-unit(8),
      cookie::64,
      cookie_mask::64,
      Openflow.Match.to_binary(match)::bytes
    >>
  end
end
