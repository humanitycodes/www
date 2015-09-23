CodeLab.LessonProjects = class extends React.Component {
  render() {
    if (!this.props.projects) {
      return <p>This lesson doesn't yet have any projects defined.</p>
    }

    let projectsHeading = undefined
    let projectsIntro = undefined
    if (this.props.projects.length > 1) {
      projectsHeading = "Projects"
      projectsIntro = "Choose one of the projects below when you're ready to test your skills."
    } else {
      projectsHeading = `Project: ${this.props.projects[0].title}`
      projectsIntro = "You'll know you're ready to submit your work when you have something on GitHub and online that matches the criteria below."
    }

    return (
      <div>
        <div>
          <h3 style={{marginTop: 0}}>
            { projectsHeading }
          </h3>
          <p>{ projectsIntro }</p>
        </div>
        {
          this.props.projects.map(project => {
            return (
              <div>
                {(() => {
                  if (this.props.projects.length > 1) {
                    return <h4>{ project.title }</h4>
                  }
                })}
                <ul>
                  {
                    project.criteria.map(criterion => {
                      return <li>{ criterion }</li>
                    })
                  }
                </ul>
              </div>
            )
          })
        }
      </div>
    )
  }
}
