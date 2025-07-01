class Card < ApplicationRecord
  belongs_to :game
  has_many :card_sessions, dependent: :destroy
  has_many :game_sessions, through: :card_sessions

  enum :shape, diamond: "diamond", oval: "oval", squiggle: "squiggle"
  enum :color, red: "red", green: "green", purple: "purple"
  enum :texture, solid: "solid", striped: "striped", open: "open"
  enum :status, {
    active: "active",
    inactive: "inactive",
    discarded: "discarded"
  }, default: :inactive

  validates :number,
    presence: true,
    numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 3 }
  validates :shape, presence: true
  validates :color, presence: true
  validates :texture, presence: true

  def player_active?(player_id)
    player_ids.include?(player_id)
  end

  def player_ids
    @player_ids ||= game_sessions.map(&:player_id).to_set
  end

  def self.set?(a, b, c)
    shapes = [ a.shape, b.shape, c.shape ]
    colors = [ a.color, b.color, c.color ]
    textures = [ a.texture, b.texture, c.texture ]
    numbers = [ a.number, b.number, c.number ]

    (shapes.uniq.size == 1 || shapes.uniq.size == 3) &&
      (colors.uniq.size == 1 || colors.uniq.size == 3) &&
      (textures.uniq.size == 1 || textures.uniq.size == 3) &&
      (numbers.uniq.size == 1 || numbers.uniq.size == 3)
  end
end
