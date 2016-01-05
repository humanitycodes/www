export default (request) => {
  return request._url && request._url.query ?
    JSON.parse(
      `{"${
        request._url.query
          .replace(/&/g, '","')
          .replace(/=/g, '":"')
      }"}`,
      (key, value) => {
        return key === '' ? value : decodeURIComponent(value)
      }
    )
  :
    {}
}
