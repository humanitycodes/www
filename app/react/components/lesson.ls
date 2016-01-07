require! {
  './card': Card
  './lesson-slides-navigation': LessonSlidesNavigation
  './lesson-slides': LessonSlides
  './lesson-project': LessonProject
  './lesson-project-status-sidebar': LessonProjectStatusSidebar
  './lesson-breadcrumbs': LessonBreadcrumbs
}

module.exports = Radium class Lesson extends React.Component
  (props) !->
    super props
    @state =
      page: props.page
      lesson: props.lesson
      project-is-hidden: false
      page-width: 1920
    @styles =
      wrapper:
        base:
          text-align: 'left'
        hidden-project:
          text-align: 'center'
      card:
        base:
          display: 'flex'
          flex-direction: 'row'
          max-width: '100%'
          text-align: 'left'
          padding: 0
      project-status-sidebar:
        base:
          min-width: 50
          max-width: 50
          line-height: 0
          background: '#2D3642'
          color: 'white'
      project:
        base:
          width: '100%'
          background: '#3E79B9'
          vertical-align: 'top'
          color: 'white'
          padding: '40px 30px'
          transition: 'all 0.5s'
        hidden:
          width: 'auto'
          padding: '40px 10px'
          cursor: 'e-resize'
      content:
        base:
          width: '100%'
          min-width: 650
          max-width: 650
          vertical-align: 'top'
          padding: '40px 60px'
          background: 'white'
        skinny:
          min-width: 0

  slides: ~>
    @state.lesson.slides.split '\n---\n'

  base-URL: ~>
    "/lessons/#{@state.lesson.key}"

  update-page-width: !~>
    @set-state do
      page-width: window.inner-width

  page-is-skinny: ~>
    @state.page-width < 1200

  component-will-mount: !->
    @update-page-width!
    window.add-event-listener 'resize', @update-page-width

    if @props.user
      jQuery.get-JSON do
        @base-URL! + '/' + @state.page + '.json'
      .done (response) ~>
        @set-state do
          lesson: response.lesson

  component-did-update: (prev-props, prev-state) !->
    if prev-state.page is not @state.page and
      prev-state.lesson.key is @state.lesson.key
      jQuery('html,body').scroll-top do
        jQuery('#lesson-card').offset!.top
    else
      Turbolinks?cache-current-page!

  component-will-unmount: !->
    window.remove-event-listener 'resize', @update-page-width

  update-page: (event) ~>
    event.prevent-default!

    const new-page = parse-int do
      if event.target.dataset
        event.target.dataset.new-page
      else
        event.target.get-attribute 'data-new-page'

    return if new-page < 1 or new-page > @slides!.length

    const new-URL = "#{@base-URL!}/#{new-page}"
    history.replace-state {}, null, new-URL
    @set-state do
      page: new-page

  render: ->

    const slides = @slides!

    const project-wrapper = if @props.user
      $div do
        key: 'lesson-project-wrapper'
        id: 'project-cell'
        class-name: not @page-is-skinny! and @state.project-is-hidden and 'collapsed'
        on-click: (event) !~>
          unless @page-is-skinny!
            const black-listed-element-types = 'label,a'
            const jq-target = jQuery(event.target)
            const target-is-label = jq-target.is black-listed-element-types
            const target-in-label = !!jq-target.closest(black-listed-element-types).0
            return if target-is-label or target-in-label
            @set-state do
              project-is-hidden: not @state.project-is-hidden
        style:
          * @styles.project.base
          * not @page-is-skinny! and cursor: 'w-resize'
          * not @page-is-skinny! and @state.project-is-hidden and @styles.project.hidden

        $(LessonProject) do
          lesson: @state.lesson
          authenticity-token: @props.authenticity-token
          user: @props.user
          is-hidden: do
            not @page-is-skinny! and @state.project-is-hidden

    const lesson-wrapper = $div do
      style:
        * @styles.content.base
        * @page-is-skinny! and @styles.content.skinny
      if slides.length > 1
        $(LessonSlidesNavigation) do
          page: @state.page
          slides: slides
          base-URL: @base-URL!
          on-update-page: @update-page

      $div do
        style:
          margin: do
            if slides.length > 1
              '30px 0'
            else
              0
        $(LessonSlides) do
          slides: slides
          page: @state.page
          base-URL: @base-URL!
          on-update-page: @update-page

      if slides.length > 1
        $(LessonSlidesNavigation) do
          page: @state.page
          slides: slides
          base-URL: @base-URL!
          on-update-page: @update-page

    $div do
      style:
        * @styles.wrapper.base
        * not @page-is-skinny! and @state.project-is-hidden and @styles.wrapper.hidden-project

      $(LessonBreadcrumbs) do
        title: @state.lesson.title
        collapsed: not @page-is-skinny! and @state.project-is-hidden
        on-lesson-change: (new-lesson) !~>
          const new-URL = "/lessons/#{new-lesson.key}/1"
          history.replace-state {}, null, new-URL
          @set-state do
            lesson: new-lesson
            page: 1

      $div do
        style:
          * display: 'flex'
            justify-content: 'center'

        $(Card) do
          id: 'lesson-card'
          style: @styles.card.base

          if @props.user
            $div do
              style: @styles.project-status-sidebar.base
              $(LessonProjectStatusSidebar) do
                lesson: @state.lesson
                user: @props.user

          if @page-is-skinny!
            $div do
              style:
                display: 'flex'
                flex-wrap: 'wrap'
                width: "calc(100% - #{@styles.project-status-sidebar.base.max-width}px)"
                max-width: 650
              lesson-wrapper
              project-wrapper
          else
            $div do
              style:
                display: 'flex'
              project-wrapper
              lesson-wrapper
