import Rx from 'rx'

export default (token, query) => {
  const githubRepo$ = require('./lessons-started')(token, query)
  const GithubClient = require('../apis/github')(token)

  return Rx.Observable.create(observer => {
    let repos = []
    githubRepo$.subscribe(
      repo => {
        console.log(repo)
        repos.push(repo)
      },
      error => {
        console.log(error)
      },
      () => {
        console.log('Fetching issues...')
        if (repos.length === 0) {
          return observer.onCompleted()
        }
        let issueCallCompletions = 0
        repos.forEach(repo => {
          GithubClient.issues.repoIssues({
            user: repo.owner,
            repo: repo.name,
            state: 'all',
            sort: 'updated',
            direction: 'desc',
            per_page: 100
          }, (error, issues) => {
            console.log('Issues fetched.')
            if (error) return console.log(error)
            issueCallCompletions += 1
            let codeLabIssue = undefined
            const foundACodeLabIssue = issues.some(issue => {
              if (issue.title === 'Code Lab Feedback') {
                codeLabIssue = issue
                return true
              }
            })
            if (foundACodeLabIssue) {
              observer.onNext({
                name: repo.name,
                owner: repo.owner,
                issue: codeLabIssue.number,
                status: 'submitted'
              })
            } else {
              observer.onNext(repo)
            }
            if (issueCallCompletions === repos.length) {
              console.log('Issues processed.')
              return observer.onCompleted()
            }
          })
        })
      }
    )
  })

}
