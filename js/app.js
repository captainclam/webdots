(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var init;

_.templateSettings.interpolate = /{{([\s\S]+?)}}/g;

init = function() {
  var colorScale, count, dataset, delay, h, svg, tick, w, yScale, zoom;
  w = 1200;
  h = 800;
  zoom = function() {
    return svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
  };
  dataset = _.map(_.range(200), function(i) {
    return {
      x: Math.random() * w,
      y: Math.random() * h,
      r: Math.random() * 40
    };
  });
  svg = d3.select('#chartArea').append('svg').attr('width', w).attr('height', h).append("g").call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", zoom)).append("g");
  yScale = d3.scale.linear().domain([0, 100]).range([0, h]);
  colorScale = d3.scale.linear().domain([0, 40]).range([0, 0.5]);
  count = 0;
  svg.append('text').attr('x', w - 400).attr('y', 200).style('font-size', 200).style('opacity', 0.2).text(count);
  svg.append('rect').attr('width', w).attr('height', h).attr('class', 'overlay');
  svg.selectAll('circle').data(dataset).enter().append('circle').attr('r', function(d) {
    return d.r;
  }).attr('cx', function(d) {
    return d.x;
  }).attr('cy', function(d) {
    return d.y;
  }).attr('fill', 'steelblue').attr('opacity', function(d) {
    return colorScale(d.r);
  });
  svg.selectAll('circle').on('mouseenter', function() {
    var item;
    item = d3.select(this);
    if (item.attr('fill') !== 'pink') {
      count++;
      svg.select('text').text(count);
    }
    return item.attr('fill', 'pink');
  });
  delay = 1500;
  tick = function() {
    console.log('tick');
    svg.selectAll('circle').transition().duration(1000).attr('cx', function() {
      return Math.random() * w;
    }).attr('cy', function() {
      return Math.random() * h;
    }).attr('r', function() {
      return Math.random() * 40;
    });
    return setTimeout(tick, delay);
  };
  return tick();
};

$(init);


},{}]},{},[1]);