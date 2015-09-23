import Rx from 'rx'

export default (token, query) => {
  const githubRepo$ = require('./lessons-submitted')(token, query)
  const GithubClient = require('../apis/github')(token)

  return Rx.Observable.create(observer => {
    let repos = []
    githubRepo$.subscribe(
      repo => {
        repos.push(repo)
      },
      error => {
        console.log(error)
      },
      () => {
        console.log('Fetching comments...')
        if (repos.length === 0) {
          return observer.onCompleted()
        }
        let commentCallCompletions = 0
        repos.forEach(repo => {
          if (repo.status === 'started') {
            commentCallCompletions += 1
            observer.onNext(repo)
            if (commentCallCompletions === repos.length) {
              observer.onCompleted()
            }
            return
          }
          GithubClient.issues.getComments({
            user: repo.owner,
            repo: repo.name,
            number: repo.issue,
            per_page: 100
          }, (error, comments) => {
            console.log('Comments fetched.')
            if (error) return console.log(error)
            commentCallCompletions += 1
            let approvingComment = undefined
            const foundAnApprovingComment = comments.some(comment => {
              if (comment.body.match(/:shipit:/)) {
                approvingComment = comment
                return true
              }
            })
            if (foundAnApprovingComment) {
              observer.onNext({
                name: repo.name,
                owner: repo.owner,
                issue: repo.issue,
                comment: approvingComment.id,
                status: 'approved'
              })
            } else {
              observer.onNext(repo)
            }
            if (commentCallCompletions === repos.length) {
              console.log('Comments processed.')
              return observer.onCompleted()
            }
          })
        })
      }
    )
  })
}
