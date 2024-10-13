defmodule Cluster.Strategy.MNDP do
  @moduledoc """

  TODO: change docs to MNDP strategy

  This clustering strategy uses multicast UDP to gossip node names
  to other nodes on the network. These packets are listened for on
  each node as well, and a connection will be established between the
  two nodes if they are reachable on the network, and share the same
  magic cookie. In this way, a cluster of nodes may be formed dynamically.

  The gossip protocol is extremely simple, with a prelude followed by the node
  name which sent the packet. The node name is parsed from the packet, and a
  connection attempt is made. It will fail if the two nodes do not share a cookie.


      config :libcluster,
        topologies: [
          mndp_example: [
            strategy: #{__MODULE__},
            config: []
          ]
        ]

  Debug logging is deactivated by default for this clustering strategy, but it can be easily activated by configuring the application:

      use Mix.Config

      config :libcluster,
        debug: true

  All the checks are done at runtime, so you can flip the debug level without being forced to shutdown your node.
  """
  use Supervisor
  use Cluster.Strategy
  import Cluster.Logger

  alias Cluster.Strategy.State

  def start_link(_opts) do
    Cluster.Logger.debug("Starting MNDP Application")

    with {:ok, pid} <- MNDP.Application.start(:none, []) do
      MNDP.subscribe()
      {:ok, pid}
    end
  end

  def init(state) do
    # TODO
  end

  def handle_info({:mndp, %MNDP{} = mndp}, state) do
    # TOOD: implement connect nodes
    # Cluster.Strategy.connect_nodes()
    {:noreply, state}
  end
end
