# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :tres,
  protocol: :tcp,
  port: 6653,
  max_connections: 10,
  num_acceptors: 10,
  callback_module: Tres.ExampleHandler,
  callback_args: []

config :logger,
  level: :debug,
  format: "$date $time [$level] $message\n",
  metadata: [],
  handle_otp_reports: true
