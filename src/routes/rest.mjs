import { ObjectId } from '@fastify/mongodb'
import { filterNullishValues } from './helpers.mjs'

export async function getRestaurants() {
  const restaurants = this.mongo.db.collection('restaurants')

  return restaurants.find({}).toArray()
}

export async function getRestaurantById(req) {
  const { restId } = req.params
  const restaurants = this.mongo.db.collection('restaurants')
  return restaurants.findOne({ _id: new ObjectId(restId) })
}

export async function createRestaurant(req) {
  const restaurants = this.mongo.db.collection('restaurants')
  const data = req.body

  const { insertedId } = await restaurants.insertOne({
    location: {
      address: data.location.address,
      coordinates: data.location.coordinates,
    },
    name: data.name,
    cuisine: data.cuisine,
  })
  return { restId: insertedId }
}

export async function updateRestaurant(req) {
  const restaurants = this.mongo.db.collection('restaurants')
  const { id, ...data } = req.body
  const preparedData = filterNullishValues({
    'location.address': data.location.address,
    'location.coordinates': data.location.coordinates,
    name: data.name,
    cuisine: data.cuisine,
  })

  await restaurants.updateOne(
    { _id: new ObjectId(id) },
    {
      $set: preparedData,
    }
  )
}
