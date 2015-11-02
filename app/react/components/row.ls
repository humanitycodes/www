module.exports = class Row extends React.Component
  render: ->
    $div class-name: 'row', ...@props,
      @props.children
