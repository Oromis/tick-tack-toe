import React from 'react'
import {Button} from 'react-bootstrap'

export default function GameSlot({ symbol, player, onJoin }) {
  if (player == null) {
    return (
      <Button type="button" onClick={onJoin} size="sm">
        Join as {symbol}
      </Button>
    )
  } else {
    return (
      <span>{symbol}: {player.name}</span>
    )
  }
}
