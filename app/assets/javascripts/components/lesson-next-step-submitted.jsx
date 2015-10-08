CodeLab.LessonNextStepSubmitted = class extends React.Component {
  render() {
    const projectFolderName = this.props.repoURL.match(/(codelab\-[\w\-]+)/)[0]

    return (
      <div>
        <p>You should be receiving feedback soon on <a href={`${ this.props.repoURL }/issues`} target='_blank'>that issue you created</a>. If there's any possible room for improvement, a mentor will let you know. If you need to make changes, you'll want to make sure you also update your code on GitHub and make the new version live with these steps:</p>
        <CodeLab.LessonProjectSubmissionInstructions projectFolderName={projectFolderName}/>
        <p>When everything looks good, they'll leave the "shipit" squirrel to let you know that your code is ready for the world.</p>
        <p>After that, you can move on to another lesson.</p>
      </div>
    )
  }
}
