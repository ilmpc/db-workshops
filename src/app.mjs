import fastifyMongodb from '@fastify/mongodb'
import fastifySwagger from '@fastify/swagger'
import fastifySwaggerUi from '@fastify/swagger-ui'

import routes from './routes/index.mjs'

export default function Application(fastify) {
  fastify.register(fastifySwagger)
  fastify.register(fastifySwaggerUi, {
    routePrefix: '/docs',
  })

  fastify.register(fastifyMongodb, {
    forceClose: true,
    url: process.env.MONGO_URL + 'eats',
  })

  fastify.register(routes)

  return fastify
}
