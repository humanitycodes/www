require! {
  './card': Card
  './row': Row
  './column': Column
  './contact-method': ContactMethod
}

module.exports = Radium class StaffMember extends React.Component
  (props) ->
    super props

    @styles =
      image:
        base:
          max-height: 200
          margin-bottom: 15
      name:
        base:
          margin-top: 0
      title:
        base:
          opacity: 0.4
          margin-left: 20
          font-size: '0.8em'
      contact-list:
        base:
          margin-bottom: 0
          padding-left: 0
      contact-item:
        base:
          display: 'inline-block'
          margin-right: 15

  render: ->
    const {
      name, title, bio, tech, contact_methods, roles, username, image_path
    } = @props.member

    $(Card) do
      $(Row) do
        $(Column) md: 2, sm: 3,
          $img do
            src: image_path
            alt: name
            class-name: 'thumbnail img-responsive'
            style: @styles.image.base

        $(Column) md: 10, sm: 9,
          $h2 do
            class-name: 'h3'
            style: @styles.name.base
            name
            $span do
              style: @styles.title.base
              title
          $p dangerously-set-inner-HTML: { __html: bio }
          $p do
            $strong 'Technologies: '
            $span dangerously-set-inner-HTML: { __html: tech }
          $ul style: @styles.contact-list.base,
            contact_methods.map (method) ~>
              $li style: @styles.contact-item.base,
                $(ContactMethod) do
                  method: method
