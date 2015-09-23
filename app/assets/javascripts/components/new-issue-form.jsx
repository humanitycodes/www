function shuffle(o){
  for(var j, x, i = o.length; i; j = Math.floor(Math.random() * i), x = o[--i], o[i] = o[j], o[j] = x);
  return o;
}

CodeLab.NewIssueForm = class extends React.Component {

  handleSubmit(event) {
    event.preventDefault()
    console.log(event)
  }

  render() {
    return (
      <form onSubmit={this.handleSubmit}>
        <select name='mentor'>
          {
            shuffle(CodeLab.config.mentors).map(mentor => {
              return <option value={mentor.username}>{ mentor.name }</option>
            })
          }
        </select>
      </form>
    )
  }
}
