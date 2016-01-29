require! {
  './row': Row
  './column': Column
  './staff-member': StaffMember
}

module.exports = class Staff extends React.Component
  render: ->
    { staff } = @props

    founders = staff
      |> filter (member) ->
        member.roles |> any (is 'Founder')

    leaders = difference(staff, founders)
      |> filter (member) ->
        member.roles |> any (is 'Leader')
      |> sort-by (member) ->
        return 1 if member.title is 'Operations Director'
        return 2 if member.title is 'Outreach Director'
        Infinity

    mentors = difference(staff, founders ++ leaders)
      |> filter (member) ->
        member.roles |> any (is 'Mentor')

    const list-members = (members, should-shuffle) ->
      members
        |> if should-shuffle then shuffle else -> members
        |> map (member) ->
          $(StaffMember) do
            key: member.username
            member: member

    $(Row) do
      $(Column) do
        md: 8
        md-offset: 2
        sm: 10
        sm-offset: 1
        list-members founders
        list-members leaders
        list-members mentors, true
