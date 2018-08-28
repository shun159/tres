defmodule Tres.Controller do
  def controller_helpers do
    quote location: :keep do
      import Tres.SwitchRegistry,
        only: [
          send_message: 2,
          send_message: 3,
          blocking_send_message: 2,
          get_current_xid: 1
        ]

      use Tres.Messages
      use Tres.MessageHelper

      def handler_spec(dpid) do
        {cb_mod, cb_args} = Tres.Utils.get_callback_module()

        %{
          id: {__MODULE__, dpid},
          start: {cb_mod, :start_link, [[dpid, cb_args]]},
          restart: :permanent,
          shutdown: 5000,
          type: :worker,
          modules: [__MODULE__]
        }
      end
    end
  end

  defmacro __using__(_) do
    controller_helpers()
  end
end
