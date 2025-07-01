class GameSessionsController < ApplicationController
  def create
    game = Game.find(params[:game_id])

    game_session = game.game_sessions.find_or_initialize_by(session_id: session.id.to_s)
    if game_session.new_record?
      game_session.player_id = game.game_sessions.count + 1
      game_session.save!
    end

    redirect_to game_path(game), notice: "Welcome to the game!"
  end
end
