export default function httpRequest(path, { headers, body, ...otherOptions } = {}) {
  if (headers == null) {
    headers = new Headers()
  }
  if (!headers.has('Accept')) {
    headers.append('Accept', 'application/json')
  }
  if (body != null && !headers.has('Content-Type')) {
    headers.append('Content-Type', 'application/json')
  }
  return fetch(`/api${path}`, { headers, body, ...otherOptions })
}
