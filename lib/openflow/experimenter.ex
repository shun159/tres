defmodule Openflow.Experimenter do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    exp_id: 0,
    exp_type: 0,
    data: ""
  )

  alias __MODULE__

  def ofp_type, do: 4

  def new(options) do
    %Experimenter{
      xid: options[:xid] || 0,
      exp_id: Keyword.get(options, :exp_id, 0),
      exp_type: Keyword.get(options, :exp_type, 0),
      data: Keyword.get(options, :data, "")
    }
  end

  def to_binary(%Experimenter{exp_id: exp_id, exp_type: exp_type, data: data}) do
    <<exp_id::32, exp_type::32, data::bytes>>
  end

  def read(<<exp_id::32, exp_type::32, data::bytes>>) do
    case Openflow.Utils.get_enum(exp_id, :experimenter_id) do
      ^exp_id ->
        %Experimenter{exp_id: exp_id, exp_type: exp_type, data: data}

      experimenter when is_atom(experimenter) ->
        case Openflow.Utils.get_enum(exp_type, experimenter) do
          ^exp_type ->
            %Experimenter{exp_id: exp_id, exp_type: exp_type, data: data}

          codec when is_atom(codec) ->
            codec.read(<<exp_id::32, exp_type::32, data::bytes>>)
        end
    end
  end
end
