module.exports = class Column extends React.Component
  render: ->
    const collapse-widths = <[ xs sm md lg ]>

    column-classes = []
    for collapse-width in collapse-widths
      const collapse-value = @props[collapse-width]
      if collapse-value
        column-classes.push "col-#{collapse-width}-#{collapseValue}"
      const offset-value = @props["#{collapse-width}Offset"]
      if offset-value
        column-classes.push "col-#{collapse-width}-offset-#{offsetValue}"

    $div class-name: column-classes.join(' '),
      @props.children
