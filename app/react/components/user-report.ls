require! {
  './lessons-map': LessonsMap
  './user-report-lessons': UserReportLessons
  './user-report-github-activity': UserReportGithubActivity
}

module.exports = class UserReport extends React.Component

  component-did-mount: ->
    jQuery('[id|="lessons-map"]').siblings('button').remove!

  render: ->
    $div do
      $(LessonsMap) { ...@props }
      $(UserReportGithubActivity) { ...@props }
      $(UserReportLessons) { ...@props }
      # $(User)
