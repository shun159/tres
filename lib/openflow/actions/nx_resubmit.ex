defmodule Openflow.Action.NxResubmit do
  defstruct(in_port: :in_port)

  @experimenter 0x00002320
  @nxast 1

  alias __MODULE__

  def new(in_port \\ :in_port) do
    %NxResubmit{in_port: in_port}
  end

  def to_binary(%NxResubmit{in_port: in_port}) do
    in_port_int = Openflow.Utils.get_enum(in_port, :openflow10_port_no)
    exp_body = <<@experimenter::32, @nxast::16, in_port_int::16, 0::size(4)-unit(8)>>
    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, in_port_int::16, _::size(4)-unit(8)>>) do
    in_port = Openflow.Utils.get_enum(in_port_int, :openflow10_port_no)
    %NxResubmit{in_port: in_port}
  end
end
