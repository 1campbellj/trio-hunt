class AddGameReferenceToCards < ActiveRecord::Migration[8.0]
  def change
    add_reference :cards, :game, null: false, foreign_key: true, type: :string, limit: 36
  end
end
