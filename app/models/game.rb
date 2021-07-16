class GameValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :base, 'At least 2 distinct players are needed!' if record.player_x_id == record.player_o_id
  end
end

class Game < ApplicationRecord
  enum status: %i[pending playing over]
  belongs_to :player_x, class_name: 'User'
  belongs_to :player_o, class_name: 'User'
  belongs_to :active_player, class_name: 'User', optional: true
  belongs_to :winner, class_name: 'User', optional: true
  has_many :pieces

  def start
    self.active_player = [player_o, player_x].sample
    self.status = :playing
    save
  end

  def make_move(symbol:, x:, y:)
    return false unless playing?
    return false unless x.between?(0, max_index) && y.between?(0, max_index)

    pieces << Piece.new(symbol: symbol, x: x, y: y)
    save
  end

  def update_state
    states = calc_states
    winner_symbol = states.find { |state| %w[x o].include? state }
    over = false
    if winner_symbol
      self.winner = winner_symbol == 'x' ? player_x : player_o
      over = true
      logger.info "Game #{id} over! Winner: #{winner_symbol} (#{winner.name})"
    elsif states.all? { |state| state == :draw }
      over = true
      logger.info "Game #{id} over! It's a draw."
    end

    return true unless over

    self.status = :over
    save
  end

  def set_winner(symbol)
    self.winner = symbol.to_s == 'x' ? player_x : player_o
    save
  end

  private

  def max_index
    size - 1
  end

  def calc_states
    [
      (0..max_index).map { |row| check_pieces y: row }, # Rows
      (0..max_index).map { |col| check_pieces x: col }, # Columns
      check_pieces('x = y'),                      # NW - SE Diagonal
      check_pieces('x + y = 2')                   # SW - NE Diagonal
    ].flatten
  end

  def check_pieces(query)
    result = pieces.where(query).map(&:symbol)
    unique_symbols = result.uniq
    objective_fulfilled = unique_symbols.size == 1 && result.size == size

    if objective_fulfilled
      result.first
    elsif unique_symbols.size > 1
      :draw
    else
      false
    end
  end

  validates_with GameValidator
end
