defmodule Openflow.GetConfig.Reply do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    # default = "normal" is no special handling
    flags: [],
    miss_send_len: 128
  )

  alias __MODULE__

  def ofp_type, do: 8

  def read(<<flags_int::16, miss_send_len0::16>>) do
    flags = Openflow.Enums.int_to_flags(flags_int, :config_flags)
    miss_send_len = Openflow.Utils.get_enum(miss_send_len0, :controller_max_len)
    %Reply{flags: flags, miss_send_len: miss_send_len}
  end

  def to_binary(%Reply{flags: flags, miss_send_len: miss_send_len0}) do
    flags_int = Openflow.Enums.flags_to_int(flags, :config_flags)
    miss_send_len = Openflow.Utils.get_enum(miss_send_len0, :controller_max_len)
    <<flags_int::16, miss_send_len::16>>
  end
end
