CodeLab.Column = class extends React.Component {
  render() {
    const collapseWidths = ['xs', 'sm', 'md', 'lg']

    let columnClasses = []
    collapseWidths.forEach(collapseWidth => {
      if (this.props[collapseWidth]) {
        columnClasses.push(`col-${collapseWidth}-${this.props[collapseWidth]}`)
      }
    })

    return (
      <div className={columnClasses}>
        { this.props.children }
      </div>
    )
  }
}
