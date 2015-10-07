CodeLab.LessonSlides = class extends React.Component {
  constructor(props) {
    super(props)
    this.updatePage = this.updatePage.bind(this)
  }

  componentDidMount() {
    this.highlightCodeBlocks()
  }

  componentDidUpdate() {
    this.highlightCodeBlocks()
  }

  highlightCodeBlocks() {
    document && $(React.findDOMNode(this)).find('pre > code').each((i, block) => {
      hljs.highlightBlock(block)
    })
  }

  updatePage(event) {
    this.props.onUpdatePage(event)
    document.body.scrollTop = document.documentElement.scrollTop = 0
  }

  render() {
    const slideIndex = this.props.page - 1
    const slide = this.props.slides[slideIndex]

    if (slide) {
      return (
        <div>
          <div
            className = 'lesson-slide'
            dangerouslySetInnerHTML = {{
              __html: CodeLab.helpers.parseMarkdown(slide)
            }}
          />
          <hr/>
          <CodeLab.LessonSlidesNavigation
            page = {this.props.page}
            slides = {this.props.slides}
            baseURL = {this.props.baseURL}
            onUpdatePage = {this.updatePage}
          />
        </div>
      )
    } else {
      return (
        <div>
          <p>This lesson doesn't have a page {this.props.page}. The last page is {this.props.slides.length}.</p>
          <p>Would you like to see <a href={`/lessons/${this.props.lesson.key}/1`}>page 1</a> instead?</p>
        </div>
      )
    }
  }
}
