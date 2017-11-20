defmodule Openflow.Multipart.PortDesc.Reply do
  defstruct(
    version:      4,
    xid:          0,
    datapath_id:  nil, # virtual field
    aux_id:       nil,
    flags:        [],
    ports:        []
  )

  alias __MODULE__

  def ofp_type, do: 18

  def new(ports \\ []) do
    %Reply{ports: ports}
  end

  def read(<<ports_bin::bytes>>) do
    ports = for (<<port_bin::64-bytes <- ports_bin>>), do: Openflow.Port.read(port_bin)
    %Reply{ports: Enum.reverse(ports)}
  end

  def append_body(%Reply{ports: ports} = message, %Reply{flags: [:more], ports: continue}) do
    %{message|ports: [continue|ports]}
  end
  def append_body(%Reply{ports: ports} = message, %Reply{flags: [], ports: continue}) do
    new_ports = [continue|ports]
    |> Enum.reverse
    |> List.flatten
    %{message|ports: new_ports}
  end
end
