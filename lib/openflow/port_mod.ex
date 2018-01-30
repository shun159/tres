defmodule Openflow.PortMod do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    number: 0,
    hw_addr: "000000000000",
    config: [],
    mask: [],
    advertise: []
  )

  alias __MODULE__

  def ofp_type, do: 16

  def new(options \\ []) do
    port_no = Keyword.get(options, :number, :all)
    hw_addr = Keyword.get(options, :hw_adddr, "000000000000")
    config = Keyword.get(options, :config, [])
    mask = Keyword.get(options, :mask, [])
    advertise = Keyword.get(options, :advertise, [])
    %PortMod{number: port_no, hw_addr: hw_addr, config: config, mask: mask, advertise: advertise}
  end

  def read(
        <<port_no_int::32, _::size(4)-unit(8), hw_addr_bin::6-bytes, _::size(2)-unit(8),
          config_int::32, mask_int::32, advertised_int::32, _::size(4)-unit(8)>>
      ) do
    port_no = Openflow.Utils.get_enum(port_no_int, :openflow13_port_no)
    hw_addr = Openflow.Utils.to_hex_string(hw_addr_bin)
    config = Openflow.Enums.int_to_flags(config_int, :port_config)
    mask = Openflow.Enums.int_to_flags(mask_int, :port_config)
    adv = Openflow.Enums.int_to_flags(advertised_int, :port_features)
    %PortMod{number: port_no, hw_addr: hw_addr, config: config, mask: mask, advertise: adv}
  end

  def to_binary(%PortMod{
        number: port_no,
        hw_addr: hw_addr,
        config: config,
        mask: mask,
        advertise: adv
      }) do
    port_no_int = Openflow.Utils.get_enum(port_no, :openflow13_port_no)
    hw_addr_bin = <<String.to_integer(hw_addr, 16)::48>>
    config_int = Openflow.Enums.flags_to_int(config, :port_config)
    mask_int = Openflow.Enums.flags_to_int(mask, :port_config)
    advertised_int = Openflow.Enums.flags_to_int(adv, :port_features)

    <<port_no_int::32, 0::size(4)-unit(8), hw_addr_bin::6-bytes, 0::size(2)-unit(8),
      config_int::32, mask_int::32, advertised_int::32, 0::size(4)-unit(8)>>
  end
end
