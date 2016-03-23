require! {
  'd3': D3
}

module.exports = class UserReportGithubActivity extends React.Component

  render-graph: (container-id, event-times) !->
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
    x = D3.time.scale!
      .range [0, width]
    y = D3.scale.linear!
      .range [height, 0]

    # Define the axes
    x-axis = D3.svg.axis!.scale(x).orient('bottom').ticks 5
    y-axis = D3.svg.axis!.scale(y).orient('left').ticks 5

    # Define the line
    valueline = D3.svg.line!
      .interpolate 'basis'
      .x -> x it.date
      .y -> y it.count

    # Adds the svg canvas
    svg = D3.select('#' + container-id).append('svg')
      .attr 'width', width + margin.left + margin.right
      .attr 'height', height + margin.top + margin.bottom
      .append 'g'
        .attr 'transform', "translate(#{margin.left},#{margin.top})"

    # Get the data
    data = event-times
      |> map -> new Date(it)
      |> group-by -> new Date(it.get-time!).set-hours(0,0,0,0)
      |> obj-to-pairs
      |> map ->
        date: new Date do
          parse-int it.0
        count: it.1.length

    # Add tomorrow's date with count of 0
    data.unshift do
      date: do
        tomorrow = new Date(new Date!.get-time! + 24 * 60 * 60 * 1000)
        tomorrow.set-hours 0,0,0,0
        tomorrow
      count: 0

    # Scale the range of the data
    x.domain D3.extent data, (.date)
    y.domain [0, D3.max data, (.count)]

    svg.selectAll('.bar')
      .data(data)
      .enter().append('rect')
        .attr 'class', 'bar'
        .attr 'x', -> x it.date
        .attr 'width', Math.ceil do
          width /
          (
            (data.0.date.get-time! - last(data).date.get-time!) /
            (1000 * 60 * 60 * 24)
          )
        .attr 'y', -> y it.count
        .attr 'height', -> height - y(it.count)
        .attr 'data-date', -> it.date
        .style 'fill', 'steelblue'

    # Add the X Axis
    svg.append('g')
      .attr 'class', 'x axis'
      .attr 'transform', "translate(0,#{height})"
      .call x-axis
    # Add the Y Axis
    svg.append('g')
      .attr 'class', 'y axis'
      .call y-axis

  component-will-mount: !->
    window.add-event-listener 'resize', @component-did-mount, false

  component-did-mount: !~>
    @render-graph 'user-report-github-activity', @props.event-times

  component-will-unmount: !->
    window.remove-event-listener 'resize', @component-did-mount, false

  render: ->
    const today = new Date!
    const one-month-ago = new Date!.set-month(today.get-month! - 1)
    events-in-last-month = @props.event-times
      |> filter ->
        new Date(it).get-time! > one-month-ago

    $div do
      $h3 do
        $strong do
          events-in-last-month.length
          ' actions on GitHub'
        ' in the last month'
      $div id: 'user-report-github-activity'
      $style do
        """
        \#user-report-github-activity .axis path,
        \#user-report-github-activity .axis line {
            fill: none;
            stroke: grey;
            stroke-width: 1;
            shape-rendering: crispEdges;
        }
        """
