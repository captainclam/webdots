svg = null
w = 1200
h = 800

module.exports = ->

  zoom = ->
    svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");

  total = 60
  dataset = _.map _.range(total), (i) ->
    return {
      x: Math.random() * w
      y: Math.random() * h
      r: (Math.random() * 40) + 20
    }

  diagonal = d3.svg.diagonal()

  svg = d3.select('#chartArea').append('svg')
    .attr('width', w)
    .attr('height', h)
    .append("g")
    .call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", zoom))
    .append("g") # not sure why though

  # xScale = d3.scale.linear()
  #   .domain(dataset)
  #   .rangeBands([0, w])

  yScale = d3.scale.linear()
    .domain([0, 100])
    .range([0, h])

  colorScale = d3.scale.linear()
    .domain([0, 40])
    .range([0, 0.5])

  count = 0
  svg.append('text')
    .attr('x', w / 2)
    .attr('y', h / 2)
    .style('font-size', 200)
    .style('opacity', 0.2)
    .style('text-anchor', 'middle')
    .style('dominant-baseline', 'central')
    .text(total - count)

  svg.append('rect')
    .attr('width', w)
    .attr('height', h)
    .attr('class', 'overlay')

  svg.selectAll('circle')
    .data(dataset)
    .enter()
    .append('circle')
    .attr('r', (d) -> d.r)
    .attr('cx', (d) -> d.x)
    .attr('cy', (d) -> d.y)
    .attr('fill', 'steelblue')
    .attr('class', 'unselected')
    .attr('opacity', (d) -> colorScale(d.r))

  links = dataset.map (target) ->
    return {
      source: dataset[0]
      target: target
    }
  svg.selectAll('path')
    .data(links)
    .enter()
    .append('path')
    .attr('d', diagonal)
    .attr('class', 'line')

  svg.selectAll('circle').on 'mouseenter', ->
    item = d3.select(this)
    if item.attr('fill') isnt 'pink'
      count++
      svg.select('text').text(total - count)
      # coord = d3.mouse(svg.node())
      item.transition()
        .duration(5000)
        .attr('cy', -20)
        .attr('class', '')
        # .attr('cx', -> Math.random() * w)
        # .attr('cy', -> Math.random() * h)
    item.attr('fill', 'pink')

  delay = 5000
  tick = ->
    # delay -= 5000
    # if delay < 0
    #   return
    console.log 'tick'
    dataset = _.map _.range(total), (i) ->
      return {
        x: Math.random() * w
        y: Math.random() * h
        r: (Math.random() * 40) + 20
      }

    svg.selectAll('circle.unselected')
      .data(dataset)
      .transition(5000)
      .attr('r', (d) -> d.r)
      .attr('cx', (d) -> d.x)
      .attr('cy', (d) -> d.y)
      .attr('fill', 'steelblue')
      .attr('class', 'unselected')
      .attr('opacity', (d) -> colorScale(d.r))

    links = dataset.map (target) ->
      return {
        source: dataset[0]
        target: target
      }
    svg.selectAll('path')
      .data(links)
      .transition(5000)
      .attr('d', diagonal)
      .attr('class', 'line')

    timeout = setTimeout tick, delay
  
  tick()
