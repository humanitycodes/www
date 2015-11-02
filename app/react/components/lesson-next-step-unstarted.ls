require! {
  './post-button': PostButton
}

module.exports = class LessonNextStepUnstarted extends React.Component
  render: ->
    $div do
      $p "Before we can start coding, we need a place to keep our code."
      $p do
        $(PostButton) do
          href: "/repositories?key=#{ @props.lessonKey }"
          type: <[ primary block ]>
          'Create a repository on GitHub'
