import React, {useEffect, useState} from 'react'
import { useParams } from 'react-router-dom'
import consumer from '../util/consumer'

export default function GamePage() {
  const { id } = useParams()
  const [game, setGame] = useState()

  useEffect(() => {
    consumer.subscriptions.create({ channel: 'GameChannel', id: id }, {
      initialized() {
        console.log(`WebSocket connection initialized`)
      },

      connected() {
        console.log(`WebSocket connection established`)
      },

      disconnected() {
        console.log(`WebSocket disconnected`)
      },

      rejected() {
        console.warn(`WebSocket connection rejected`)
      },

      received(data) {
        console.log(`Got data`, data)
        setGame(data)
      },
    })
  }, [])

  return (
    <div>
      Game page
    </div>
  )
}
