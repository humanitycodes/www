module.exports = class LessonBreadcrumbs extends React.Component

  render: ->

    $div class-name: 'h3',
      $a href: '/lessons', 'Lessons'
      ' > '
      $h1 do
        style:
          display: 'inline'
        class-name: 'h3'
        @props.title
