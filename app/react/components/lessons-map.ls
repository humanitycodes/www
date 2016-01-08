require! {
  '../lib/lessons-mapper': LessonsMapper
}

module.exports = Radium class LessonsMap extends React.Component
  (props) !->
    super props
    @state =
      lessons: props.lessons
      refreshing-lessons: false

    @container-id = "lessons-map-#{ Math.random!.to-string!.replace '.', '' }"

    @styles =
      refresh-button:
        base:
          border-top-left-radius: 0
          border-top-right-radius: 0
          border-bottom-right-radius: 0

  initialize-new-mapper: !~>
    if @mapper
      window and window.remove-event-listener 'resize', @mapper.draw, false
    @mapper = new LessonsMapper @container-id, @state.lessons
    @mapper.draw!
    enable-popovers-for '#' + @container-id
    window and window.add-event-listener 'resize', @mapper.draw, false

  should-component-update: (next-props, next-state) ->
    next-state !== @state

  refresh-lessons: !~>
    @set-state refreshing-lessons: true
    jQuery.get-JSON('/lessons.json').done (response) !~>
      @set-state do
        refreshing-lessons: false
        lessons: response.lessons

  component-did-mount: !->
    @initialize-new-mapper!

  component-did-update: (prev-props, prev-state) !->
    if prev-state.lessons is not @state.lessons
      @initialize-new-mapper!
      Turbolinks?cache-current-page!

  component-will-unmount: !->
    window and window.remove-event-listener 'resize', @mapper.draw, false

  render: ->
    $div do
      if @props.user
        $button do
          className: 'pull-right btn btn-primary'
          on-click: @refresh-lessons
          disabled: @state.refreshing-lessons
          style: @styles.refresh-button.base

          if @state.refreshing-lessons
            $span do
              $span class-name: 'glyphicon glyphicon-loading'
              ' Refreshing...'
          else
            $span do
              $span class-name: 'glyphicon glyphicon-refresh'
              ' Refresh'
      $div do
        id: @container-id
        className: 'well card'
        style:
          padding: 0
