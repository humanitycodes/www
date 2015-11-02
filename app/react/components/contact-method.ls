module.exports = class ContactMethod extends React.Component
  render: ->
    const { type, body, url } = @props.method

    const icon-for =
      GitHub: 'github'
      Twitter: 'twitter'
      LinkedIn: 'linkedin'
      Email: 'envelope'
      'Stack Overflow': 'stack-overflow'
      Blog: 'rss'
      Business: 'briefcase'
      Slack: 'slack'

    const url-for = (method) ->
      return method.url if method.url

      switch method.type
      case 'GitHub' then "https://github.com/#{method.body}"
      case 'Twitter' then "https://twitter.com/#{method.body}"
      case 'LinkedIn' then "https://www.linkedin.com/in/#{method.body}"
      case 'Email' then "mailto:#{method.body}"
      case 'Slack' then "https://lansingcodes.slack.com/messages/@#{method.body}"

    $a href: url-for(@props.method),
      $i class-name: "fa fa-#{icon-for[type] or 'link'}"
      ' '
      type
