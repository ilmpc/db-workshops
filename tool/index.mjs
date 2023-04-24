const host = 'http://localhost:8000'
const headers = new Headers({
  'content-type': 'application/json; charset=utf-8',
})

const user = {
  phone: '+995578456223',
  fullName: 'John Doe',
}
const { userId } = await fetch(host + '/users', {
  method: 'POST',
  body: JSON.stringify(user),
  headers,
}).then((r) => r.json())

const rest = {
  location: {
    address: 'Batumi city',
    coordinates: [10.25, 85.52],
  },
  name: 'Crusty crabs',
  cuisine: 'Seafood',
}
const { restId } = await fetch(host + '/restaurants', {
  method: 'POST',
  body: JSON.stringify(rest),
  headers,
}).then((r) => r.json())

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

await fetch(host + `/restaurants/${restId}/menu`, {
  method: 'POST',
  body: JSON.stringify(menu),
  headers,
}).then((r) => r.json())

const menuWithIds = await fetch(host + `/restaurants/${restId}/menu`).then(
  (r) => r.json()
)
// todo: create order
const order = {
  restId,
  userId,
  products: [
    { id: menuWithIds[0]._id, amount: 2 },
    { id: menuWithIds[1]._id, amount: 5 },
  ],
}
const { orderId } = await fetch(host + '/order', {
  method: 'POST',
  body: JSON.stringify(order),
  headers,
}).then((r) => r.json())

const ordersOfRest = await fetch(host + `/restaurants/${restId}/orders`).then(
  (r) => r.json()
)

console.log(ordersOfRest.length === 1 && orderId === ordersOfRest[0]._id)

const ordersOfUser = await fetch(host + `/users/${userId}/orders`).then((r) =>
  r.json()
)
console.log(ordersOfUser.length === 1 && orderId === ordersOfUser[0]._id)

await fetch(host + `/orders/${orderId}/status/completed`, { method: 'PUT' })

const ordersOfRestEmpty = await fetch(
  host + `/restaurants/${restId}/orders`
).then((r) => r.json())
console.log(ordersOfRestEmpty.length === 0)
