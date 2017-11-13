defmodule Openflow.ErrorMsg do
  @moduledoc "OpenFlow Error codec module"

  defstruct(
    version:        4,
    xid:            0,
    type:         nil,
    code:         nil,
    data:          "",
    exp_type:     nil,
    experimenter: nil,
    datapath_id:  nil, # virtual field
    aux_id:         0  # virtual field
  )

  alias __MODULE__

  def ofp_type, do: 1

  def read(<<0xffff::16, exp_type::16, experimenter::32, data::bytes>>) do
    error_type = Openflow.Enums.to_atom(0xffff, :error_type)
    %ErrorMsg{
      type:         error_type,
      exp_type:     exp_type,
      experimenter: experimenter,
      data:         data
    }
  end
  def read(<<type::16, code::16, data::bytes>>) do
    error_type = Openflow.Enums.to_atom(type, :error_type)
    error_code = Openflow.Enums.to_atom(code, error_type)
    %ErrorMsg{
      type: error_type,
      code: error_code,
      data: data
    }
  end

  def to_binary(%ErrorMsg{type: :experimenter,
                          exp_type: exp_type,
                          experimenter: experimenter,
                          data: data}) do
    error_type = Openflow.Enums.to_int(:experimenter, :error_type)
    <<error_type::16, exp_type::16, experimenter::32, data::bytes>>
  end
  def to_binary(%ErrorMsg{type: type,
                          code: code,
                          data: data}) do
    error_type = Openflow.Enums.to_int(type, :error_type)
    error_code = Openflow.Enums.to_int(code, type)
    <<error_type::16, error_code::16, data::bytes>>
  end
end
