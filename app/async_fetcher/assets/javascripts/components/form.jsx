CodeLab.Form = class extends React.Component {
  render() {
    return (
      <form action={this.props.action} acceptCharset="UTF-8" method={this.props.method || 'post'}>
        <input type='hidden' name='utf8' value='✓'/>
        <input type='hidden' name='authenticity_token' value={this.props.authenticityToken}/>
        { this.props.children }
      </form>
    )
  }
}
