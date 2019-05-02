defmodule Openflow.Multipart.Desc.Reply do
  defstruct(
    version: 4,
    xid: 0,
    # virtual field
    datapath_id: nil,
    aux_id: nil,
    flags: [],
    mfr_desc: "",
    hw_desc: "",
    sw_desc: "",
    serial_num: "",
    dp_desc: ""
  )

  alias __MODULE__

  @type t :: %Reply{
          version: 4,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFF | nil,
          xid: 0..0xFFFFFFFF,
          flags: [],
          mfr_desc: String.t(),
          hw_desc: String.t(),
          sw_desc: String.t(),
          serial_num: String.t(),
          dp_desc: String.t()
        }

  @desc_str_len 256
  @serial_num_len 32

  @spec ofp_type() :: 19
  def ofp_type, do: 19

  @spec new(
          xid: 0..0xFFFFFFFF,
          mfr_desc: String.t(),
          hw_desc: String.t(),
          sw_desc: String.t(),
          serial_num: String.t(),
          dp_desc: String.t()
        ) :: t()
  def new(options \\ []) do
    %Reply{
      xid: options[:xid] || 0,
      mfr_desc: options[:mfr_desc] || "",
      hw_desc: options[:hw_desc] || "",
      sw_desc: options[:sw_desc] || "",
      serial_num: options[:serial_num] || "",
      dp_desc: options[:dp_desc] || ""
    }
  end

  @spec to_binary(t()) :: <<_::64, _::_*8>>
  def to_binary(%Reply{} = desc) do
    <<
      Openflow.Multipart.Reply.header(desc)::bytes,
      String.pad_trailing(desc.mfr_desc, @desc_str_len, <<0>>)::bytes,
      String.pad_trailing(desc.hw_desc, @desc_str_len, <<0>>)::bytes,
      String.pad_trailing(desc.sw_desc, @desc_str_len, <<0>>)::bytes,
      String.pad_trailing(desc.serial_num, @serial_num_len, <<0>>)::bytes,
      String.pad_trailing(desc.dp_desc, @desc_str_len, <<0>>)::bytes
    >>
  end

  @spec read(<<_::8448>>) :: t()
  def read(<<
        mfr_desc::size(@desc_str_len)-bytes,
        hw_desc::size(@desc_str_len)-bytes,
        sw_desc::size(@desc_str_len)-bytes,
        serial_num::size(@serial_num_len)-bytes,
        dp_desc::size(@desc_str_len)-bytes
      >>) do
    %Reply{
      mfr_desc: hd(String.split(mfr_desc, <<0>>, parts: 2)),
      hw_desc: hd(String.split(hw_desc, <<0>>, parts: 2)),
      sw_desc: hd(String.split(sw_desc, <<0>>, parts: 2)),
      serial_num: hd(String.split(serial_num, <<0>>, parts: 2)),
      dp_desc: hd(String.split(dp_desc, <<0>>, parts: 2))
    }
  end
end
