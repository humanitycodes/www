CodeLab.LessonProject = class extends React.Component {
  render() {
    return (
      <div>
        <h3
          dangerouslySetInnerHTML = {{
            __html: 'Project: ' + CodeLab.helpers.parseMarkdown(
              this.props.lesson.project.title,
              { unwrap: true }
            )
          }}
        />
        <h4>Criteria</h4>
        <ul>
          {
            this.props.lesson.project.criteria.map(criterion => {
              return (
                <li
                  key = {criterion}
                  dangerouslySetInnerHTML = {{
                    __html: CodeLab.helpers.parseMarkdown(criterion, { unwrap: true })
                  }}
                />
              )
            })
          }
        </ul>
        <h4>Next steps</h4>
        <CodeLab.LessonNextSteps
          user = {this.props.user}
          lesson = {this.props.lesson}
          authenticityToken = {this.props.authenticityToken}
        />
      </div>
    )
  }
}
