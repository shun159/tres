defmodule Openflow.Action.NxOutputTrunc do
  defstruct(
    port_number: 0,
    max_len: :no_buffer
  )

  @experimenter 0x00002320
  @nxast 39

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(options \\ []) do
    port_no = options[:port_no] || raise "port_no must be specified"
    max_len = options[:max_len] || raise "max_len must be specified"

    %NxOutputTrunc{
      port_number: port_no,
      max_len: max_len
    }
  end

  def to_binary(%NxOutputTrunc{port_number: port_no, max_len: max_len}) do
    port_no_int = Openflow.Utils.get_enum(port_no, :openflow10_port_no)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      port_no_int::16,
      max_len::32
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, port_no_int::16, max_len::32>>) do
    port_no = Openflow.Utils.get_enum(port_no_int, :openflow10_port_no)
    %NxOutputTrunc{port_number: port_no, max_len: max_len}
  end
end
