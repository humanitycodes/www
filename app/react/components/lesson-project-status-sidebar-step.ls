require! {
  'react-bootstrap/lib/OverlayTrigger'
  'react-bootstrap/lib/Overlay'
  'react-bootstrap/lib/Popover'
}

module.exports = Radium class LessonProjectStatusSidebarStep extends React.Component

  (props) ->
    super props
    @step-circle-id = "#{props.lesson.key}-step-circle-#{props.index}"

  render: ->
    const { lesson, step, index, sidebar-width, node-size, sidebar-margin-top, node-padding, icon-size } = @props
    const popover-id = step.title?replace(/\W/g, '') or Math.random!.to-string!

    $(OverlayTrigger) do
      trigger: if step.content?
        if step.is-active
          <[ click focus ]>
        else
          <[ hover focus ]>
      else
        []
      root-close: step.content? and step.is-active
      animation: false
      placement: 'right'
      overlay: $(Popover) do
        id: popover-id
        style:
          max-width: 600
        title: step.content? and step.is-active and step.title
        if step.content? and step.is-active
          step.content
        else
          $span do
            if step.is-complete
              $span do
                class-name: 'octicon octicon-check'
                style:
                  display: 'inline-block'
                  font-size: '2em'
                  color: 'cadetblue'
                  vertical-align: 'sub'
                  margin-right: 12
            step.complete-content or step.title
            unless step.is-complete
              $div do
                class-name: 'text-muted'
                $em '(other steps must be completed first)'
      $g do
        transform: """
          translate(
            #{sidebar-width / 2},
            #{sidebar-margin-top + node-size + (node-size + node-padding) * index}
          )
        """.replace /\s/g, ''

        $(OverlayTrigger) do
          trigger: step.title? and step.is-active and not document.get-element-by-id(popover-id) and <[ hover ]>
          root-close: true
          animation: false
          placement: 'right'
          overlay: $(Popover) do
            id: popover-id + Math.random!
            step.title

          $g do

            $circle do
              key: @step-circle-id
              ref: @step-circle-id
              r: node-size / 2
              cy: -node-size / 2
              style:
                cursor: step.content? and (step.is-active or (step.is-complete and step.complete-on-click)) and 'pointer'
                opacity: step.content? and not step.is-active and 0.3
                transition: 'all 0.2s'
                ':hover':
                  r: step.is-active and node-size / 2 + 2
              fill: do
                if step.octicon is 'arrow-down'
                  'transparent'
                else
                  if step.is-active
                    '#3E79B9'
                  else if step.is-complete
                    'cadetblue'
                  else
                    '#777'
              on-click: step.is-complete and step.complete-on-click

            $g do
              style:
                pointer-events: 'none'
              dangerously-set-inner-HTML:
                __html: """
                  <foreignObject x="-#{node-size / 2}" y="-#{node-size}" width="#{node-size}" height="#{node-size}">
                    <body xmlns="http://www.w3.org/1999/xhtml">
                      <span class="octicon octicon-#{step.octicon}" style="width:#{node-size}px;line-height:#{node-size}px;font-size:#{icon-size}px;vertical-align:middle;text-align:center"></span>
                    </body>
                  </foreignObject>
                """
