class AddWinnerToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :winner_id, :integer
    add_foreign_key :games, :users, column: :winner_id
  end
end
