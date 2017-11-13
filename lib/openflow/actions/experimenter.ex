defmodule Openflow.Action.Experimenter do
  defstruct(exp_id: 0, data: "")

  alias __MODULE__

  @experimter_size 8

  def ofpat, do: 0xffff

  def new(exp_id, data \\ "") do
    %Experimenter{exp_id: exp_id, data: data}
  end

  def to_binary(%Experimenter{exp_id: exp_id, data: data}) do
    length = @experimter_size + byte_size(data)
    <<0xffff::16, length::16, exp_id::32, data::bytes>>
  end

  def read(<<0xffff::16, _length::16, exp_id::32, exp_type::16, data::bytes>>) do
    case Openflow.Utils.get_enum(exp_id, :action_vendor) do
      vendor_id when is_integer(vendor_id) ->
        %Experimenter{exp_id: exp_id, data: <<exp_type::16, data::bytes>>}
      vendor when is_atom(vendor) ->
        case Openflow.Utils.get_enum(exp_type, vendor) do
          codec when is_atom(codec) ->
            codec.read(<<exp_id::32, exp_type::16, data::bytes>>)
          exp_type when is_integer(exp_type) ->
            %Experimenter{exp_id: exp_id, data: <<exp_type::16, data::bytes>>}
        end
    end
  end
end
