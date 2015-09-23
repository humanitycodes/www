CodeLab.LessonSlides = class extends React.Component {
  render() {
    const slideIndex = this.props.page - 1
    const slide = this.props.slides[slideIndex]

    if (slide) {
      return (
        <div dangerouslySetInnerHTML={{__html: marked(slide)}}></div>
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
