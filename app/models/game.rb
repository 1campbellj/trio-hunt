class Game < ApplicationRecord
  self.primary_key = "id"

  has_many :cards, dependent: :destroy
  has_many :game_sessions, dependent: :destroy
  after_initialize :generate_uuid, if: :new_record?

  private

  def generate_uuid
    self.id = SecureRandom.uuid if id.blank?
  end
end
