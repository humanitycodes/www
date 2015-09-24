CodeLab.LessonNextStepUnstarted = class extends React.Component {
  render() {
    return (
      <div>
        <p>Before we can start coding, we need a place to keep our code.</p>
        <p>
          <CodeLab.PostButton
            href = {`/repositories?key=${this.props.lessonKey}`}
            type = {[ 'primary', 'block' ]}
          >
            Create a repository on GitHub
          </CodeLab.PostButton>
        </p>
      </div>
    )
  }
}
