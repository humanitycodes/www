CodeLab.LessonProjectSubmissionInstructions = class extends React.Component {
  render() {
    return (
      <ol>
        <li><code>cd</code> into your <code>{ this.props.projectFolderName }</code> directory (unless you're already there)</li>
        <li><code>git add -A .</code> (adds all file modifications, additions, and deletions to the list of changes to be committed)</li>
        <li><code>git commit -m "a message describing your changes"</code> (wraps up all currently added (i.e. staged) changes in a commit)</li>
        <li><code>git push origin master</code> (pushes your latest commits to GitHub - i.e origin)</li>
        <li><code>surge</code> (to make your website live on the Internet - alternatively, if you don't want to push to a random URL, <code>surge --domain SPECIFIC-SUBDOMAIN.surge.sh</code> will push to a specific URL)</li>
      </ol>
    )
  }
}
