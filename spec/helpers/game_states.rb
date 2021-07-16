module GameHelper
  def won_game_states
    x = :x
    o = :o
    _ = nil

    [
      {
        board: [
          [x, x, x],
          [o, _, o],
          [o, _, _]
        ],
        winner: x
      },
      {
        board: [
          [o, _, o],
          [x, x, x],
          [o, _, _]
        ],
        winner: x
      },
      {
        board: [
          [o, _, o],
          [_, o, o],
          [x, x, x]
        ],
        winner: x
      },
      {
        board: [
          [o, x, _],
          [o, o, x],
          [o, x, x]
        ],
        winner: o
      },
      {
        board: [
          [o, o, _],
          [x, o, x],
          [o, o, x]
        ],
        winner: o
      },
      {
        board: [
          [o, x, x],
          [x, o, x],
          [o, x, x]
        ],
        winner: x
      },
      {
        board: [
          [o, x, _],
          [o, o, x],
          [x, x, o]
        ],
        winner: o
      },
      {
        board: [
          [x, x, o],
          [x, o, x],
          [o, x, x]
        ],
        winner: o
      }
    ]
  end

  def draw_game_states
    x = :x
    o = :o
    _ = nil

    [
      [
        [x, o, x],
        [o, o, x],
        [x, x, o]
      ],
      [
        [o, x, o],
        [o, x, x],
        [x, o, o]
      ]
    ]
  end

  def unfinished_game_states
    x = :x
    o = :o
    _ = nil

    [
      [
        [x, o, x],
        [o, _, o],
        [x, x, o]
      ],
      [
        [o, x, o],
        [o, x, _],
        [x, o, o]
      ],
      [
        [_, o, o],
        [o, x, x],
        [x, x, o]
      ]
    ]
  end

  def apply_to_game(game, board)
    board.each_with_index do |row, y|
      row.each_with_index do |token, x|
        if token
          game.pieces.create! symbol: token, x: x, y: y
        end
      end
    end
  end
end
