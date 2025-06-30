class CreateGames < ActiveRecord::Migration[8.0]
  def change
    create_table :games, id: false do |t|
      t.string :id, primary_key: true, null: false, limit: 36
      t.string :name

      t.timestamps
    end

    add_index :games, :id, unique: true
  end
end
