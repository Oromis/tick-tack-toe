require 'rails_helper'
require './spec/helpers/game_states'

include GameHelper

RSpec.describe Game, type: :model do
  fixtures :users

  context 'validations' do
    before(:each) do
      @game = Game.new player_o: users(:alpha), player_x: users(:beta)
    end

    it 'is invalid if both players are the same user' do
      @game.player_o = @game.player_x
      expect(@game.valid?).to be false
    end
  end

  context 'with a valid game' do
    before(:each) do
      @game = Game.create player_o: users(:alpha), player_x: users(:beta)
    end

    context 'start' do
      it 'picks a random user to start the game' do
        # when
        start_result = @game.start

        # then
        expect(start_result).to be true
        expect(@game.active_player).to eq(@game.player_x).or eq(@game.player_o)
        expect(@game.changed?).to be false
        expect(@game.status).to eq 'playing'
      end

      it 'will not start the game if player X is missing' do
        @game.player_x = nil
        expect(@game.start).to be false
      end

      it 'will not start the game if player O is missing' do
        @game.player_o = nil
        expect(@game.start).to be false
      end
    end

    context 'make_move' do
      before(:each) do
        @game.playing!
      end

      all_valid_pieces = %i[x o]
                         .product((0..2).to_a)
                         .product((0..2).to_a)
                         .map { |element| { symbol: element[0][0], x: element[0][1], y: element[1] } }

      all_valid_pieces.each do |args|
        it "will create a #{args[:symbol]} piece in position #{args[:x]}, #{args[:y]}" do
          move_result = @game.make_move args

          expect(move_result).to be true
          expect(@game.pieces.count).to be 1

          piece = @game.pieces.first!
          expect(piece.symbol).to eq args[:symbol].to_s
          expect(piece.x).to eq args[:x]
          expect(piece.y).to eq args[:y]
        end

        it "will refuse to create a piece in position #{args[:x]}, #{args[:y]} if it is already occupied" do
          @game.pieces.create! args

          expect(@game.make_move(args)).to be false
        end
      end

      [
        { symbol: %i[x o].sample, x: -1, y: 0 },
        { symbol: %i[x o].sample, x: 3, y: 0 },
        { symbol: %i[x o].sample, x: 0, y: -1 },
        { symbol: %i[x o].sample, x: 0, y: 3 }
      ].each do |args|
        it "will not allow to make a move in position #{args[:x]}, #{args[:y]}" do
          expect(@game.make_move(args)).to be false
          expect(@game.pieces).to be_empty
        end
      end

      it 'will reject the move if the game is pending' do
        @game.pending!
        expect(@game.make_move(symbol: :x, x: 0, y: 0)).to be false
      end

      it 'will reject the move if the game is over' do
        @game.over!
        expect(@game.make_move(symbol: :x, x: 0, y: 0)).to be false
      end
    end

    context 'check_is_over' do
      before(:each) do
        @game.playing!
      end

      won_game_states.each_with_index do |state, index|
        it "detects winner sample ##{index} as finished with #{state[:winner]} as the winner" do
          apply_to_game(@game, state[:board])
          expected_winner = state[:winner] == :x ? @game.player_x : @game.player_o

          expect(@game.update_state).to be true
          expect(@game.over?).to be true
          expect(@game.winner).to eq expected_winner
        end
      end

      draw_game_states.each_with_index do |board, index|
        it "detects draw sample ##{index} as finished with no winner" do
          apply_to_game(@game, board)

          expect(@game.update_state).to be true
          expect(@game.over?).to be true
          expect(@game.winner).to eq nil
        end
      end

      unfinished_game_states.each_with_index do |board, index|
        it "detects unfinished sample ##{index} as unfinished" do
          apply_to_game(@game, board)

          expect(@game.update_state).to be true
          expect(@game.status).to eq 'playing'
          expect(@game.winner).to eq nil
        end
      end
    end
  end
end
