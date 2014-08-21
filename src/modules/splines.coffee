svg = null
w = 1200
h = 800

module.exports = ->

  zoom = ->
    svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");

  svg = d3.select('#chartArea').append('svg')
    .attr('width', w)
    .attr('height', h)
    .append("g")
    .call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", zoom))
    .append("g") # not sure why though

  svg.append('rect')
    .attr('width', w)
    .attr('height', h)
    .attr('class', 'overlay')

  delay = 100
  tick = ->

    from = [_.random(0, w), _.random(0, h)]
    to = [_.random(0, w), _.random(0, h)]

    middle = [
      ((from[0] + to[0]) / 2) + 30
      ((from[1] + to[1]) / 2) + 30
    ]
    console.log from, middle, to

    line = d3.svg.line()
    line.interpolate 'basis'
    svg.append('path')
      .datum([from, middle, to])
      .attr('d', line)
      .attr('class', 'line')
      .style('opacity', Math.random())

    timeout = setTimeout tick, delay
  
  tick()
