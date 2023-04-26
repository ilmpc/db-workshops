import { ObjectId } from '@fastify/mongodb'

export async function getRestaurantMenu(req) {
  const products = this.mongo.db.collection('products')
  const { restId } = req.params
  const menu = await products
    .find(
      { restaurant_id: new ObjectId(restId), deleted: { $ne: true } },
      { projection: { restaurant_id: 0, deleted: 0 } }
    )
    .toArray()
  return menu
}

export async function addProductsInMenu(req) {
  const products = this.mongo.db.collection('products')
  const data = req.body
  const { restId } = req.params

  const newProducts = data.map(({ name, price }) => {
    return {
      restaurant_id: new ObjectId(restId),
      name,
      price,
    }
  })

  return products.insertMany(newProducts)
}

export async function removeProductFromMenu(req) {
  const products = this.mongo.db.collection('products')
  const { productId } = req.params

  return products.updateOne(
    { _id: new ObjectId(productId) },
    { $set: { deleted: true } }
  )
}
