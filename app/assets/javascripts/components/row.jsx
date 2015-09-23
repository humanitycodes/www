CodeLab.Row = class extends React.Component {
  render() {
    return (
      <div className='row' {...this.props} >
        { this.props.children }
      </div>
    )
  }
}
