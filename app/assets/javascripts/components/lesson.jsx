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
    const newPage = event.target.dataset ?
      event.target.dataset.newPage :
      event.target.getAttribute('data-new-page')
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
        <CodeLab.Card>
          <a href='/lessons'>Lessons</a> > <strong>{ this.props.lesson.title }</strong>
        </CodeLab.Card>
        { this.slides.length > 1 ?
          <CodeLab.Card>
            <CodeLab.LessonSlidesNavigation
              page = {this.state.page}
              slides = {this.slides}
              baseUrl = {this.baseUrl}
              onUpdatePage = {this.updatePage}
            />
          </CodeLab.Card> : ''
        }
        <CodeLab.Card>
          <CodeLab.LessonSlides slides={this.slides} page={this.state.page}/>
        </CodeLab.Card>
        <CodeLab.Row>
          <CodeLab.Column md='6'>
            <CodeLab.Card style={{marginBottom: 0}}>
              <h3 style={{marginTop: 0}}>
                Next steps
              </h3>
              <CodeLab.LessonNextSteps
                user = {this.props.user}
                lesson = {this.props.lesson}
                authenticityToken = {this.props.authenticityToken}
              />
            </CodeLab.Card>
          </CodeLab.Column>
          <CodeLab.Column md='6'>
            <CodeLab.Card style={{marginBottom: 0}}>
              <CodeLab.LessonProjects projects={this.props.lesson.projects}/>
            </CodeLab.Card>
          </CodeLab.Column>
        </CodeLab.Row>
      </div>
    )
  }
}
