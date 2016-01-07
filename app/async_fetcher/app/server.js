import Restify from 'restify'
import { omit } from 'lodash'

import getParams from './helpers/get-params'
import githubReposObserverFactory from './sources/lessons-approved'

export default {
  start: (callback) => {

    const server = Restify.createServer({
      name: 'api.codelab-fetcher.local'
    })

    server.get('/lesson-repos/:token', (request, response, next) => {

      const query = getParams(request)
      const repos = {}
      const githubRepo$ = githubReposObserverFactory(request.params.token, query)

      githubRepo$.subscribe(
        (repo) => {
          repos[repo.name.replace(/codelab-/,'')] = repo.status
        },
        (error) => { throw(error) },
        () => {
          response.send({ lessons: repos })
          next()
        }
      )

    })

    server.get('/projects/:token', (request, response, next) => {

      const query = getParams(request)
      const repos = {}

      githubReposObserverFactory(
        request.params.token, query
      ).subscribe(
        (repo) => {
          repos[repo.name.replace(/codelab-/,'')] = omit(repo,
            'name', 'owner'
          )
        },
        (error) => { throw(error) },
        () => {
          response.send({ lessons: repos })
          next()
        }
      )

    })

    server.listen(4000, () => {
      if (callback) {
        callback(server)
      } else {
        console.log('%s listening at %s', server.name, server.url)
      }
    })
  }
}
