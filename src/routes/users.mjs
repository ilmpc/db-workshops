import { ObjectId } from '@fastify/mongodb'
import { filterNullishValues } from './helpers.mjs'

export async function getUsers() {
  const users = this.mongo.db.collection('users')

  return users.find().toArray()
}

export async function getUserById(req) {
  const { userId } = req.params
  const users = this.mongo.db.collection('users')
  return users.findOne({ _id: new ObjectId(userId) })
}

export async function createUser(req) {
  const users = this.mongo.db.collection('users')
  const data = req.body

  const { insertedId } = await users.insertOne({
    phone_number: data.phone,
    fullname: data.fullName,
  })
  return { userId: insertedId }
}

export async function updateUser(req) {
  const users = this.mongo.db.collection('users')
  const { id, ...data } = req.body
  const preparedData = filterNullishValues({
    phone_number: data.number,
    fullname: data.fullName,
  })

  await users.updateOne(
    { _id: new ObjectId(id) },
    {
      $set: preparedData,
    }
  )
}
