module.exports = class PostButton extends React.Component
  render: ->
    const { type, href, size, children } = @props

    type-classes = []
    if type instanceof Array
      for type-class in type
        type-classes.push "btn-#{type-class}"
    else
      type-classes.push "btn-#{type}"

    $a do
      rel: 'nofollow'
      'data-method': 'post'
      href: href
      className: """
        btn btn-#{ size or 'md' }
        #{ type-classes.join ' ' }
      """
      children
