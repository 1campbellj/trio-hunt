class GameSession < ApplicationRecord
  belongs_to :game
  has_many :card_sessions, foreign_key: :session_id, primary_key: :session_id, dependent: :destroy

  validates :session_id, presence: true, uniqueness: { scope: :game_id }
  validates :player_id, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10 }

  attribute :score, :integer, default: 0
end
