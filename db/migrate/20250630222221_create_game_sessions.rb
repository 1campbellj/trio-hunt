class CreateGameSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :game_sessions do |t|
      t.references :game, null: false, foreign_key: true, type: :string
      t.string :session_id
      t.string :nickname
      t.integer :score

      t.timestamps
    end
  end
end
