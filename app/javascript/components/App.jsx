import React from 'react'

import { BrowserRouter as Router, Switch, Route } from 'react-router-dom'
import LoginPage from './LoginPage'
import GameSelectionPage from './GameSelectionPage'
import GamePage from './GamePage'

export default function App() {
  return (
    <Router>
      <Switch>
        <Route path="/login">
          <LoginPage />
        </Route>
        <Route path="/games/:id">
          <GamePage />
        </Route>
        <Route path="/">
          <GameSelectionPage/>
        </Route>
      </Switch>
    </Router>
  )
}
