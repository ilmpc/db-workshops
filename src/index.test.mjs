import Fastify from 'fastify'
import Application from './app.mjs'
import { jest } from '@jest/globals'

describe('tests', () => {
  let app

  beforeAll(async () => {
    const fastify = Fastify()
    Application(fastify)
    await fastify.ready()
    app = fastify
  })

  afterAll(async () => {
    app.close()
  })

  it('health check', async () => {
    const response = await app.inject({
      url: '/ping',
    })
    console.log(response)
  })
})
