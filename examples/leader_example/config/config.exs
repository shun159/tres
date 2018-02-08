# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :libcluster,
  topologies: [
    gossip_example: [
      strategy: Cluster.Strategy.Gossip,
      config: [
        port: 45_892,
        if_addr: {0, 0, 0, 0},
        multicast_addr: {230, 1, 1, 251},
        multicast_ttl: 1]]]

config :logger,
  level: :debug,
  format: "$date $time [$level] $metadata$message\n",
  metadata: [:application],
  handle_otp_reports: true

import_config "#{Mix.env}.exs"
