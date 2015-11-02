require! {
  'radium'
  './card': Card
}

module.exports = Radium class Students extends React.Component

  (props) !->
    super props
    @container-width = 1000
    @column-width = 250
    @column-padding = 20

  render: ->

    const students = shuffle @props.students

    $div do
      style:
        max-width: 1000
        margin: '0 auto'
        text-align: 'center'

      $div do
        style:
          max-width: 1000
          column-count: Math.floor(@container-width / @column-width)
          column-gap: 0
          '@media (max-width: 991px)':
            column-count: 3
          '@media (max-width: 650px)':
            column-count: 2

        students.map (student) ~>

          $div do
            class-name: 'student'
            key: student.username
            style:
              display: 'inline-block'
              width: '100%'
              padding-right: @column-padding

            $(Card) do
              $img do
                src: student.image_path
                alt: student.name
              $h2 class-name: 'h4', student.name
