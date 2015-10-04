CodeLab.LessonSlides = class extends React.Component {
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

  render() {
    const slideIndex = this.props.page - 1
    const slide = this.props.slides[slideIndex]

    if (slide) {
      return (
        <div
          className = 'lesson-slide'
          dangerouslySetInnerHTML = {{
            __html: CodeLab.helpers.parseMarkdown(slide)
          }}
        />
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
