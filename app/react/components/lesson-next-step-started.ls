require! {
  './lesson-project-submission-instructions': LessonProjectSubmissionInstructions
  './new-issue-form': NewIssueForm
}

module.exports = class LessonNextStepStarted extends React.Component
  render: ->
    const { repo-URL, project } = @props

    const clone-URL = "#{ repo-URL }.git"
    const project-folder-name = repo-URL.match(/(codelab\-[\w\-]+)/)[0]

    $div id: 'next-steps-started',
      $p 'Looks great! You now have a repository at:'
      $p do
        $a href: repo-URL, repo-URL
      $p 'To start working on this repository, open up your terminal and:'
      $pre do
        $code "git clone #{ clone-URL }"
      $p
        'That creates a directory on your computer called '
        $code project-folder-name
        " where you'll keep your code."
      $p "Now whenever you make changes, you'll follow the steps below to push your code to GitHub (so mentors can see the code) and then to Surge (so mentors can see the live result):"
      $(LessonProjectSubmissionInstructions) do
        project-folder-name: project-folder-name
        categories: @props.categories
      $p do
        'Then '
        $strong do
          "when you've met the "
          $a do
            href: '#project-criteria'
            'project criteria above'
        ", request feedback below and we'll help you refine it:"
      $(NewIssueForm) do
        repo-URL: repo-URL
        project: project
