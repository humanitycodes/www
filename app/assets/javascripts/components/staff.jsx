CodeLab.Staff = class extends React.Component {
  render() {
    let { staff } = this.props

    const founders = _.shuffle(_.remove(staff, member => {
      return member.roles.some(role => role === 'Founder')
    }))

    const leaders = _.shuffle(_.remove(staff, member => {
      return member.roles.some(role => role === 'Leader')
    }))

    const mentors = _.shuffle(_.remove(staff, member => {
      return member.roles.some(role => role === 'Mentor')
    }))

    const listMembers = members => {
      return members.map(member => {
        return (
          <CodeLab.StaffMember
            key = {member.username}
            member = {member}
          />
        )
      })
    }

    return (
      <CodeLab.Row>
        <CodeLab.Column
          md = '8'
          mdOffset = '2'
          sm = '10'
          smOffset = '1'
        >
          { listMembers(founders) }
          { listMembers(leaders) }
          { listMembers(mentors) }
        </CodeLab.Column>
      </CodeLab.Row>
    )
  }
}
