class AddStatusToCard < ActiveRecord::Migration[8.0]
  def change
    add_column :cards, :status, :string
  end
end
