require! {
  'd3': D3
}

module.exports = class UserReport extends React.Component

  render-graph: (container-id, lessons) !->
    $container = jQuery('#' + container-id)
    $container.html ''

    # Set the dimensions of the canvas / graph
    margin =
      top: 30
      right: 0
      bottom: 30
      left: 30
    width = $container.outer-width! - (margin.left) - (margin.right)
    height = D3.max([$container.outer-width! / 3, 200]) - (margin.top) - (margin.bottom)

    # Set the ranges
    x = D3.time.scale!.range [0, width]
    y = D3.scale.linear!.range [height, 0]

    # Define the axes
    x-axis = D3.svg.axis!.scale(x).orient('bottom').ticks 5
    y-axis = D3.svg.axis!.scale(y).orient('left').ticks 5

    # Define the line
    valueline = D3.svg.line!
      .x -> x it.date
      .y -> y it.count

    # Adds the svg canvas
    svg = D3.select('#' + container-id).append('svg')
      .attr 'width', width + margin.left + margin.right
      .attr 'height', height + margin.top + margin.bottom
      .append 'g'
        .attr 'transform', "translate(#{margin.left},#{margin.top})"

    # Get the data
    approved-lessons-count = 0
    already-found-categories = {}
    data = lessons
      |> filter (.project.status is 'approved')
      |> sort-by (.project.approved-at)
      |> map ->
        categories: do
          it.categories |> filter (category) ->
            return false if already-found-categories[category] or category is 'setup'
            already-found-categories[category] = true
        date: new Date(it.project.approved-at)
        count: ++approved-lessons-count

    data.unshift do
      categories: []
      date: minimum [
        new Date @props.user.created_at
        data
          |> map (.date)
          |> minimum
      ]
      count: 0

    # Scale the range of the data
    x.domain D3.extent data, (.date)
    y.domain [0, D3.max data, (.count)]

    const should-show-above-graph = ->
      const x-coord = x it.date
      return false if x-coord < 150
      return true  if x-coord > width - 150
      it.count % 2 is 0

    svg.selectAll('g.category').data(data).enter().append 'g'
      .attr 'class', 'category'
      .attr 'transform', -> "translate(#{x it.date}, #{y it.count})"
      .append 'text'
        .attr 'font-size', 13
        .attr 'font-family', 'monospace'
        .attr 'text-anchor', ->
          if should-show-above-graph(it) then 'end' else 'start'
        .attr 'dx', ->
          if should-show-above-graph(it) then -5 else 5
        .attr 'dy', ->
          if should-show-above-graph(it) then -3 else 11
        .text -> it.categories.map((.to-upper-case!)).join(', ')

    # Add the valueline path.
    svg.append('path')
      .attr 'class', 'line'
      .attr 'd', valueline(data)
    # Add the X Axis
    svg.append('g')
      .attr 'class', 'x axis'
      .attr 'transform', "translate(0,#{height})"
      .call x-axis
    # Add the Y Axis
    svg.append('g')
      .attr 'class', 'y axis'
      .call y-axis

  project-approval-dates: ->
    @props.lessons
      |> filter (.project.status is 'approved')
      |> map -> new Date(it.project.approved-at)
      |> sort

  component-will-mount: !->
    window.add-event-listener 'resize', @component-did-mount, false

  component-did-mount: !~>
    @render-graph 'report', @props.lessons

  component-will-unmount: !->
    window.remove-event-listener 'resize', @component-did-mount, false

  render: ->
    current-date = new Date!

    current-month-approval-count = @project-approval-dates!
      |> map (> new Date!.set-date(current-date.get-date! - 28))
      |> sum

    $div do
      $p do
        class-name: 'h3'
        "You've completed "
        $strong "#{current-month-approval-count / 4} lessons per week"
        " over the last month."
      $div id: 'report'
      $style do
        """
        path {
            stroke: steelblue;
            stroke-width: 2;
            fill: none;
        }
        .axis path,
        .axis line {
            fill: none;
            stroke: grey;
            stroke-width: 1;
            shape-rendering: crispEdges;
        }
        """
