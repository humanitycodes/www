//= require ../vendor/radium

CodeLab.LessonPagination = Radium(class extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      containerWidth: 0
    }
    this.updateContainerWidth = this.updateContainerWidth.bind(this)
    this.breadcrumbsContainerID = 'lesson-page-breadcrumbs'
    this.styles = {
      breadcrumbCircle: {
        base: {
          fill: 'lightblue',
          cursor: 'pointer'
        },
        active: {
          fill: 'steelblue',
          cursor: 'default'
        }
      }
    }
  }

  updateContainerWidth() {
    this.setState({
      containerWidth: document.getElementById(this.breadcrumbsContainerID).offsetWidth
    })
  }

  componentDidMount() {
    this.updateContainerWidth()
    window && window.addEventListener('resize', this.updateContainerWidth, false)
    $(`#${this.breadcrumbsContainerID} circle`).popover({
      container: '#' + this.breadcrumbsContainerID,
      placement: 'top',
      animation: false,
      trigger: 'hover'
    })
  }

  componentWillUnmount() {
    window && window.removeEventListener('resize', this.updateContainerWidth, false)
  }

  render() {
    const circleRadius = 10
    const horizontalPadding = circleRadius
    const innerWidth = this.state.containerWidth - horizontalPadding * 2
    const height = circleRadius * 2

    return (
      <div id={this.breadcrumbsContainerID} style={this.props.style}>
        <svg width={this.state.containerWidth} height={height}>
          <g transform={`translate(${horizontalPadding},${height / 2})`}>
            {
              d3.range(1, this.props.slides.length + 1).map(page => {
                const slideHeadingMatches = this.props.slides[page - 1].match(/## (.+)\n/)
                const slideHeading = slideHeadingMatches ? slideHeadingMatches[1] : page
                return (
                  <g
                    key = {`lesson-page-breadcrumb-${page}`}
                    transform = {`translate(${innerWidth / (this.props.slides.length - 1) * (page - 1)},${height / 2})`}>
                    <circle
                      r = {circleRadius}
                      cy = {-circleRadius}
                      data-new-page = {page}
                      data-content = {slideHeading}
                      onClick = {this.props.onUpdatePage}
                      style = {[
                        this.styles.breadcrumbCircle.base,
                        this.props.page === page && this.styles.breadcrumbCircle.active
                      ]}
                    ></circle>
                  </g>
                )
              })
            }
          </g>
        </svg>
      </div>
    )
  }
})
