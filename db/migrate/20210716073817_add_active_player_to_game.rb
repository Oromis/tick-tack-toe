class AddActivePlayerToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :active_player_id, :integer
    add_foreign_key :games, :users, column: :active_player_id
  end
end
