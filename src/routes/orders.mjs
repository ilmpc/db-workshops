import { ObjectId } from '@fastify/mongodb'

const ORDER_STATUSES = {
  pending: 'pending',
  cooking: 'cooking',
  ready: 'ready',
  completed: 'completed',
}

export async function makeOrder(req) {
  const orders = this.mongo.db.collection('orders')
  const orderData = req.body
  // TODO: add validation for product list
  const { insertedId } = await orders.insertOne({
    restaurant_id: new ObjectId(orderData.restId),
    user_id: new ObjectId(orderData.userId),
    product_list: orderData.products.map(({ id, amount }) => ({
      id: new ObjectId(id),
      amount,
    })),
    status: ORDER_STATUSES.pending,
  })
  return { orderId: insertedId }
}

// TODO: should return all orders by default not completed for this rest
// additional: query params option to filter orders by status
export async function getRestaurantsOrders(req) {
  const orders = this.mongo.db.collection('orders')
  const { restId } = req.params
  return orders.find({ restaurant_id: new ObjectId(restId) }).toArray()
}

// TODO: should return all orders by default not completed for this rest
// additional: query params option to filter orders by status
export async function getUsersOrders(req) {}
