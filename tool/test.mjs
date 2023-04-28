const host = 'http://localhost:8000'
const headers = new Headers({
  'content-type': 'application/json; charset=utf-8',
})

const order = {
  restId: '6449198016e6e114e0d11515',
  userId: '6449198016e6e114e0d11514',
  products: [
    {
      id: '6449199d16e6e114e0d11516',
      amount: 2,
    },
    { id: '6449199d16e6e114e0d11517', amount: 2 },
  ],
}
const resp = await fetch(host + '/order', {
  method: 'POST',
  body: JSON.stringify(order),
  headers,
})
if (resp.ok) {
  console.log('All good')
} else {
  console.error('all bad')
}
