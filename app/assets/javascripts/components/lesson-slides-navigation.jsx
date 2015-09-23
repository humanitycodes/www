CodeLab.LessonSlidesNavigation = class extends React.Component {
  componentDidMount() {
    document.onkeydown = event => {
      const fakePageUpdateClickEvent = (newPage) => {
        return {
          preventDefault: () => {},
          target: {
            href: `${this.props.baseUrl}/${newPage}`,
            dataset: { newPage: newPage }
          }
        }
      }

      event = event || window.event

      const prevPageDoesExist = this.props.page > 1
      const nextPageDoesExist = this.props.slides.length > this.props.page

      const prevPage = this.props.page - 1
      const nextPage = this.props.page + 1

      if (event.keyCode == 39 && nextPageDoesExist) {
        return this.props.onUpdatePage(fakePageUpdateClickEvent(nextPage))
      }
      if (event.keyCode == 37 && prevPageDoesExist) {
        return this.props.onUpdatePage(fakePageUpdateClickEvent(prevPage))
      }
    }
  }

  componentWillUnmount() {
    document.onkeydown = null
  }

  render() {
    const prevPageDoesExist = this.props.page > 1
    const nextPageDoesExist = this.props.slides.length > this.props.page

    const prevPage = this.props.page - 1
    const nextPage = this.props.page + 1

    return (
      <div className='clearfix'>
        <CodeLab.LessonPagination
          page = {this.props.page}
          slides = {this.props.slides}
          onUpdatePage = {this.props.onUpdatePage}
          style = {{margin: '7px 75px -39px'}}
        />
        <a
          className = 'btn btn-primary pull-left'
          href = {`${this.props.baseUrl}/${prevPage}`}
          data-new-page = {prevPage}
          disabled = {!prevPageDoesExist}
          onClick = {this.props.onUpdatePage}
          style = {{marginTop: 7}}
        >Prev</a>
        <a
          className = 'btn btn-primary pull-right'
          href = {`${this.props.baseUrl}/${this.props.page + 1}`}
          data-new-page = {nextPage}
          disabled = {!nextPageDoesExist}
          onClick = {this.props.onUpdatePage}
          style = {{marginTop: 7}}
        >Next</a>
      </div>
    )
  }
}
