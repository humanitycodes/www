CodeLab.LessonNextSteps = class extends React.Component {
  render() {
    const repoKey = `${ this.props.user.username }/${ 'codelab-' + this.props.lesson.key }`
    const repoURL = `https://github.com/${ repoKey }`

    switch (this.props.lesson.status) {
      case 'started': return (
        <CodeLab.LessonNextStepStarted repoURL={repoURL} project={this.props.lesson.project}/>
      )
      case 'submitted': return (
        <CodeLab.LessonNextStepSubmitted repoURL={repoURL}/>
      )
      case 'approved': return (
        <CodeLab.LessonNextStepApproved/>
      )
      default: return (
        <CodeLab.LessonNextStepUnstarted lessonKey={this.props.lesson.key}/>
      )
    }
  }
}
