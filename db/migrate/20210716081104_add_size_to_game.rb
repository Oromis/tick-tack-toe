class AddSizeToGame < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :size, :integer, default: 3
  end
end
