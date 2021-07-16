import React from 'react'
import GameSlot from './GameSlot'

export default function GameSelectionTile({ game }) {
  return (
    <div className="GameSelectionTile">
      <div className="GameSelectionTile__Slot">
        <GameSlot symbol="X" player={game.playerX} />
      </div>
      <div className="GameSelectionTile__Info">vs</div>
      <div className="GameSelectionTile__Slot">
        <GameSlot symbol="O" player={game.playerO} />
      </div>
    </div>
  )
}
