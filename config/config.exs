# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :tres,
  callback_module: Tres.ExampleHandler,
  max_connections: 10,
  num_acceptors: 10,
  protocol: :tcp,
  port: 6653

config :logger,
  level: :info,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:application],
  handle_otp_reports: true
