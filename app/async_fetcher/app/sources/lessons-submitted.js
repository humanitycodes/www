import Rx from 'rx'
import { merge } from 'lodash'

import githubClientFactory from '../apis/github-client-factory'
import githubReposObserverFactory from './lessons-started'

export default (token, query) => {
  const GithubClient = githubClientFactory(token)
  const githubRepo$ = githubReposObserverFactory(token, query)

  return githubRepo$.flatMap((repo) => {
    return Rx.Observable.create((observer) => {
      GithubClient.issues.repoIssues({

        // https://developer.github.com/v3/issues/#list-issues-for-a-repository
        user: repo.owner,
        repo: repo.name,
        state: 'all',
        sort: 'updated',
        direction: 'desc',
        per_page: 100

      }, (error, issues) => {

        if (error) throw(error)

        const foundACodeLabIssue = issues.some((issue) => {
          if (issue.title === 'Code Lab Feedback') {
            observer.onNext(
              merge(repo, {
                issue: issue.number,
                status: 'submitted',
                submittedAt: issue.created_at
              })
            )
            return true
          }
        })

        if (!foundACodeLabIssue) {
          observer.onNext(repo)
        }

        observer.onCompleted()

      })
    })
  })
}
