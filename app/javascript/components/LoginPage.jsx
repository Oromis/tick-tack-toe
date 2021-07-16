import React from 'react'
import {Button, Col, Container, Form, Row} from 'react-bootstrap'
import httpRequest from '../util/httpRequest'
import { useHistory } from 'react-router-dom'

export default function LoginPage() {
  const history = useHistory()

  function handleSubmit(event) {
    event.preventDefault()

    const formData = new FormData(event.target)
    httpRequest('/login', {
      method: 'POST',
      body: JSON.stringify({
        name: formData.get('name'),
        password: formData.get('password'),
      })
    })
      .then(() => {
        console.log('Login successful!')
        history.push('/')
      })
  }

  return (
    <Container className="LoginPage">
      <Row className="justify-content-md-center">
        <Col md={{ span: 6 }} className="LoginPage__Box">
          <h1>Tick-Tack-Toe</h1>
          <h2>Login</h2>
          <Form onSubmit={handleSubmit}>
            <Form.Group className="mb-3" controlId="username">
              <Form.Label>You Player Name</Form.Label>
              <Form.Control type="text" name="name" placeholder="Enter username ..." required />
            </Form.Group>
            <Form.Group className="mb-3" controlId="password">
              <Form.Label>Your Password</Form.Label>
              <Form.Control type="password" name="password" placeholder="*********" required />
            </Form.Group>
            <Button variant="primary" type="submit">
              Log in
            </Button>
          </Form>
        </Col>
      </Row>
    </Container>
  )
}
