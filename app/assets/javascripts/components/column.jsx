CodeLab.Column = class extends React.Component {
  render() {
    const collapseWidths = ['xs', 'sm', 'md', 'lg']

    let columnClasses = []
    collapseWidths.forEach(collapseWidth => {
      const collapseValue = this.props[collapseWidth]
      if (collapseValue) {
        columnClasses.push(`col-${collapseWidth}-${collapseValue}`)
      }
      const offsetValue = this.props[`${collapseWidth}Offset`]
      if (offsetValue) {
        columnClasses.push(`col-${collapseWidth}-offset-${offsetValue}`)
      }
    })

    return (
      <div className={columnClasses.join(' ')}>
        { this.props.children }
      </div>
    )
  }
}
