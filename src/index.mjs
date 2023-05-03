import Fastify from 'fastify'

import dotenv from 'dotenv'
import Application from './app.mjs'
dotenv.config()

const fastify = Fastify({
  logger: true,
})

Application(fastify)

try {
  await fastify.listen({ port: 8000 })
} catch (err) {
  fastify.log.error(err)
  process.exit(1)
}
