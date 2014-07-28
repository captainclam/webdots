_.templateSettings.interpolate = /{{([\s\S]+?)}}/g

# template = _.template "<li><a href='{{html_url}}'>{{description}}</a> ({{created_at}})</li>"
# $ ->
#   dom = $ '.gists'
#   $.ajax(url: "https://api.github.com/users/captainclam/gists").done (gists) ->
#     dom.html gists.map template

init = ->

  w = 1200
  h = 800

  zoom = ->
    svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");

  dataset = _.map _.range(200), (i) ->
    return {
      x: Math.random() * w
      y: Math.random() * h
      r: Math.random() * 40
    }

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
    # .attr('x', w / 2)
    # .attr('y', h / 2)
    # .attr('text-anchor', 'middle')
    .attr('x', w - 400)
    .attr('y', 200)
    .style('font-size', 200)
    .style('opacity', 0.2)
    .text(count)


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
    .attr('opacity', (d) -> colorScale(d.r))

  svg.selectAll('circle').on 'mouseenter', ->
    item = d3.select(this)
    if item.attr('fill') isnt 'pink'
      count++
      svg.select('text').text(count)
    item.attr('fill', 'pink')

  delay = 1500
  tick = ->
    # delay -= 500
    # if delay < 0
    #   return
    console.log 'tick'
    svg.selectAll('circle')
      .transition()
      .duration(1000)
      .attr('cx', -> Math.random() * w)
      .attr('cy', -> Math.random() * h)
      .attr('r', -> Math.random() * 40)
      # .attr('opacity', -> Math.random())

    setTimeout tick, delay
  
  tick()

$ init