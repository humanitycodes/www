require! {
  'highlight.js': Highlight
  './lesson-slides-navigation': LessonSlidesNavigation
}

module.exports = class LessonSlides extends React.Component

  component-did-mount: !->
    @highlight-code-blocks!

  component-did-update: !->
    @highlight-code-blocks!

  highlight-code-blocks: !~>
    document and
      jQuery( ReactDOM.find-DOM-node @ )
        .find 'pre > code'
        .each (i, block) !->
          Highlight.highlight-block block

  update-page: (event) !~>
    @props.on-update-page event
    document.body.scroll-top = document.document-element.scroll-top = 0

  render: ->
    const slide-index = @props.page - 1
    const slide = @props.slides[slide-index]

    if slide

      $div do
        $div do
          class-name: 'lesson-slide'
          dangerously-set-inner-HTML:
            __html: parse-markdown slide

    else

      $div do
        $p "This lesson doesn't have a page #{ @props.page }. The last page is #{ @props.slides.length }."
        $p do
          'Would you like to see '
          $a href: "/lessons/#{ @props.lesson.key }/1", 'page 1'
          ' instead?'
