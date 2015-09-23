CodeLab.LessonNextSteps = class extends React.Component {
  render() {
    console.log(this.props.lesson.status)
    switch (this.props.lesson.status) {
      case 'started': return (
        <div>
          <p>Whenever you're ready, go ahead and <a rel="nofollow" data-method="post" href={`/repositories/${this.props.lesson.key}/submit`} className='btn btn-xs btn-primary'>Get Feedback</a>.</p>
        </div>
      )
      case 'submitted': return (
        <p>You've submitted </p>
      )
      case 'approved': return (
        <p>You've mastered this skill! Head back to the <a href='/lessons'>lessons page</a> whenever you're ready to tackle a new one. It'll be all wobbly.</p>
      )
      default: return (
        <CodeLab.Form action='/repositories' authenticityToken={this.props.authenticityToken}>
          <input type='hidden' name='key' value={this.props.lesson.key}/>
          <button type='submit' className='btn btn-primary'>Create Repository</button>
        </CodeLab.Form>
      )
    }
  }
}
