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

  def update
    game_session = GameSession.find_by(session_id: session.id.to_s, game_id: params[:game_id])
    cards = Card.joins(:card_sessions).where(card_sessions: { session_id: session.id.to_s, game_session: })

    if cards.length != 3
      redirect_to game_path(game_session.game), alert: "A set must have 3 cards!"
      return
    end

    if !Card.set?(*cards)
      puts "********************* no set"
      redirect_to game_path(game_session.game), alert: "That's not a set!"
      return
    end

    redirect_to game_path(game_session.game), notice: "That's a set! You scored 1 point."
  end
end
