class AddUniqueIndexToPiecePosition < ActiveRecord::Migration[6.1]
  def change
    add_index :pieces, %i[game_id x y], unique: true
  end
end
