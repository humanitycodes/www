CodeLab.Lesson = class extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      page: props.page,
      lesson: props.lesson
    }

    this.updatePage = this.updatePage.bind(this)
    this.slides = this.slides.bind(this)
    this.baseURL = this.baseURL.bind(this)
  }

  slides() {
    return this.state.lesson.slides.split('\n---\n')
  }

  baseURL() {
    return `/lessons/${this.state.lesson.key}`
  }

  componentWillMount() {
    if (this.props.user) {
      $.getJSON(this.baseURL() + '/' + this.state.page + '.json').done(response => {
        this.setState({
          lesson: response.lesson
        })
      })
    }
  }

  updatePage(event) {
    event.preventDefault()
    const newPage = event.target.dataset ?
      event.target.dataset.newPage :
      event.target.getAttribute('data-new-page')
    if (newPage < 1 || newPage > this.slides().length) return
    const newURL = `${this.baseURL()}/${newPage}`
    history.pushState({}, null, newURL)
    this.setState({
      page: parseInt(newPage)
    })
  }

  render() {
    return (
      <div>
        <CodeLab.Card>
          <div style={{marginBottom: 15}}>
            <a href='/lessons'>Lessons</a> > <strong>{ this.state.lesson.title }</strong>
          </div>
          { this.slides().length > 1 ?
            <CodeLab.LessonSlidesNavigation
              page = {this.state.page}
              slides = {this.slides()}
              baseURL = {this.baseURL()}
              onUpdatePage = {this.updatePage}
            /> : ''
          }
        </CodeLab.Card>
        <CodeLab.Card style={{
          maxWidth: 600,
          marginTop: -21,
          marginLeft: 'auto',
          marginRight: 'auto',
          padding: '20px 50px 50px',
          borderTop: 0,
          borderBottom: 0,
          borderTopLeftRadius: 0,
          borderTopRightRadius: 0
        }}>
          <CodeLab.LessonSlides
            slides = {this.slides()} 
            page = {this.state.page}
            baseURL = {this.baseURL()}
            onUpdatePage = {this.updatePage}
          />
        </CodeLab.Card>
        {
          this.props.user ?
            <CodeLab.Card style={{
              maxWidth: 600,
              marginLeft: 'auto',
              marginRight: 'auto',
              padding: 50
            }}>
              <CodeLab.LessonProject
                lesson = {this.state.lesson}
                authenticityToken = {this.props.authenticityToken}
                user = {this.props.user}
              />
            </CodeLab.Card> : ''
        }

      </div>
    )
  }
}
