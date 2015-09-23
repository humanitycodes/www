CodeLab.PostButton = class extends React.Component {
  render() {
    return (
      <a rel="nofollow" data-method="post" href={this.props.href} className={`btn btn-${this.props.size} btn-${this.props.type}`}>
        { this.props.children }
      </a>
    )
  }
}
