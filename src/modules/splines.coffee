svg = null
w = 1200
h = 800
dataset = [[200, 200]]

module.exports = ->

  zoom = ->
    svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");

  svg = d3.select('#chartArea').append('svg')
    .attr('width', w)
    .attr('height', h)
    .append("g")
    .call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", zoom))
    .append("g")

  canvas = svg.append('rect')
    .attr('width', w)
    .attr('height', h)
    .attr('class', 'overlay')

  draw = ->
    line = d3.svg.line()
    line.interpolate 'cardinal'

    svg.selectAll('circle').data(dataset).enter().append('circle')
      .attr('cx', (d) -> d[0])
      .attr('cy', (d) -> d[1])
      .attr('r', 20)
      .attr('fill', 'black')

    svg.selectAll('.line').remove()
    path = svg.append('path')
      .datum(dataset)
      .attr('d', line)
      .attr('class', 'line')

    console.log 'draw'

    path.on 'mousedown', ->
      console.log 'select'
      # d3.event.stopPropagation()
      # d3.event.stopImmediatePropagation() # todo: what is this?
      path.attr('stroke', 'red')
      path.style('stroke', 'red')

  canvas.on 'click', ->
    dataset.push d3.mouse(svg.node())
    draw()

  draw()
  
