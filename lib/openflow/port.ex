defmodule Openflow.Port do
  defstruct(
    number: 0,
    hw_addr: "000000000000",
    name: "",
    config: [],
    state: [],
    current_features: [],
    advertised_features: [],
    supported_features: [],
    peer_features: [],
    current_speed: :"10mb_hd",
    max_speed: :"10mb_hd"
  )

  @ofp_max_port_name_len 16

  alias __MODULE__

  def read(
        <<port_no_int::32, _::size(4)-unit(8), hw_addr_bin::6-bytes, _::size(2)-unit(8),
          name_bin::size(@ofp_max_port_name_len)-bytes, config_int::32, state_int::32,
          curr_int::32, advertised_int::32, supp_int::32, peer_int::32, curr_speed::32,
          max_speed::32>>
      ) do
    port_no = Openflow.Utils.get_enum(port_no_int, :openflow13_port_no)
    hw_addr = Openflow.Utils.to_hex_string(hw_addr_bin)
    name = Openflow.Utils.decode_string(name_bin)
    config = Openflow.Enums.int_to_flags(config_int, :port_config)
    state = Openflow.Enums.int_to_flags(state_int, :port_state)
    curr = Openflow.Enums.int_to_flags(curr_int, :port_features)
    adv = Openflow.Enums.int_to_flags(advertised_int, :port_features)
    supp = Openflow.Enums.int_to_flags(supp_int, :port_features)
    peer = Openflow.Enums.int_to_flags(peer_int, :port_features)

    %Port{
      number: port_no,
      hw_addr: hw_addr,
      name: name,
      config: config,
      state: state,
      current_features: curr,
      advertised_features: adv,
      supported_features: supp,
      peer_features: peer,
      current_speed: curr_speed,
      max_speed: max_speed
    }
  end
end
