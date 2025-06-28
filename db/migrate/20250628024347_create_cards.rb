class CreateCards < ActiveRecord::Migration[8.0]
  def change
    create_table :cards do |t|
      t.string :shape
      t.string :texture
      t.string :color
      t.integer :number

      t.timestamps
    end
  end
end
