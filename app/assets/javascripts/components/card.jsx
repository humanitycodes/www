CodeLab.Card = class extends React.Component {
  render() {
    return (
      <div className='well'>
        { this.props.children }
      </div>
    )
  }
}
