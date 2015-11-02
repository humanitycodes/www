module.exports = class Card extends React.Component
  render: ->
    $div do
      class-name: 'well card'
      style: @props.style
      @props.children
