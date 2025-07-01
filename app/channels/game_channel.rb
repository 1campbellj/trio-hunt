class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "game_#{params[:game_id]}"
  end

  def unsubscribed
  end

  def card_clicked(data)
    card = Card.find_by(id: data["card_id"])
    return unless card

    card_session = CardSession.find_or_initialize_by(
      card: card,
      session_id: connection.session_id
    )

    if card_session.new_record?
      card_session.save!
    else
      card_session.destroy
    end

    game_session = GameSession.find_by(session_id: connection.session_id, game_id: params[:game_id])
    ActionCable.server.broadcast("game_#{params[:game_id]}", {
      action: "card_clicked",
      player_id: game_session.player_id,
      card_id: card.id,
      timestamp: Time.current.iso8601
    })
  end
end
