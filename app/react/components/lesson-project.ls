module.exports = Radium class LessonProject extends React.Component

  (props) ->
    super props
    @state =
      is-hidden: false
    @styles =
      project-wrapper:
        base:
          overflow: 'hidden'
          transition: 'all 0.5s'
        hidden:
          width: 0
          height: 0
          opacity: 0
      criteria:
        base:
          line-height: 1.6
          font-size: '1.1em'
      criterion:
        base:
          margin-bottom: 10

  render: ->

    $div do
      id: 'project'
      style:
        * @styles.project-wrapper.base
        * @props.is-hidden and @styles.project-wrapper.hidden

      $h3 do
        style:
          margin-top: 0
        dangerously-set-inner-HTML:
          __html: parse-markdown do
            @props.lesson.project.title
            unwrap: true

      $div do
        id: 'project-criteria'

        $h4 'Criteria'

        if @props.lesson.project.status is 'started'

          @props.lesson.project.criteria |> map (criterion) ->
            $div do
              class-name: 'checkbox'
              key: criterion

              $label do
                $input do
                  type: 'checkbox'
                $span do
                  dangerously-set-inner-HTML:
                    __html: parse-markdown do
                      criterion
                      unwrap: true

        else

          $ul do
            style: @styles.criteria.base
            @props.lesson.project.criteria |> map (criterion) ~>
              $li do
                style: @styles.criterion.base
                key: criterion
                dangerously-set-inner-HTML:
                  __html: parse-markdown do
                    criterion
                    unwrap: true
