svg = null
w = 1200
h = 800

radius = Math.min(w, h) / 2

color = d3.scale.ordinal().range(['green', 'orange', 'red'])

arc = d3.svg.arc()
  .outerRadius(radius - 10)
  .innerRadius(0)

pie = d3.layout.pie()
  .sort(null)
  .value (d) -> d.hits

module.exports = ->

  svg = d3.select('#chartArea').append('svg')
    .attr('width', w)
    .attr('height', h)
    .append("g")
    .attr("transform", "translate(" + w / 2 + "," + h / 2 + ")")

  d3.csv '/versions.csv', (err, rawData) ->

    data = {}
    _.each rawData, ({version, hits}) ->
      version = parseInt version
      data[version] ?= version: version, hits: 0
      data[version].hits += parseInt hits
    data = _.values data
    console.log data

    g = svg.selectAll(".arc")
      .data(pie(data))
      .enter().append("g")
      .attr("class", "arc")

    g.append("path")
      .attr("d", arc)
      .style("fill", (d, i) -> color(parseInt(d.data.version)))
    
    g.append("text")
      .attr("transform", (d) -> return "translate(" + arc.centroid(d) + ")")
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text((d) -> d.data.version)
