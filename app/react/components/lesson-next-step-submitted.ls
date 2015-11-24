require! {
  './lesson-project-submission-instructions.ls': LessonProjectSubmissionInstructions
}

module.exports = class LessonNextStepSubmitted extends React.Component
  render: ->
    const { repo-URL, categories } = @props

    project-folder-name = repo-URL
      .match /(codelab\-[\w\-]+)/
      .0

    $div do

      $p do
        'You should be receiving feedback soon on '
        $a do
          href: "#{ repo-URL }/issues"
          target: '_blank'
          'that issue you created'
        ". If there's any possible room for improvement, a mentor will let you know. If you need to make changes, you'll want to make sure you also update your code on GitHub and make the new version live with these steps:"

      $(LessonProjectSubmissionInstructions) do
        submission-instructions: @props.submission-instructions
        project-folder-name: project-folder-name
        categories: categories

      $p "When everything looks good, they'll leave the \"shipit\" squirrel to let you know that your code is ready for the world."

      $p 'After that, you can move on to another lesson.'
