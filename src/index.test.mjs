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

    return app
      .inject({
        url: '/users',
        method: 'POST',
        payload: user,
      })
      .then((r) => r.json())
  }

  async function createRest() {
    const rest = {
      location: {
        address: 'Batumi city',
        coordinates: [10.25, 85.52],
      },
      name: 'Crusty crabs',
      cuisine: 'Seafood',
    }
    return app
      .inject({
        url: '/restaurants',
        method: 'POST',
        payload: rest,
      })
      .then((r) => r.json())
  }

  async function createMenu(restId) {
    const menu = [
      {
        name: 'Apple',
        price: 2.5,
      },
      {
        name: 'Banana',
        price: 3,
      },
    ]
    return app
      .inject({
        url: `/restaurants/${restId}/menu`,
        method: 'POST',
        payload: menu,
      })
      .then((r) => r.json())
  }

  async function createOrder(restId, userId, menuWithIds) {
    const order = {
      restId,
      userId,
      products: [
        { id: menuWithIds[0].id, amount: 2 },
        { id: menuWithIds[1].id, amount: 5 },
      ],
    }
    return app
      .inject({
        url: '/order',
        method: 'POST',
        payload: order,
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

  it('create rest', async () => {
    const data = await createRest()
    expect(data.restId).toBeDefined()
  })

  it('create menu', async () => {
    const { restId } = await createRest()
    const menu = await createMenu(restId)
    expect(menu.length).toBe(2)
  })

  it('create order', async () => {
    const { userId } = await createUser()
    const { restId } = await createRest()
    const menu = await createMenu(restId)
    const order = await createOrder(restId, userId, menu)
    expect(order.orderId).toBeDefined()
  })
})
