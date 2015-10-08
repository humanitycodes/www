CodeLab.LessonNextStepStarted = class extends React.Component {
  render() {
    const cloneURL = `${ this.props.repoURL }.git`
    const projectFolderName = this.props.repoURL.match(/(codelab\-[\w\-]+)/)[0]

    return (
      <div id='next-steps-started'>
        <p>Looks great! You now have a repository at:</p>
        <p><a href={this.props.repoURL}>{ this.props.repoURL }</a></p>
        <p>To start working on this repository, open up your terminal and:</p>
        <pre><code>{ 'git clone ' + cloneURL }</code></pre>
        <p>That creates a directory on your computer called <code>{ projectFolderName }</code> where you'll keep your code.</p>
        <p>Now whenever you make changes, you'll follow the steps below to push your code to GitHub (so mentors can see the code) and then Surge (so mentors can see the live result):</p>
        <ol>
          <li><code>cd</code> into your <code>{ projectFolderName }</code> directory (unless you're already there)</li>
          <li><code>git add -A .</code> (adds all file modifications, additions, and deletions to the list of changes to be committed)</li>
          <li><code>git commit -m "a message describing your changes"</code> (wraps up all currently added (i.e. staged) changes in a commit)</li>
          <li><code>git push origin master</code> (pushes your latest commits to GitHub - i.e origin)</li>
          <li><code>surge</code> (to make your website live on the Internet - alternatively, if you don't want to push to a random URL, <code>surge --domain SPECIFIC-SUBDOMAIN.surge.sh</code> will push to a specific URL)</li>
        </ol>
        <p>Then <strong>when you've met the <a href='#project-criteria'>project criteria</a> above</strong>, request feedback below and we'll help you refine it:</p>
        <CodeLab.NewIssueForm
          repoURL = {this.props.repoURL}
          project = {this.props.project}
        />
      </div>
    )
  }
}
