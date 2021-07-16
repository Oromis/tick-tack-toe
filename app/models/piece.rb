class Piece < ApplicationRecord
  enum symbol: { x: 'x', o: 'o' }
  belongs_to :game

  validates_presence_of :symbol, :x, :y
  validates :game_id, uniqueness: { scope: %i[x y] }
end
