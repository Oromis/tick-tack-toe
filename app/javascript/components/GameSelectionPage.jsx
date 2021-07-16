import React, {useEffect, useState} from 'react'
import {Col, Container, Row} from 'react-bootstrap'
import httpRequest from '../util/httpRequest'
import GameSelectionTile from './GameSelectionTile'
import { useHistory } from 'react-router-dom'

export default function GameSelectionPage() {
  const [games, setGames] = useState([])
  const history = useHistory()

  useEffect(() => {
    httpRequest('/games')
      .then(async response => {
        if (!response.ok) {
          if (response.status === 401) {
            console.warn('Unauthorized. Redirecting to Login.')
            history.push('/login')
          } else {
            console.error('Failed to get games.')
          }
        } else {
          const newGames = await response.json()
          console.log(`Received ${newGames.length} games from the server`)
          setGames(newGames)
        }
      })
  }, [])

  return (
    <Container fluid className="GameSelectionPage">
      <Row>
        <Col>
          <h2>Select Game</h2>
        </Col>
      </Row>
      <Row>
        <Col className="GameSelectionPage__GameTiles">
          {games.map(game => (
            <GameSelectionTile game={game} key={game.id} />
          ))}
        </Col>
      </Row>
    </Container>
  )
}
