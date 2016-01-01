require! {
  'D3': D3
  'dagre-d3': DagreD3
}

module.exports = class LessonsMapper
  (container-id, lessons) !->
    @container-id = container-id
    @lessons = lessons

    @evaluate-for-user!
    @initialize-graph!

  evaluate-for-user: ~>
    @approved-lesson-keys = @lessons
      |> filter (.status is 'approved')
      |> map (.key)

    const lesson-key-is-approved = (key) ~>
      @approved-lesson-keys.index-of(key) > -1

    const lesson-is-recommended = (lesson) ->
      not lesson-key-is-approved(lesson.key) and
        (lesson.prereqs |> all lesson-key-is-approved)

    @recommended-lesson-keys = @lessons
      |> filter lesson-is-recommended
      |> map (.key)

  initialize-graph: !->
    @margin-x = 50
    @margin-y = 50
    @ranksep = 100
    @node-diameter = 32

    @graph = new DagreD3.graphlib.Graph!.set-graph do
      nodesep: 10
      rankdir: 'LR'
      edgesep: 0
      ranksep: @ranksep
      marginx: @margin-x
      marginy: @margin-y
    .set-default-edge-label -> {}

    for lesson in @lessons
      @graph.set-node lesson.key,
        label: if lesson.categories.0 then lesson.categories.0.to-upper-case! else '...'
        width: @node-diameter
        height: @node-diameter
        shape: 'circle'
        lesson: lesson
        # Necessary to set here for DagreD3 to correctly center labels
        label-style: 'font-weight: 300; font-size: 14;'

    for lesson in @lessons
      if lesson.prereqs
        for prereq-key in lesson.prereqs
          @graph.set-edge prereq-key, lesson.key,
            line-interpolate: 'bundle'

    @renderer = new DagreD3.render!

  draw: !~>
    document.get-element-by-id @container-id .inner-HTML = ''
    @draw-SVG-container!
    @enable-panning!
    @compute-and-draw-layout!
    @customize-graph!

  draw-SVG-container: !~>
    @container-width = document.get-element-by-id @container-id .offset-width
    @svg = D3.select('#' + @container-id).append('svg')
      .attr 'width', @container-width

    @svg-inner = @svg.append 'g'

  enable-panning: !~>
    @zoom = (translate-to) !~>
      const draw-width = D3.select 'g.nodes' .0.0.get-b-box!.width
      const distance-between-graph-edge-and-container-limit = @container-width - @margin-x * 2 - draw-width
      const min-x = D3.min [ 0, distance-between-graph-edge-and-container-limit ]
      const max-x = D3.max [ distance-between-graph-edge-and-container-limit, 0 ]
      const translation = if translate-to then translate-to else D3.event.translate.0
      const new-x = D3.min [ D3.max([ translation, min-x ]), max-x ]
      @zoomer.translate [new-x, 0]
      @svg-inner.attr 'transform', "translate(#{new-x},0)"

    @zoomer = D3.behavior.zoom!
      .scale-extent [1, 1]
      .on 'zoom', @zoom

    @svg.call @zoomer

    const zoom-with-scroll = !~>
      const current-offset-x = parse-int do
        @svg-inner
          .attr 'transform'
          .match /(?:translate\()+([\-\d]+)[ ,]+/ .1

      const translate-to = current-offset-x - D3.event.delta-x
      if translate-to
        @zoom translate-to

    @svg.on 'wheel.zoom', zoom-with-scroll
    @svg.on 'mousewheel.zoom', zoom-with-scroll

    @svg
      .attr 'class', 'grabbable'
      .style 'margin-left', -1
      .style 'margin-bottom', -5

  compute-and-draw-layout: !~>
    @renderer D3.select('svg g'), @graph
    @svg.attr 'height', @graph.graph!.height

    const first-recommended-lesson-position = D3.min do
      @recommended-lesson-keys |> map (key) ~> @graph.node(key).x

    const initial-pan-position = -first-recommended-lesson-position + @margin-x + @node-diameter / 2
    @zoom initial-pan-position
    # @zoomer.translate [initial-pan-position, 0]
    # @svg-inner.attr 'transform', "translate(#{initial-pan-position},0)"

  customize-graph: !~>
    const nodes = @svg.select-all 'g.node'

    nodes.attr 'class', (key) ~>
      const lesson = @graph.node(key).lesson
      classes =
        * 'node'
        * lesson.categories.0
        * lesson.status

      @recommended-lesson-keys.index-of(key) > -1 and classes.push('recommended')
      classes.join ' '

    const circle-stroke-width = (key, is-hovered=false) ~>
      const base-width = if @recommended-lesson-keys.index-of(key) > -1 then 5 else 2
      return base-width if @approved-lesson-keys.index-of(key) > -1
      if is-hovered then base-width + 3 else base-width

    nodes.select 'circle' .remove!

    nodes.insert 'a', ':first-child'
      .attr 'xlink:href', (key) -> "/lessons/#{key}"
      .append 'circle'
        .attr 'r', @node-diameter / 2 + 10
        .attr 'class', 'lesson'
        .attr 'data-toggle', 'popover'
        .attr 'data-content', (key) ~> @graph.node(key).lesson.title
        .style 'transition', 'stroke-width 0.3s'
        .style 'cursor', 'pointer'
        .style 'stroke-width', (key) -> circle-stroke-width key
        .on 'mouseover', (key) !->
          D3.select(@)
            .style 'stroke-width', circle-stroke-width(key, true)
        .on 'mouseout', (key) !->
          D3.select(@)
            .style 'stroke-width', circle-stroke-width(key)
        # .on 'click', (key) !->
        #   location.assign "/lessons/#{key}"

    nodes.select 'g.label text'
      .style 'pointer-events', 'none'

    nodes.each (key) !->
      const node = D3.select @

      if node.classed 'approved'

        node.append 'circle'
          .attr 'class', 'overlay'
          .attr 'r', 28
          .style 'fill', 'rgba(255,255,255,0.7)'
          .style 'pointer-events', 'none'

        node.append 'text'
          .text '✓'
          .attr 'dy', 15
          .attr 'text-anchor', 'middle'
          .attr 'font-size', '40px'
          .attr 'fill', 'rgba(34,139,34,0.6)'
          .style 'pointer-events', 'none'

    const edges = @svg.select-all 'g.edgepath'

    edges.select 'path'
      .style 'stroke-width', 2
