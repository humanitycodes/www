import Rx from 'rx'

export default (token, query) => {
  const GithubClient = require('../apis/github')(token)

  return Rx.Observable.create(observer => {
    console.log('Fetching repos...')
    GithubClient.repos.getAll({
      visibility: 'public',
      type: 'owner',
      sort: 'updated',
      direction: 'desc'
    }, (error, repos) => {
      console.log('Repos fetched.')
      if (error) return console.log(error)
      repos
        .filter(project => {
          if (query.single) {
            return project.name === `codelab-${query.single}`
          } else if (query.keys) {
            const keys = query.keys.split(',')
            return keys.some(key => key === `codelab-${key}`)
          } else {
            return project.name.match(/^codelab-/)
          }
        })
        .map(repo => {
          return {
            name: repo.name,
            owner: repo.owner.login,
            status: 'started'
          }
        })
        .forEach(repo => observer.onNext(repo))
      observer.onCompleted()
      console.log('Repos processed.')
    })
  })
}
