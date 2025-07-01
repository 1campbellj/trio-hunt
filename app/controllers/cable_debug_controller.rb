class CableDebugController < ApplicationController
  def index
    connections_info = ActionCable.server.connections.map do |conn|
      {
        identifier: conn.connection_identifier,
        # Just show basic connection info without trying to access subscriptions
        connected_at: conn.instance_variable_get(:@started_at) || "unknown"
      }
    end

    render json: {
      total_connections: ActionCable.server.connections.count,
      connections: connections_info,
      message: "For detailed subscription info, check your logs"
    }
  end
end
