defmodule Openflow.Multipart.Desc.Reply do
  defstruct(
    version:        4,
    xid:            0,
    datapath_id:  nil, # virtual field
    aux_id:       nil,
    flags:        [],
    mfr_desc:     "",
    hw_desc:      "",
    sw_desc:      "",
    serial_num:   "",
    dp_desc:      ""
  )

  alias __MODULE__

  @desc_str_len   256
  @serial_num_len 32

  def ofp_type, do: 19

  def read(<<mfr_desc::size(@desc_str_len)-bytes, hw_desc::size(@desc_str_len)-bytes,
             sw_desc::size(@desc_str_len)-bytes, serial_num::size(@serial_num_len)-bytes,
             dp_desc::size(@desc_str_len)-bytes>>) do
    %Reply{mfr_desc:   Openflow.Utils.decode_string(mfr_desc),
           hw_desc:    Openflow.Utils.decode_string(hw_desc),
           sw_desc:    Openflow.Utils.decode_string(sw_desc),
           serial_num: Openflow.Utils.decode_string(serial_num),
           dp_desc:    Openflow.Utils.decode_string(dp_desc)}
  end
end
