require! {
  'react-bootstrap/lib/OverlayTrigger'
  'react-bootstrap/lib/Popover'

  '../config/project-steps-generator': generate-steps
}

module.exports = Radium class LessonProjectStatusSidebar extends React.Component

  component-did-mount: !->
    jq-window = jQuery window
    jq-sidebar = jQuery 'svg#lesson-project-status-sidebar'
    jq-sidebar-wrapper = jq-sidebar.parent!
    jq-sidebar-offset = jq-sidebar.offset!.top
    jq-sidebar-height = parse-int jq-sidebar.attr('height')
    jq-window.on 'scroll' ~>
      if jq-sidebar-height <= jq-window.height! and jq-sidebar-offset <= jq-window.scroll-top!
        jq-sidebar.css 'position', 'fixed'
        jq-sidebar.css 'top', do
          offset = (jq-sidebar-wrapper.offset!.top + jq-sidebar-wrapper.outer-height!) - (jq-window.scroll-top! + jq-sidebar-height)
          if offset > 0
            0
          else
            offset
      else
        jq-sidebar.css 'position', 'inherit'

  render: ->

    const steps = generate-steps @props.lesson, @props.user

    # Absolute, uninherited sizing
    const sidebar-width = 50

    # Ratio sizing
    const relative-sidebar-margin-top = 0.2
    const relative-node-size = 0.8
    const relative-icon-size = 0.55
    const relative-node-padding = 0.2

    # Inherited, absolute sizing
    const node-size = sidebar-width * relative-node-size
    const sidebar-margin-top = node-size * relative-sidebar-margin-top
    const node-padding = node-size * relative-node-padding
    const icon-size = node-size * relative-icon-size

    $svg do
      id: 'lesson-project-status-sidebar'
      width: sidebar-width
      height: sidebar-margin-top * 2 + node-size + (node-size + node-padding) * (steps.length - 1)

      steps.map (step, index) ~>

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

            $circle do
              key: "#{@props.lesson.key}-step-circle-#{index}"
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
