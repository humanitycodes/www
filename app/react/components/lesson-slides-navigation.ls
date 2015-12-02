require! {
  './lesson-pagination': LessonPagination
}

module.exports = class LessonSlidesNavigation extends React.Component

  component-did-mount: !->
    document.onkeydown = (event) ~>
      return if event.target.tag-name in <[
        INPUT
        TEXTAREA
      ]>

      const fake-page-update-click-event = (new-page) ~>
        prevent-default: !->
        target:
          href: "#{@props.base-URL}/#{new-page}"
          dataset:
            new-page: new-page

      event = event or window.event

      const prev-page-does-exist = @props.page > 1
      const next-page-does-exist = @props.slides.length > @props.page

      const prev-page = @props.page - 1
      const next-page = @props.page + 1

      if event.key-code == 39 and next-page-does-exist
        @props.on-update-page do
          fake-page-update-click-event next-page

      if event.key-code == 37 and prev-page-does-exist
        @props.on-update-page do
          fake-page-update-click-event prev-page

  component-will-unmount: !->
    document.onkeydown = null

  render: ->
    const prev-page-does-exist = @props.page > 1
    const next-page-does-exist = @props.slides.length > @props.page

    const prev-page = @props.page - 1
    const next-page = @props.page + 1

    $div class-name: 'clearfix',

      $(LessonPagination) do
        page: @props.page
        slides: @props.slides
        on-update-page: @props.on-update-page
        style:
          margin: '7px 75px -42px'

      $a do
        class-name: 'btn btn-primary pull-left'
        href: "#{@props.base-URL}/#{prev-page}"
        'data-new-page': prev-page
        disabled: !prev-page-does-exist
        on-click: @props.on-update-page
        style:
          margin-top: 7
        'Prev'

      $a do
        class-name: 'btn btn-primary pull-right'
        href: "#{@props.baseURL}/#{@props.page + 1}"
        'data-new-page': next-page
        disabled: !next-page-does-exist
        on-click: @props.on-update-page
        style:
          margin-top: 7
        'Next'
