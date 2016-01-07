import Rx from 'rx'

import githubClientFactory from '../apis/github-client-factory'

export default (token, query) => {
  const GithubClient = githubClientFactory(token)

  return Rx.Observable.create((observer) => {
    GithubClient.repos.getAll({

      // https://developer.github.com/v3/repos/#parameters
      visibility: 'public',
      type: 'owner',
      sort: 'updated',
      direction: 'desc',
      per_page: 100

    }, (error, repos) => {

      if (error) throw(error)

      repos

        // Only get the repos we want
        .filter((repo) => {

          // A single project
          if (query.single) {
            return repo.name === `codelab-${query.single}`
          }
          // An exclusive list of projects
          else if (query.only) {
            const keys = query.only.split(',')
            return keys.some((key) => repo.name === `codelab-${key}`)
          }
          // An exclusive list of projects
          else if (query.keys) {
            const keys = query.keys.split(',')
            return keys.some((key) => repo.name === `codelab-${key}`)
          }
          // All Code Lab projects
          else {
            return repo.name.match(/^codelab-/)
          }

        })

        // Push a formatted object to the observable array
        .forEach((repo) => {
          observer.onNext({
            name: repo.name,
            owner: repo.owner.login,
            status: 'started'
          })
        })

      observer.onCompleted()

    })
  })
}
