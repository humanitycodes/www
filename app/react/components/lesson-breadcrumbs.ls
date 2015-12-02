require! {
  '../lib/lessons-searcher': LessonsSearcher

  './card': Card
}

module.exports = Radium class LessonBreadcrumbs extends React.Component

  (props) ->
    super props
    @state =
      autocomplete-is-shown: false
      breadcrumb-title: props.title
      autocomplete-results: []
    @styles =
      wrapper:
        base:
          display: 'inline'
          position: 'relative'
          text-align: 'left'
      h1:
        base:
          display: 'inline'
      input:
        base:
          width: 'calc(100% - 141px)'
          height: 38
          min-height: 38
          vertical-align: 'top'
          padding: 0
          overflow: 'hidden'
          border: 'none'
          outline: 'none'
          resize: 'none'
          background: 'transparent'
        collapsed:
          width: 'calc(100% - 552px)'
      autocomplete-results:
        base:
          position: 'absolute'
          top: '100%'
          left: 0
          z-index: 1
          margin-top: 10
          line-height: 1.4
          font-size: 20
      result-list:
        base:
          padding: 0
          margin: '-5px 0'
      result:
        base:
          list-style-type: 'none'
      result-link:
        base:
          display: 'block'
          padding: '5px 10px'
          margin: '0 -10px'
          ':hover':
            background: 'rgba(62,121,185,0.1)'
            text-decoration: 'none'

  on-title-change: (event) !~>
    new-title = event.target.value
    @set-state do
      autocomplete-is-shown: true
      breadcrumb-title: new-title
      autocomplete-results: @lessons-searcher.search new-title, @props.title

  on-title-blur: (event) !~>
    jQuery(document).one 'mouseup', !~>
      set-timeout do
        !~>
          @set-state do
            autocomplete-is-shown: false
            autocomplete-results: []
            breadcrumb-title: @props.title
        1

  on-title-focus: (event) !~>
    jQuery(event.target).select!

  update-lesson-to: (lesson) !~>
    @set-state do
      breadcrumb-title: lesson.title
      autocomplete-is-shown: false
      autocomplete-results: []
    @props.on-lesson-change lesson

  component-did-mount: !->
    @lessons-searcher = new LessonsSearcher @props.title

    jq-input = jQuery(@refs.input)
    jq-input.on 'keyup', !->
      jq-input.height 0
      jq-input.height jq-input.0.scroll-height
    jq-input.keyup!

    jq-input.on 'keydown', (event) !~>
      if event.key-code is 13 # Enter key
        event.prevent-default!
        unless empty @state.autocomplete-results
          @update-lesson-to first @state.autocomplete-results
          jQuery(@refs.input).blur!

  component-did-update: (prev-props, prev-state) !->
    if prev-props.title is not @props.title
      @lessons-searcher.set-current-title @props.title
    jQuery(@refs.input).keyup!

  render: ->

    $div do
      class-name: 'h3'

      $a href: '/lessons', 'Lessons'
      ' > '
      $div do
        style: @styles.wrapper.base

        $h1 do
          class-name: 'h3'
          style: @styles.h1.base
          $textarea do
            ref: 'input'
            style:
              * @styles.input.base
              * @props.collapsed and @styles.input.collapsed
            on-change: @on-title-change
            on-focus: @on-title-focus
            on-click: @on-title-focus
            on-blur: @on-title-blur
            value: @state.breadcrumb-title

        if @state.autocomplete-is-shown

          $div do
            class-name: 'lesson-autocomplete-results'
            style: @styles.autocomplete-results.base

            $(Card) do
              if empty @state.autocomplete-results
                'No matching lessons found.'
              else
                $ul do
                  style: @styles.result-list.base
                  @state.autocomplete-results |> map (lesson) ~>
                    $li do
                      style: @styles.result.base
                      $a do
                        key: "lesson-autocomplete-link-#{lesson.key}"
                        style: @styles.result-link.base
                        href: "/lessons/#{lesson.key}"
                        on-click: (event) !~>
                          event.prevent-default!
                          @update-lesson-to lesson
                        lesson.title
