CodeLab.ContactMethod = class extends React.Component {
  render() {
    const { type, body, url } = this.props.method

    const iconFor = {
      GitHub: 'github',
      Twitter: 'twitter',
      LinkedIn: 'linkedin',
      Email: 'envelope',
      'Stack Overflow': 'stack-overflow',
      Blog: 'rss',
      Business: 'briefcase',
      Slack: 'slack'
    }

    const urlFor = method => {
      if (method.url) {
        return method.url
      }

      switch (method.type) {
        case 'GitHub': return `https://github.com/${method.body}`
        case 'Twitter': return `https://twitter.com/${method.body}`
        case 'LinkedIn': return `https://www.linkedin.com/in/${method.body}`
        case 'Email': return `mailto:${method.body}`
        case 'Slack': return `https://lansingcodes.slack.com/messages/@${method.body}/`
      }
    }

    return (
      <a href={urlFor(this.props.method)}>
        <i className={`fa fa-${iconFor[type] || 'link'}`}/>
        &nbsp;
        { type }
      </a>
    )
  }
}
