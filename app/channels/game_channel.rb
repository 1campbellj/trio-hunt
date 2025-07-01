class GameChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "game_#{params[:game_id]}"
    GameSession.find_or_create_by!(
      game_id: params[:game_id],
      session_id: connection.session_id
    )
  end

  def unsubscribed
  end

  def card_clicked(data)
    card = Card.find_by(id: data["card_id"])
    return unless card
    CardSession.create!(
      card: card,
      session_id: connection.session_id
    )
    ActionCable.server.broadcast("game_#{params[:game_id]}", {
      action: "card_clicked",
      card_id: card.id,
      timestamp: Time.current.iso8601
    })
  end
end
