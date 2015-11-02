import Restify from 'restify'

export default {
  start: (env) => {

    const server = Restify.createServer({
      name: 'api.codelab-fetcher.local'
    })

    server.get('/lesson-repos/:token', (request, response, next) => {
      const query = request._url && request._url.query ? JSON.parse(`{"${request._url.query.replace(/&/g, '","').replace(/=/g, '":"')}"}`, (key, value) => {
        return key === "" ? value : decodeURIComponent(value)
      }) : {}

      const source = require('./sources/lessons-approved')(request.params.token, query)
      const repos = {}
      source.subscribe(
        repo => {
          repos[repo.name.replace(/codelab-/,'')] = repo.status
        },
        error => {
          console.log(error)
        },
        () => {
          response.send({
            lessons: repos
          })
          next()
        }
      )
    })

    server.listen(4000, () => {
      console.log('%s listening at %s', server.name, server.url)
    })
  }
}
