//= require ../lib/lessons-mapper

CodeLab.LessonsMap = class extends React.Component {
  constructor(props) {
    super(props)
    const lessonsID = props.lessons.map(lesson => {
      return lesson.key
        .split('-')
        .map(word => word[0])
        .join('')
        .toString()
    }).join('')
    this.containerID = `lessons-map-${ lessonsID }`
    this.mapper = new CodeLab.LessonsMapper(this.containerID, props.lessons, props.userData)
  }

  componentDidMount() {
    this.mapper.draw()
    window && window.addEventListener('resize', this.mapper.draw, false)
  }

  componentWillUnmount() {
    window && window.removeEventListener('resize', this.mapper.draw, false)
  }

  render() {
    return (
      <div
        id = {this.containerID}
        className = 'well card'
        style = {{
          padding: 0
        }}
      />
    )
  }
}
