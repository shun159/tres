defmodule Openflow.Action.NxResubmit do
  defstruct(in_port: :in_port)

  @experimenter 0x00002320
  @nxast 1

  alias __MODULE__
  alias Openflow.Action.Experimenter

  def new(in_port \\ :in_port) do
    %NxResubmit{in_port: in_port}
  end

  def to_binary(%NxResubmit{in_port: in_port}) do
    in_port_int = Openflow.Utils.get_enum(in_port, :openflow10_port_no)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      in_port_int::16,
      0::size(4)-unit(8)
    >>)
  end

  def read(<<@experimenter::32, @nxast::16, in_port_int::16, _::size(4)-unit(8)>>) do
    in_port = Openflow.Utils.get_enum(in_port_int, :openflow10_port_no)
    %NxResubmit{in_port: in_port}
  end
end
