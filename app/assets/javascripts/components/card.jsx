CodeLab.Card = class extends React.Component {
  render() {
    return (
      <div className='well card' style={this.props.style}>
        { this.props.children }
      </div>
    )
  }
}
