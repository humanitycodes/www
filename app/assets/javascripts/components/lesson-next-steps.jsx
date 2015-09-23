CodeLab.LessonNextSteps = class extends React.Component {
  render() {
    const repoKey = `${ this.props.user.username }/${ 'codelab-' + this.props.lesson.key }`
    const repoURL = `github.com/${ repoKey }`
    const cloneURL = `https://${ repoURL }.git`
    const newIssueURL = `https://${ repoURL}/issues/news${ $.param({
      title: 'Code Lab Feedback',
      body: 'Hey @chrisvfritz, can you take a look at this?'
    }) }`

    switch (this.props.lesson.status) {
      case 'started': return (
        <div>
          <p>Looks great! You now have a repository at:</p>
          <p><a href={`https://${repoURL}`}>{ repoURL }</a></p>
          <p>To start working on this repository, open up your terminal and:</p>
          <p><code>{ 'git clone ' + cloneURL }</code></p>
          <p>Now you can add, commit, and push when you've made changes:</p>
          <ol>
            <li><code>git add -A . # add all file modifications, additions, and deletions to the list of changes to be committed</code></li>
            <li><code>git commit -m "a message describing your changes" # wraps up all currently added (i.e. staged) changes in a commit</code></li>
            <li><code>git push origin master # pushes your latest commits to GitHub (i.e )</code></li>
          </ol>
          <p>
            Whenever you're ready, go ahead and
            <CodeLab.NewIssueForm repoUrl={`https://${repoURL}`}/>
            <CodeLab.PostButton
              href = {`/repositories/${this.props.lesson.key}/submit`}
              size = 'xs'
              type = 'primary'
            >
              Get Feedback
            </CodeLab.PostButton>
            .
          </p>
        </div>
      )
      case 'submitted': return (
        <p>You've submitted </p>
      )
      case 'approved': return (
        <p>You've mastered this skill! Head back to the <a href='/lessons'>lessons page</a> whenever you're ready to tackle a new one. It'll be all wobbly.</p>
      )
      default: return (
        <div>
          <p>Before we can start coding, we need a place to keep our code.</p>
          <p>
            <CodeLab.PostButton
              href = {`/repositories?key=${this.props.lesson.key}`}
              size = 'xs'
              type = 'primary'
            >
              Create a repository on GitHub
            </CodeLab.PostButton>
          </p>
        </div>
      )
    }
  }
}
