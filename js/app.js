(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);throw new Error("Cannot find module '"+o+"'")}var f=n[o]={exports:{}};t[o][0].call(f.exports,function(e){var n=t[o][1][e];return s(n?n:e)},f,f.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
var h, splines, svg, timeout, w, webdots, zoom;

_.templateSettings.interpolate = /{{([\s\S]+?)}}/g;

svg = null;

timeout = null;

w = 1200;

h = 800;

zoom = function() {
  return svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
};

splines = function() {
  var delay, tick;
  svg = d3.select('#chartArea').append('svg').attr('width', w).attr('height', h).append("g").call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", zoom)).append("g");
  svg.append('rect').attr('width', w).attr('height', h).attr('class', 'overlay');
  delay = 100;
  tick = function() {
    var from, line, middle, to;
    from = [_.random(0, w), _.random(0, h)];
    to = [_.random(0, w), _.random(0, h)];
    middle = [Math.abs(from[0] - to[0]), Math.abs(from[1] - to[1])];
    console.log(from, middle, to);
    line = d3.svg.line();
    line.interpolate('basis');
    svg.append('path').datum([from, middle, to]).attr('d', line).attr('class', 'line');
    return timeout = setTimeout(tick, delay);
  };
  return tick();
};

webdots = function() {
  var colorScale, count, dataset, delay, tick, yScale;
  dataset = _.map(_.range(200), function(i) {
    return {
      x: Math.random() * w,
      y: Math.random() * h,
      r: (Math.random() * 40) + 10
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
  }).attr('fill', 'steelblue').attr('class', 'unselected').attr('opacity', function(d) {
    return colorScale(d.r);
  });
  svg.selectAll('circle').on('mouseenter', function() {
    var item;
    item = d3.select(this);
    if (item.attr('fill') !== 'pink') {
      count++;
      svg.select('text').text(count);
      item.transition().duration(500).attr('cx', function() {
        return w;
      }).attr('cy', function() {
        return 0;
      }).attr('class', '');
    }
    return item.attr('fill', 'pink');
  });
  delay = 5000;
  tick = function() {
    console.log('tick');
    svg.selectAll('circle.unselected').transition().duration(1000).attr('cx', function() {
      return Math.random() * w;
    }).attr('cy', function() {
      return Math.random() * h;
    }).attr('r', function() {
      return Math.random() * 40;
    });
    return timeout = setTimeout(tick, delay);
  };
  return tick();
};

$(function() {
  var change;
  change = function() {
    $('#chartArea').empty();
    clearTimeout(timeout);
    switch ($('select').val()) {
      case 'splines':
        return splines();
      case 'webdots':
        return webdots();
    }
  };
  $('select').change(change);
  return change();
});


},{}]},{},[1]);