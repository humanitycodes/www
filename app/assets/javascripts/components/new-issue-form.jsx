CodeLab.NewIssueForm = Radium(class extends React.Component {
  constructor(props) {
    super(props)
    this.openNewIssue = this.openNewIssue.bind(this)
    this.styles = {
      inlineText: {
        base: {
          padding: '0 5px'
        },
        first: {
          padding: '0 5px 0 0'
        }
      }
    }
  }

  openNewIssue(event) {
    event.preventDefault()
    const mentor = this.refs.mentor.getDOMNode().value
    const hostedURL = this.refs.hostedURL.getDOMNode().value
    const newIssueURL = `${ this.props.repoURL }/issues/new?${ $.param({
      title: 'Code Lab Feedback',
      body: `Hey @${mentor}, can you take a look at this? It's [hosted here](${hostedURL}) and meets the following [project](http://lansingcodelab.com/lessons/${this.props.repoURL.split('codelab-')[1]}/1) criteria:\n\n- [x] ${this.props.project.criteria.join('\n- [x] ')}`
    }) }`
    window.open(newIssueURL, '_blank').focus()
  }

  render() {
    return (
      <form onSubmit={this.openNewIssue} className='well'>
        <p>
          <span
            style = {[
              this.styles.inlineText.base,
              this.styles.inlineText.first
            ]}
          >
            Hey
          </span>
          <select ref='mentor' name='mentor'>
            {
              CodeLab.helpers.shuffle(CodeLab.config.mentors).map(mentor => {
                return <option key={mentor.username} value={mentor.username}>{ mentor.name }</option>
              })
            }
          </select>
          ,<span style={this.styles.inlineText.base}>can you take a look at this? It's hosted at:</span>
        </p>
        <div className='form-group'>
          <input
            ref='hostedURL'
            type='text'
            className='form-control'
            placeholder="What's the link for your website?"
          />
        </div>
        <button
          type = 'submit'
          className = 'btn btn-primary btn-block'
          style = {this.props.style}
        >Ask for feedback</button>
      </form>
    )
  }
})
