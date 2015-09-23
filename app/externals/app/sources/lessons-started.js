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
