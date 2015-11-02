module.exports = class LessonNextStepApproved extends React.Component
  render: ->
    $p do
      "You've mastered this skill! Head back to the "
      $a href: '/lessons', 'lessons page'
      " whenever you're ready to tackle a new one. Recommended lessons will be gently pulsating."
