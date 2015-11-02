require! {
  './lesson-next-steps': LessonNextSteps
}

module.exports = class LessonProject extends React.Component

  render: ->
    $div do
      id: 'project'

      $h3 do
        dangerously-set-inner-HTML:
          __html: 'Project: ' + parse-markdown do
            @props.lesson.project.title
            unwrap: true

      $div do
        id: 'project-criteria'
        style:
          background: '#f9f7f5'
          marginTop: 20
          marginBottom: 20
          marginLeft: -20
          marginRight: -20
          padding: '15px 20px'

        $h4 'Criteria'

        if @props.lesson.status is 'started'

          @props.lesson.project.criteria |> map (criterion) ->
            $div do
              class-name: 'checkbox'
              key: criterion

              $label do
                $input do
                  type: 'checkbox'
                  dangerously-set-inner-HTML:
                    __html: parse-markdown do
                      criterion
                      unwrap: true

        else

          $ul do
            @props.lesson.project.criteria |> map (criterion) ->
              $li do
                key: criterion
                dangerously-set-inner-HTML:
                  __html: parse-markdown do
                    criterion
                    unwrap: true

      $h4 'Next steps'

      $(LessonNextSteps) do
        user: @props.user
        lesson: @props.lesson
        authenticity-token: @props.authenticity-token
