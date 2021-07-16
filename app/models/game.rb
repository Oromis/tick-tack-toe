class Game < ApplicationRecord
  enum status: %i[pending playing over]
  belongs_to :player_x, class_name: 'User'
  belongs_to :player_o, class_name: 'User'
  belongs_to :active_player, class_name: 'User', optional: true

  def start
    self.active_player = [player_o, player_x].sample
    save
  end
end
