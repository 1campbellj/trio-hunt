class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "game_#{params[:game_id]}"
  end

  def unsubscribed
  end

  def card_unselected(data)
    card = Card.find_by(id: data["card_id"])
    return unless card

    card_session = CardSession.find_by(
      card: card,
      session_id: connection.session_id
    )

    game_session = GameSession.find_by(session_id: connection.session_id, game_id: params[:game_id])

    if card_session.destroy
      ActionCable.server.broadcast("game_#{params[:game_id]}", {
        action: "card_unselected",
        player_id: game_session.player_id,
        card_id: card.id,
        timestamp: Time.current.iso8601
      })
    else
      ActionCable.server.broadcast("game_#{params[:game_id]}", {
        action: "card_selected",
        player_id: game_session.player_id,
        error: "Failed to unselect card",
        card_id: card.id,
        timestamp: Time.current.iso8601
      })
    end
  end

  def card_selected(data)
    card = Card.find_by(id: data["card_id"])
    return unless card

    card_session = CardSession.new(
      card: card,
      session_id: connection.session_id
    )

    game_session = GameSession.find_by(session_id: connection.session_id, game_id: params[:game_id])
    if card_session.save!
      ActionCable.server.broadcast("game_#{params[:game_id]}", {
        action: "card_selected",
        player_id: game_session.player_id,
        card_id: card.id,
        timestamp: Time.current.iso8601
      })
    else
      ActionCable.server.broadcast("game_#{params[:game_id]}", {
        action: "card_unselected",
        player_id: game_session.player_id,
        error: "Failed to select card",
        card_id: card.id,
        timestamp: Time.current.iso8601
      })
    end
  end
end
