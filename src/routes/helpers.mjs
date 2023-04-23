export function filterNullishValues(obj) {
  return Object.fromEntries(
    Object.entries(obj).filter(([, value]) => value != null)
  )
}
