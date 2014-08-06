_.templateSettings.interpolate = /{{([\s\S]+?)}}/g

# template = _.template "<li><a href='{{html_url}}'>{{description}}</a> ({{created_at}})</li>"
# $ ->
#   dom = $ '.gists'
#   $.ajax(url: "https://api.github.com/users/captainclam/gists").done (gists) ->
#     dom.html gists.map template

svg = null
w = 1200
h = 800

zoom = ->
  svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");

splines = ->

  svg = d3.select('#chartArea').append('svg')
    .attr('width', w)
    .attr('height', h)
    .append("g")
    .call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", zoom))
    .append("g") # not sure why though

  to = [500, 88]
  from = [800, 300]

  middle = [
    Math.abs(from[0] - to[0])
    Math.abs(from[1] - to[1])
  ]
  console.log from, middle, to

  line = d3.svg.line()
  line.interpolate 'basis'
  svg.append('path')
    .datum([from, middle, to])
    .attr('d', line)
    .attr('class', 'line')

  svg.append('rect')
    .attr('width', w)
    .attr('height', h)
    .attr('class', 'overlay')

webdots = ->

  dataset = _.map _.range(200), (i) ->
    return {
      x: Math.random() * w
      y: Math.random() * h
      r: (Math.random() * 40) + 10
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
    .attr('class', 'unselected')
    .attr('opacity', (d) -> colorScale(d.r))

  svg.selectAll('circle').on 'mouseenter', ->
    item = d3.select(this)
    if item.attr('fill') isnt 'pink'
      count++
      svg.select('text').text(count)
      # coord = d3.mouse(svg.node())
      item.transition()
        .duration(500)
        .attr('cx', -> w)
        .attr('cy', -> 0)
        .attr('class', '')
        # .attr('cx', -> Math.random() * w)
        # .attr('cy', -> Math.random() * h)
    item.attr('fill', 'pink')

  delay = 5000
  tick = ->
    # delay -= 500
    # if delay < 0
    #   return
    console.log 'tick'
    svg.selectAll('circle.unselected')
      .transition()
      .duration(1000)
      .attr('cx', -> Math.random() * w)
      .attr('cy', -> Math.random() * h)
      .attr('r', -> Math.random() * 40)
      # .attr('opacity', -> Math.random())

    setTimeout tick, delay
  
  tick()

$ ->
  change = ->
    $('#chartArea').empty()
    switch $('select').val()
      when 'splines'
        splines()
      when 'webdots'
        webdots()

  $('select').change change

  change()
