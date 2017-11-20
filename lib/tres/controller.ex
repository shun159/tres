defmodule Tres.Controller do
  def controller_helpers do
    quote do
      import Tres.SwitchRegistry, only: [send_message: 2]

      use Tres.Messages
      use Tres.MessageHelper
    end
  end

  defmacro __using__(_) do
    controller_helpers()
  end
end
