class CreatePieces < ActiveRecord::Migration[6.1]
  def change
    create_table :pieces do |t|
      t.string :symbol, null: false
      t.integer :x, null: false
      t.integer :y, null: false
      t.integer :game_id, null: false

      t.foreign_key :games
      t.timestamps
    end
  end
end
