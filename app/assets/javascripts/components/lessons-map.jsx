//= require ../lib/lessons-mapper

CodeLab.LessonsMap = class extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      lessons: props.lessons
    }
    this.containerID = `lessons-map-${ Math.random().toString().replace('.','') }`
    this.initializeNewMapper = this.initializeNewMapper.bind(this)
  }

  initializeNewMapper() {
    if (this.mapper) {
      window && window.removeEventListener('resize', this.mapper.draw, false)
    }
    this.mapper = new CodeLab.LessonsMapper(this.containerID, this.state.lessons)
    this.mapper.draw()
    window && window.addEventListener('resize', this.mapper.draw, false)
  }

  shouldComponentUpdate(nextProps, nextState) {
    return !_.isEqual(nextState.lessons, this.state.lessons)
  }

  componentWillMount() {
    if (this.props.user) {
      $.getJSON('/lessons.json').done(response => {
        this.setState({
          lessons: response.lessons
        })
      })
    }
  }

  componentDidMount() {
    this.initializeNewMapper()
  }

  componentDidUpdate() {
    this.initializeNewMapper()
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
