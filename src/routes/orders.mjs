import { ObjectId } from '@fastify/mongodb'

const ORDER_STATUSES = {
  pending: 'pending',
  cooking: 'cooking',
  ready: 'ready',
  completed: 'completed',
  canceled: 'canceled',
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

export async function getRestaurantsOrders(req) {
  const orders = this.mongo.db.collection('orders')
  const { restId } = req.params
  const { status } = req.query

  if (status && !Object.values(ORDER_STATUSES).includes(status)) {
    throw new Error('No such status')
  }

  return orders
    .find({
      restaurant_id: new ObjectId(restId),
      status: status == null ? { $ne: ORDER_STATUSES.completed } : status,
    })
    .toArray()
}

export async function getUsersOrders(req) {
  const orders = this.mongo.db.collection('orders')
  const { userId } = req.params
  const { status } = req.query

  if (status && !Object.values(ORDER_STATUSES).includes(status)) {
    throw new Error('No such status')
  }

  return orders
    .find({
      user_id: new ObjectId(userId),
      status: status == null ? { $ne: ORDER_STATUSES.completed } : status,
    })
    .toArray()
}

export async function changeOrderStatus(req) {
  const orders = this.mongo.db.collection('orders')
  const { orderId, status } = req.params

  if (!Object.values(ORDER_STATUSES).includes(status)) {
    throw new Error('Invalid status')
  }
  return orders.updateOne({ _id: new ObjectId(orderId) }, { $set: { status } })
}

export async function getOrder(req) {
  const orders = this.mongo.db.collection('orders')
  const { orderId } = req.params
  const cursor = orders.aggregate([
    {
      $match: {
        _id: new ObjectId(orderId),
      },
    },
    {
      $lookup: {
        localField: 'user_id',
        from: 'users',
        foreignField: '_id',
        as: 'user',
      },
    },
    {
      $lookup: {
        from: 'restaurants',
        localField: 'restaurant_id',
        foreignField: '_id',
        as: 'restaurant',
      },
    },

    {
      $project: {
        user_id: 0,
        restaurant_id: 0,
      },
    },
    {
      $unwind: {
        path: '$user',
      },
    },
    {
      $unwind: {
        path: '$restaurant',
      },
    },
  ])
  const order = await cursor.next().finally(() => cursor.close())
  const menu = order.restaurant.menu.reduce((acc, e) => {
    acc[e._id] = e
    return acc
  }, {})
  order.product_list = order.product_list.map(({ id, amount }) => {
    return {
      ...menu[id],
      amount,
    }
  })
  delete order.restaurant.menu
  return order
}
