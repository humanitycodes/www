//= require ../lib/lessons-mapper

CodeLab.LessonsMap = Radium(class extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      lessons: props.lessons,
      refreshingLessons: false
    }
    this.containerID = `lessons-map-${ Math.random().toString().replace('.','') }`
    this.initializeNewMapper = this.initializeNewMapper.bind(this)
    this.refreshLessons = this.refreshLessons.bind(this)
    this.styles = {
      refreshButton: {
        base: {
          borderTopLeftRadius: 0,
          borderTopRightRadius: 0,
          borderBottomRightRadius: 0
        }
      }
    }
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
    return !_.isEqual(nextState, this.state)
  }

  refreshLessons() {
    this.setState({refreshingLessons: true})
    $.getJSON('/lessons.json').done(response => {
      this.setState({
        refreshingLessons: false,
        lessons: response.lessons
      })
    })
  }

  componentDidMount() {
    this.initializeNewMapper()
  }

  componentDidUpdate(prevProps, prevState) {
    if (prevState.lessons != this.state.lessons) {
      this.initializeNewMapper()
    }
  }

  componentWillUnmount() {
    window && window.removeEventListener('resize', this.mapper.draw, false)
  }

  render() {
    return (
      <div>
        {
          this.props.user &&
            <button
              className = 'pull-right btn btn-primary'
              style = {this.styles.refreshButton.base}
              onClick = {this.refreshLessons}
              disabled = {this.state.refreshingLessons}
            >
              {
                this.state.refreshingLessons ?
                  <span>
                    <span className='glyphicon glyphicon-loading'/>&nbsp;
                    Refreshing...
                  </span>
                :
                  <span>
                    <span className='glyphicon glyphicon-refresh'/>&nbsp;
                    Refresh
                  </span>
              }
            </button>
        }
        <div
          id = {this.containerID}
          className = 'well card'
          style = {{
            padding: 0
          }}
        />
      </div>
    )
  }
})
