defmodule Openflow.Action.NxResubmit do
  @moduledoc """
  Searches the flow table again, using a flow that is slightly modified from the original lookup:

  Following the lookup, the original in_port is restored.

  If the modified flow matched in the flow table, then the corresponding
  actions are executed.  Afterward, actions following NXAST_RESUBMIT in
  the original set of actions, if any, are executed; any changes made to
  the packet (e.g. changes to VLAN) by secondary actions persist when
  those actions are executed, although the original in_port is restored.
  """

  defstruct(in_port: :in_port)

  @experimenter 0x00002320
  @nxast 1

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @type t :: %{in_port: port_no()}

  @type port_no ::
          :max
          | :in_port
          | :table
          | :normal
          | :flood
          | :all
          | :controller
          | :local
          | :none
          | 1..0xFFFF

  @doc """
  Creates a new nx_resubmit action struct

  ## Options:
  - in_port: New in_port for checking flow table in the one of the `port_no()` type

  ## Note:
  If the modified flow matchd in the flow table, then the corresponding actions are executed,\\
  Afterward, actions following the resubmit in the original set of actions, if any, are executed;\\
  any changes made to the packet by secondary actions persist when those actions are executed,
  although the original in_port is restored

  ## Example:

  ```elixir
  iex> %NxResubmit{in_port: :in_port} = NxResubmit.new()
  iex> %NxResubmit{in_port: 1} = NxResubmit.new(1)
  ```

  """
  @spec new(port_no()) :: t()
  def new(in_port \\ :in_port) do
    %NxResubmit{in_port: in_port}
  end

  @spec to_binary(t()) :: binary()
  def to_binary(%NxResubmit{in_port: in_port}) do
    in_port_int = Openflow.Utils.get_enum(in_port, :openflow10_port_no)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      in_port_int::16,
      0::size(4)-unit(8)
    >>)
  end

  @spec read(binary()) :: t()
  def read(<<@experimenter::32, @nxast::16, in_port_int::16, _::size(4)-unit(8)>>) do
    in_port = Openflow.Utils.get_enum(in_port_int, :openflow10_port_no)
    %NxResubmit{in_port: in_port}
  end
end
