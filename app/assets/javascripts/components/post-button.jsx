CodeLab.PostButton = class extends React.Component {
  render() {
    let typeClasses = []
    if (this.props.type instanceof Array) {
      this.props.type.forEach(type => {
        typeClasses.push(`btn-${type}`)
      })
    } else {
      typeClasses.push(`btn-${this.props.type}`)
    }

    return (
      <a
        rel = 'nofollow'
        data-method = 'post'
        href = {this.props.href}
        className = {`
          btn btn-${this.props.size || 'md'}
          ${ typeClasses.join(' ') }
        `}>
        { this.props.children }
      </a>
    )
  }
}
