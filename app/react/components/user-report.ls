require! {
  './card': Card
  './lessons-map': LessonsMap
  './user-report-lessons': UserReportLessons
  './user-report-github-activity': UserReportGithubActivity
}

module.exports = class UserReport extends React.Component

  component-did-mount: ->
    jQuery('[id|="lessons-map"]').siblings('button').remove!

  render: ->
    $div do
      $h2 'User stats for ' + @props.presented-user.name
      $(LessonsMap) { ...@props }
      $(Card) do
        $(UserReportGithubActivity) { ...@props }
      $(Card) do
        $(UserReportLessons) { ...@props }
