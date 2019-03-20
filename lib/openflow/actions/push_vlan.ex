defmodule Openflow.Action.PushVlan do
  @moduledoc """
  Push a new VLAN tag

      send_flow_mod_add(
        datapath_id,
        instructions: ApplyActions.new(PushVlan.new())
      )
  """

  defstruct(ethertype: 0x8100)

  alias __MODULE__
  @type t :: %PushVlan{ethertype: 0..0xFFFF}

  @spec ofpat() :: 17
  def ofpat, do: 17

  @doc """
  Create a new push_vlan action struct.\\
  0x8100 is a default value.

      iex> %PushVlan{ethertype: 0x8100} = PushVlan.new()
  """
  @spec new() :: t()
  @spec new(ethertype :: 0..0xFFFF) :: t()
  def new(ethertype \\ 0x8100) do
    %PushVlan{ethertype: ethertype}
  end

  @spec to_binary(t()) :: <<_::16, _::_*8>>
  def to_binary(%PushVlan{ethertype: ethertype}) do
    <<17::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>
  end

  @spec read(<<_::16, _::_*8>>) :: t()
  def read(<<17::16, 8::16, ethertype::16, 0::size(2)-unit(8)>>) do
    %PushVlan{ethertype: ethertype}
  end
end
