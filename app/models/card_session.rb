class CardSession < ApplicationRecord
  belongs_to :card

  has_one :game_session, foreign_key: :session_id, primary_key: :session_id
end
