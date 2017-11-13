defmodule Openflow.Action.NxOutputTrunc do
  defstruct(
    port_number: 0,
    max_len: :no_buffer
  )

  @experimenter 0x00002320
  @nxast 39

  alias __MODULE__

  def new(options) do
    port_no = Keyword.get(options, :port_number)
    max_len = Keyword.get(options, :max_len)
    %NxOutputTrunc{port_number: port_no, max_len: max_len}
  end

  def to_binary(%NxOutputTrunc{port_number: port_no, max_len: max_len}) do
    port_no_int = Openflow.Utils.get_enum(port_no, :openflow10_port_no)
    exp_body = <<@experimenter::32, @nxast::16, port_no_int::16, max_len::32>>
    exp_body_size =  byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xffff::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, port_no_int::16, max_len::32>>) do
    port_no = Openflow.Utils.get_enum(port_no_int, :openflow10_port_no)
    %NxOutputTrunc{port_number: port_no, max_len: max_len}
  end
end
