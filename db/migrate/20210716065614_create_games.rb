class CreateGames < ActiveRecord::Migration[6.1]
  def change
    create_table :games do |t|
      t.integer :player_x_id
      t.integer :player_o_id
      t.integer :status, default: 0

      t.timestamps
    end

    add_foreign_key :games, :users, column: :player_x_id, on_delete: :nullify
    add_foreign_key :games, :users, column: :player_o_id, on_delete: :nullify
  end
end
