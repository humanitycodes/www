require! {
  './card': Card
  './lesson-slides-navigation': LessonSlidesNavigation
  './lesson-slides': LessonSlides
  './lesson-project': LessonProject
}

module.exports = class Lesson extends React.Component
  (props) !->
    super props
    @state =
      page: props.page
      lesson: props.lesson

  slides: ~>
    @state.lesson.slides.split '\n---\n'

  base-URL: ~>
    "/lessons/#{@state.lesson.key}"

  component-will-mount: !->
    if @props.user
      jQuery.get-JSON do
        @base-URL! + '/' + @state.page + '.json'
      .done (response) ~>
        @set-state do
          lesson: response.lesson

  update-page: (event) ~>
    event.prevent-default!

    const new-page =
      if event.target.dataset
        event.target.dataset.new-page
      else
        event.target.get-attribute 'data-new-page'

    return if new-page < 1 or new-page > @slides!.length

    const new-URL = "#{@base-URL!}/#{new-page}"
    history.push-state {}, null, new-URL
    @set-state do
      page: parse-int new-page

  render: ->

    $div do

      $(Card) do
        $div do
          style:
            margin-bottom: 15
          $a href: '/lessons', 'Lessons'
          ' > '
          $strong @state.lesson.title
        if @slides!.length > 1
          $(LessonSlidesNavigation) do
            page: @state.page
            slides: @slides!
            base-URL: @base-URL!
            on-update-page: @update-page

      $(Card) do
        style:
          max-width: 600
          margin-top: -21
          margin-left: 'auto'
          margin-right: 'auto'
          padding: '20px 50px 50px'
          border-top: 0
          border-bottom: 0
          border-top-left-radius: 0
          border-top-right-radius: 0
        $(LessonSlides) do
          slides: @slides!
          page: @state.page
          base-URL: @base-URL!
          on-update-page: @update-page

      if @props.user
        $(Card) do
          style:
            max-width: 600
            margin-left: 'auto'
            margin-right: 'auto'
            padding: 50
          $(LessonProject) do
            lesson: @state.lesson
            authenticity-token: @props.authenticity-token
            user: @props.user
