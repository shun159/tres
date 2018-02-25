# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :tres,
  callback_module: PatchPanel.Openflow.Controller,
  callback_args: []
