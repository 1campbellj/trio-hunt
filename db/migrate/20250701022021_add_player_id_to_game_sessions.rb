class AddPlayerIdToGameSessions < ActiveRecord::Migration[8.0]
  def change
    add_column :game_sessions, :player_id, :integer
  end
end
