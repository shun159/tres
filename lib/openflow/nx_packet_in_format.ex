defmodule Openflow.NxSetPacketInFormat do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    format: :standard
  )

  @experimenter 0x00002320
  @nx_type 16

  alias __MODULE__

  def ofp_type, do: 4

  def new(format) when is_atom(format) do
    new(format: format)
  end

  def new(options) when is_list(options) do
    %NxSetPacketInFormat{
      format: options[:format] || :standard,
      xid: options[:xid] || 0
    }
  end

  def read(<<@experimenter::32, @nx_type::32, format_int::32>>) do
    format = Openflow.Enums.to_atom(format_int, :packet_in_format)
    %NxSetPacketInFormat{format: format}
  end

  def to_binary(%NxSetPacketInFormat{format: format}) do
    format_int = Openflow.Enums.to_int(format, :packet_in_format)
    <<@experimenter::32, @nx_type::32, format_int::32>>
  end
end
