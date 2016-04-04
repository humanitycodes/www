require! {
  'radium'
  './card': Card
  './user-report-lessons': UserReportLessons
  './user-report-github-activity': UserReportGithubActivity
}

module.exports = Radium class Students extends React.Component

  render: ->
    const { user-lessons } = @props

    $div do
      user-lessons.map (user-lesson, index) ->
        $(Card) do
          $h2 do
            $a do
              href: "/users/#{user-lesson.user.username}"
              target: '_blank'
              user-lesson.user.username
          $(UserReportLessons) do
            presented-user: user-lesson.user
            lessons: user-lesson.lessons
