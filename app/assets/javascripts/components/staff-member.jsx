CodeLab.StaffMember = Radium(class extends React.Component {
  constructor(props) {
    super(props)
    const imageContainerWidth = 150
    const imageContainerMarginRight = 20

    this.styles = {
      image: {
        base: {
          maxHeight: 200,
          marginBottom: 15
        }
      },
      name: {
        base: {
          marginTop: 0
        }
      },
      contactList: {
        base: {
          paddingLeft: 0
        }
      },
      contactItem: {
        base: {
          display: 'inline-block',
          marginRight: 15
        }
      }
    }
  }

  render() {
    const {
      name, bio, tech, contact_methods, roles, username, image_path
    } = this.props.member

    return (
      <CodeLab.Card>
        <CodeLab.Row>
          <CodeLab.Column md='2' sm='3'>
            <img
              src = {image_path}
              alt = {name}
              className = 'thumbnail img-responsive'
              style = {this.styles.image.base}
            />
          </CodeLab.Column>
          <CodeLab.Column md='10' sm='9'>
            <h2
              className = 'h3'
              style = {this.styles.name.base}
            >
              { name }
            </h2>
            <p dangerouslySetInnerHTML={{__html: bio}}/>
            <p>
              <strong>Technologies</strong>:&nbsp;
              <span dangerouslySetInnerHTML={{__html: tech}}/>
            </p>
            <ul style={this.styles.contactList.base}>
              {
                contact_methods.map(method => {
                  return (
                    <li style={this.styles.contactItem.base}>
                      <CodeLab.ContactMethod
                        method = {method}
                      />
                    </li>
                  )
                })
              }
            </ul>
          </CodeLab.Column>
        </CodeLab.Row>
      </CodeLab.Card>
    )
  }
})
