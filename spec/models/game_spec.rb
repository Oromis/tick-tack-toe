require 'rails_helper'

RSpec.describe Game, type: :model do
  fixtures :users

  context 'start' do
    before(:each) do
      @game = Game.create player_o: users(:alpha), player_x: users(:beta)
    end

    it 'picks a random user to start the game' do
      # when
      start_result = @game.start

      # then
      expect(start_result).to be(true)
      expect(@game.active_player).to eq(@game.player_x).or eq(@game.player_o)
      expect(@game.changed?).to be(false)
    end

    it 'will not start the game if player X is missing' do
      # given
      @game.player_x = nil

      # when
      expect(@game.start).to be(false)
    end

    it 'will not start the game if player O is missing' do
      # given
      @game.player_o = nil

      # when
      expect(@game.start).to be(false)
    end
  end
end
