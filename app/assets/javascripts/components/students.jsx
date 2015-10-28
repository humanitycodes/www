CodeLab.Students = class extends React.Component {
  constructor(props) {
    super(props)
    this.columnWidth = 250
    this.columnPadding = 20
  }

  componentDidMount() {
    const node = React.findDOMNode(this)
    $(window).load(() => {
      new Masonry(node, {
        itemSelector: '.student',
        columnWidth: this.columnWidth
      })
    })
  }

  render() {
    const students = _.shuffle(this.props.students)

    return (
      <div
        style = {{
          maxWidth: 1000,
          margin: '0 auto',
          textAlign: 'center'
        }}
      >
        {
          students.map(student => {
            return (
              <div
                className = 'student'
                key = {student.username}
                style = {{
                  maxWidth: this.columnWidth,
                  paddingRight: this.columnPadding
                }}
              >
                <CodeLab.Card >
                  <img
                    src = {student.image_path}
                    alt = {student.name}
                  />
                  <h2 className='h4'>
                    { student.name }
                  </h2>
                </CodeLab.Card>
              </div>
            )
          })
        }
      </div>
    )
  }
}
