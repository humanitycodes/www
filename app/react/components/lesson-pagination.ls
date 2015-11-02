require! {
  'react-bootstrap/lib/OverlayTrigger'
  'react-bootstrap/lib/Popover'
}

module.exports = Radium class LessonPagination extends React.Component
  (props) !->
    super props
    @state =
      container-width: 0

    @breadcrumbs-container-id = 'lesson-page-breadcrumbs' + Math.random() * 1e20

    @styles =
      breadcrumb-circle:
        base:
          fill: 'lightblue'
          cursor: 'pointer'
        active:
          fill: 'steelblue'
          cursor: 'default'

  update-container-width: !~>
    const container-node = document.get-element-by-id @breadcrumbs-container-id
    @setState do
      container-width: container-node.offsetWidth

  component-did-mount: !->
    @update-container-width!
    window and window.add-event-listener('resize', @update-container-width, false)

  component-will-unmount: !->
    window && window.remove-event-listener 'resize', @update-container-width, false

  render: ->
    const circle-radius = 10
    const horizontal-padding = circle-radius
    const inner-width = @state.container-width - horizontal-padding * 2
    const height = circle-radius * 2

    $div id: @breadcrumbs-container-id, style: @props.style,
      $svg width: @state.container-width, height: height,
        $g transform: "translate(#{horizontal-padding},#{height / 2})",

          [1 to @props.slides.length] |> map (page) ~>

            const slide-heading-matches = @props.slides[page - 1].match(/## (.+)\n/)
            const slide-heading = parse-markdown do
              if slide-heading-matches
                slide-heading-matches[1]
              else
                page
              unwrap: true

            $g do
              key: "lesson-page-breadcrumb-#{page}"
              transform: "translate(#{inner-width / (@props.slides.length - 1) * (page - 1)},#{height / 2})"

              $(OverlayTrigger) do
                trigger: <[ hover focus ]>
                animation: false
                placement: 'top'
                overlay: $(Popover) do
                  id: slide-heading
                  $span dangerously-set-inner-HTML:
                    __html: slide-heading

                $circle do
                  r: circle-radius
                  cy: -circle-radius
                  'data-new-page': page
                  on-click: @props.on-update-page
                  style:
                    * @styles.breadcrumb-circle.base
                    * @props.page is page and @styles.breadcrumb-circle.active
