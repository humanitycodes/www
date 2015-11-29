module.exports = class Card extends React.Component
  render: ->
    default-props =
      class-name: "well card #{@props.class-name}"

    $div do
      default-props import @props
