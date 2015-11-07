require! {
  './post-button.ls': PostButton
}

module.exports = class LessonNextStepUnstarted extends React.Component
  render: ->
    const { lesson-key } = @props

    $div do
      $p "Before we can start coding, we need a place to keep our code."
      $p do
        $(PostButton) do
          href: "/repositories?key=#{ lesson-key }"
          type: <[ primary block ]>
          'Create a repository on GitHub'
