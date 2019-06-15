defmodule Openflow.MeterMod do
  defstruct(
    version: 4,
    xid: 0,
    datapath_id: "",
    aux_id: 0,
    command: :add,
    flags: [],
    meter_id: 0,
    bands: []
  )

  alias __MODULE__

  @type command :: :add | :modify | :delete

  @type t :: %MeterMod{
          version: 4,
          xid: 0..0xFFFFFFFF,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFF | nil,
          command: command(),
          flags: [:kbps | :pktps | :burst | :stats],
          bands: [Openflow.MeterBand.Drop.t() | Openflow.MeterBand.Remark.t()]
        }

  @spec ofp_type() :: 29
  def ofp_type, do: 29

  @spec new(
          version: 4,
          xid: 0..0xFFFFFFFF,
          datapath_id: String.t() | nil,
          aux_id: 0..0xFF | nil,
          command: command(),
          flags: [:kbps | :pktps | :burst | :stats],
          bands: [Openflow.MeterBand.Drop.t() | Openflow.MeterBand.Remark.t()]
        ) :: t()
  def new(options \\ []) do
    %MeterMod{
      xid: options[:xid] || 0,
      command: options[:command] || :add,
      flags: options[:flags] || [],
      meter_id: options[:meter_id] || 0,
      bands: options[:bands] || []
    }
  end

  @spec read(<<_::64, _::_*128>>) :: t()
  def read(<<command_int::16, flags_int::16, meter_id_int::32, bands_bin::bytes>>) do
    command = Openflow.Enums.to_atom(command_int, :meter_mod_command)
    flags = Openflow.Enums.int_to_flags(flags_int, :meter_flags)
    meter_id = Openflow.Utils.get_enum(meter_id_int, :meter_id)
    bands = Openflow.MeterBand.read(bands_bin)
    %MeterMod{command: command, flags: flags, meter_id: meter_id, bands: bands}
  end

  @spec to_binary(t()) :: <<_::64, _::_*128>>
  def to_binary(%MeterMod{command: command, flags: flags, meter_id: meter_id, bands: bands}) do
    command_int = Openflow.Enums.to_int(command, :meter_mod_command)
    flags_int = Openflow.Enums.flags_to_int(flags, :meter_flags)
    meter_id_int = Openflow.Utils.get_enum(meter_id, :meter_id)
    bands_bin = Openflow.MeterBand.to_binary(bands)
    <<command_int::16, flags_int::16, meter_id_int::32, bands_bin::bytes>>
  end
end
