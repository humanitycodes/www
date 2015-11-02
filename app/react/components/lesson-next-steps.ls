require! {
  'highlight.js': Highlight
  './lesson-next-step-unstarted': LessonNextStepUnstarted
  './lesson-next-step-started': LessonNextStepStarted
  './lesson-next-step-submitted': LessonNextStepSubmitted
  './lesson-next-step-approved': LessonNextStepApproved
}

module.exports = class LessonNextSteps extends React.Component

  component-did-mount: !->
    @highlight-code-blocks!

  component-did-update: !->
    @highlight-code-blocks!

  highlight-code-blocks: !~>
    document and jQuery( ReactDOM.find-DOM-node @ )
      .find('pre > code')
      .each (i, block) !->
        Highlight.highlight-block block

  render: ->
    const { key, project, categories, status } = @props.lesson
    const repo-key = "#{ @props.user.username }/codelab-#{ key }"
    const repo-URL = "https://github.com/#{ repo-key }"

    switch status
    case 'started' then
      $(LessonNextStepStarted) do
        repo-URL: repo-URL
        project: project
        categories: categories
    case 'submitted' then
      $(LessonNextStepSubmitted) do
        repo-URL: repo-URL
        categories: categories
    case 'approved' then
      $(LessonNextStepApproved)!
    default then
      $(LessonNextStepUnstarted) do
        lesson-key: key
