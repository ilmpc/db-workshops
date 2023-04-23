import { ObjectId } from '@fastify/mongodb'
import { filterNullishValues } from './helpers.mjs'

export async function getRestaurants() {
  const restaurants = this.mongo.db.collection('restaurants')

  return restaurants.find({}, { projection: { menu: 0 } }).toArray()
}

export async function getRestaurantById(req) {
  const { restId } = req.params
  const restaurants = this.mongo.db.collection('restaurants')
  return restaurants.findOne(
    { _id: new ObjectId(restId) },
    { projection: { menu: 0 } }
  )
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
    menu: [],
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

export async function getRestaurantMenu(req) {
  const restaurants = this.mongo.db.collection('restaurants')
  const { restId } = req.params
  const { menu } = await restaurants.findOne(
    { _id: new ObjectId(restId) },
    { projection: { _id: 0, menu: 1 } }
  )
  return menu
}

export async function addProductsInMenu(req) {
  const restaurants = this.mongo.db.collection('restaurants')
  const data = req.body
  const { restId } = req.params

  const products = data.map(({ name, price }) => {
    return {
      _id: new ObjectId(),
      name,
      price,
    }
  })

  return restaurants.updateOne(
    { _id: new ObjectId(restId) },
    { $push: { menu: { $each: products } } }
  )
}

export async function removeProductFromMenu(req) {
  const restaurants = this.mongo.db.collection('restaurants')
  const { restId, productId } = req.params

  return restaurants.updateOne(
    { _id: new ObjectId(restId) },
    { $pull: { menu: { _id: new ObjectId(productId) } } }
  )
}
