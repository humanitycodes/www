require! {
  './lesson-project-status-sidebar-step': LessonProjectStatusSidebarStep

  '../config/project-steps-generator': generate-steps
}

module.exports = Radium class LessonProjectStatusSidebar extends React.Component

  component-did-mount: !->
    jq-window = jQuery window
    jq-sidebar = jQuery 'svg#lesson-project-status-sidebar'
    jq-sidebar-wrapper = jq-sidebar.parent!
    jq-sidebar-offset = -> jq-sidebar-wrapper.offset!.top
    jq-sidebar-height = -> parse-int jq-sidebar.attr('height')
    jq-window.on 'scroll' ~>
      if jq-sidebar-height! <= jq-window.height! and jq-sidebar-offset! <= jq-window.scroll-top!
        jq-sidebar.css 'position', 'fixed'
        jq-sidebar.css 'top', do
          offset = (jq-sidebar-wrapper.offset!.top + jq-sidebar-wrapper.outer-height!) - (jq-window.scroll-top! + jq-sidebar-height!)
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
        $(LessonProjectStatusSidebarStep) do
          lesson: @props.lesson
          step: step
          index: index
          sidebar-width: sidebar-width
          node-size: node-size
          sidebar-margin-top: sidebar-margin-top
          node-padding: node-padding
          icon-size: icon-size
