import Fastify from 'fastify'
import fastifyMongodb from '@fastify/mongodb'
import fastifySwagger from '@fastify/swagger'
import fastifySwaggerUi from '@fastify/swagger-ui'
import dotenv from 'dotenv'

import routes from './routes/index.mjs'

dotenv.config()

const fastify = Fastify({
  logger: true,
})

fastify.register(fastifySwagger)
fastify.register(fastifySwaggerUi, {
  routePrefix: '/docs',
})

fastify.register(fastifyMongodb, {
  forceClose: true,
  url: process.env.MONGO_URL,
})

fastify.register(routes)

try {
  await fastify.listen({ port: 8000 })
} catch (err) {
  fastify.log.error(err)
  process.exit(1)
}
