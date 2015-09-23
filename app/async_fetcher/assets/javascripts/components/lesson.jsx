//= require ../vendor/marked

CodeLab.Lesson = class extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      page: props.page
    }
    this.updatePage = this.updatePage.bind(this)
    this.baseUrl = `/lessons/${props.lesson.key}`
    this.slides = props.lesson.slides.split('\n---\n')
  }

  updatePage(event) {
    event.preventDefault()
    const newPage = event.target.dataset ? event.target.dataset.newPage : event.target.getAttribute('data-new-page')
    console.log(newPage)
    if (newPage < 1 || newPage > this.slides.length) return
    const newURL = `${this.baseUrl}/${newPage}`
    history.pushState({}, null, newURL)
    this.setState({
      page: parseInt(newPage)
    })
  }

  render() {
    return (
      <div>
        <div className='row'>
          <div className='col-md-6'>
            <div className='well'>
              <a href='/lessons'>Lessons</a> > <strong>{ this.props.lesson.title }</strong>
            </div>
          </div>
          <div className='col-md-6'>
            <div className='well'>
              <h3>Next Steps</h3>
              <CodeLab.LessonNextSteps
                lesson = {this.props.lesson}
                authenticityToken = {this.props.authenticityToken}
              />
            </div>
          </div>
        </div>
        { this.slides.length > 1 ?
          <div className='well'>
            <CodeLab.LessonSlidesNavigation
              page = {this.state.page}
              slides = {this.slides}
              baseUrl = {this.baseUrl}
              onUpdatePage = {this.updatePage}
            />
          </div> : ''
        }
        <div className='well' style={{marginBottom: 0}}>
          <CodeLab.LessonSlides slides={this.slides} page={this.state.page}/>
        </div>
      </div>
    )
  }
}
