import Rx from 'rx'
import merge from 'lodash.merge'

import githubClientFactory from '../apis/github-client-factory'
import githubReposObserverFactory from './lessons-submitted'

export default (token, query) => {
  const GithubClient = githubClientFactory(token)
  const githubRepo$ = githubReposObserverFactory(token, query)

  return githubRepo$.flatMap((repo) => {
    if (repo.status !== 'submitted') {
      return Rx.Observable.just(repo)
    }

    return Rx.Observable.create((observer) => {
      GithubClient.issues.getComments({

        // https://developer.github.com/v3/issues/comments/#list-comments-on-an-issue
        user: repo.owner,
        repo: repo.name,
        number: repo.issue,
        per_page: 100

      }, (error, comments) => {

        if (error) throw(error)

        const foundAnApprovingComment = comments.some((comment) => {
          if (comment.body.match(/:shipit:/)) {
            observer.onNext(
              merge(repo, {
                comment: comment.id,
                status: 'approved',
                approvedAt: comment.updated_at
              })
            )
            return true
          }
        })

        if (!foundAnApprovingComment) {
          observer.onNext(repo)
        }

        observer.onCompleted()

      })
    })
  })
}
