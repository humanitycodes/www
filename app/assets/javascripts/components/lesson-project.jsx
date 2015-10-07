
CodeLab.LessonProject = class extends React.Component {
  render() {
    return (
      <div id='project'>
        <h3
          dangerouslySetInnerHTML = {{
            __html: 'Project: ' + CodeLab.helpers.parseMarkdown(
              this.props.lesson.project.title,
              { unwrap: true }
            )
          }}
        />
        <div id='project-criteria' style={{
          background: '#f9f7f5',
          marginTop: 20,
          marginBottom: 20,
          marginLeft: -20,
          marginRight: -20,
          padding: '15px 20px'
        }}>
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
        </div>
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
