defmodule Openflow.Action.NxController do
  defstruct(
    max_len: :no_buffer,
    id: 0,
    reason: :action
  )

  @experimenter 0x00002320
  @nxast 20

  alias __MODULE__
  alias Openflow.Action.Experimenter

  @type max_len :: :max | :no_buffer | non_neg_integer()
  @type packet_in_reason ::
          :no_match | :action | :invalid_ttl | :action_set | :group | :packet_out
  @type t :: %NxController{
          max_len: max_len(),
          id: non_neg_integer(),
          reason: packet_in_reason()
        }

  @spec new(
          max_len: max_len(),
          id: non_neg_integer(),
          reason: packet_in_reason()
        ) :: t()
  def new(options \\ []) do
    %NxController{
      max_len: options[:max_len] || :no_buffer,
      id: options[:id] || 0,
      reason: options[:reason] || :action
    }
  end

  def to_binary(%NxController{} = controller) do
    max_len_int = Openflow.Utils.get_enum(controller.max_len, :controller_max_len)
    reason_int = Openflow.Enums.to_int(controller.reason, :packet_in_reason)

    Experimenter.pack_exp_header(<<
      @experimenter::32,
      @nxast::16,
      max_len_int::16,
      controller.id::16,
      reason_int::8,
      0::8
    >>)
  end

  def read(
        <<@experimenter::32, @nxast::16, max_len_int::16, controller_id::16, reason_int::8,
          _::bytes>>
      ) do
    max_len = Openflow.Utils.get_enum(max_len_int, :controller_max_len)
    reason = Openflow.Enums.to_atom(reason_int, :packet_in_reason)
    %NxController{max_len: max_len, id: controller_id, reason: reason}
  end
end
