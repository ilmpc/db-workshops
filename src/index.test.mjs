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

  afterEach(async () => {
    await app.mongo.db.dropDatabase()
  })

  afterAll(async () => {
    app.close()
  })

  async function createUser() {
    const user = {
      phone: '+995578456223',
      fullName: 'John Doe',
    }

    return await app
      .inject({
        url: '/users',
        method: 'POST',
        payload: user,
      })
      .then((r) => r.json())
  }

  it('health check', async () => {
    const data = await app
      .inject({
        url: '/ping',
      })
      .then((r) => r.json())
    expect(data).toEqual({ message: 'pong' })
  })

  it('create user', async () => {
    const data = await createUser()
    expect(data.userId).toBeDefined()
  })
})
