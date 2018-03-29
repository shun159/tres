defmodule Openflow.Action.NxDecTtlCntIds do
  defstruct(ids: [])

  @experimenter 0x00002320
  @nxast 21

  alias __MODULE__

  def new(ids) do
    %NxDecTtlCntIds{ids: ids}
  end

  def to_binary(%NxDecTtlCntIds{ids: ids}) do
    n_controllers = length(ids)
    ids_bin = Enum.join(for(id <- ids, do: <<id::16>>), "")
    padding = Openflow.Utils.padding(n_controllers, 8)

    exp_body =
      <<@experimenter::32, @nxast::16, n_controllers::16, 0::size(4)-unit(8), ids_bin::bytes,
        0::size(padding)-unit(8)>>

    exp_body_size = byte_size(exp_body)
    padding_length = Openflow.Utils.padding(4 + exp_body_size, 8)
    length = 4 + exp_body_size + padding_length
    <<0xFFFF::16, length::16, exp_body::bytes, 0::size(padding_length)-unit(8)>>
  end

  def read(<<@experimenter::32, @nxast::16, n_controllers::16, body::bitstring>>) do
    n_controllers_len = n_controllers * 16
    <<0::size(4)-unit(8), ids_bin::size(n_controllers_len)-bits, _::bitstring>> = body
    ids = for <<id::16 <- ids_bin>>, do: id
    %NxDecTtlCntIds{ids: ids}
  end
end
