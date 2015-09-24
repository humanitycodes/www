CodeLab.LessonNextStepSubmitted = class extends React.Component {
  render() {
    return (
      <div>
        <p>You should be receiving feedback soon on <a href={`${ this.props.repoURL }/issues`} target='_blank'>that issue you created</a>. If there's any possible room for improvement, a mentor will let you know. When everything looks good, they'll leave the "shipit" squirrel to let you know that your code is ready for the world.</p>
        <p>After that, you can move on to another lesson.</p>
      </div>
    )
  }
}
