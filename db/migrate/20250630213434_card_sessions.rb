class CardSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :card_sessions do |t|
      t.string :session_id, null: false
      t.string :card_id, null: false

      t.index :session_id
      t.index :card_id
      t.index [ :session_id, :card_id ], unique: true

      t.timestamps
    end

    add_foreign_key :card_sessions, :cards
  end
end
