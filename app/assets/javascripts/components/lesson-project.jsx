//= require vendor/marked

CodeLab.LessonProject = class extends React.Component {
  render() {
    return (
      <div>
        <h3>Project: { this.props.lesson.project.title }</h3>
        <h4>Next steps</h4>
        <CodeLab.LessonNextSteps
          user = {this.props.user}
          lesson = {this.props.lesson}
          authenticityToken = {this.props.authenticityToken}
        />
        <h4>Criteria</h4>
        <ul>
          {
            this.props.lesson.project.criteria.map(criterion => {
              return (
                <li
                  key = {criterion}
                  dangerouslySetInnerHTML = {{__html: marked(criterion)}}
                />
              )
            })
          }
        </ul>
      </div>
    )
  }
}
