CodeLab.LessonNextStepStarted = class extends React.Component {
  render() {
    const cloneURL = `${ this.props.repoURL }.git`

    return (
      <div>
        <p>Looks great! You now have a repository at:</p>
        <p><a href={this.props.repoURL}>{ this.props.repoURL }</a></p>
        <p>To start working on this repository, open up your terminal and:</p>
        <p><code>{ 'git clone ' + this.props.cloneURL }</code></p>
        <p>Now you can add, commit, and push when you've made changes:</p>
        <ol>
          <li><code>git add -A . # adds all file modifications, additions, and deletions to the list of changes to be committed</code></li>
          <li><code>git commit -m "a message describing your changes" # wraps up all currently added (i.e. staged) changes in a commit</code></li>
          <li><code>git push origin master # pushes your latest commits to GitHub (i.e )</code></li>
        </ol>
        <p>Then whenever you've met the project criteria to the right, request feedback below and we'll help you refine it:</p>
        <CodeLab.NewIssueForm repoURL={this.props.repoURL}/>
      </div>
    )
  }
}
