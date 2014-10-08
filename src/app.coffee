_.templateSettings.interpolate = /{{([\s\S]+?)}}/g

window.timeout = null

splines = require './modules/splines.coffee'
webdots = require './modules/webdots.coffee'
versions = require './modules/versions.coffee'

$ ->
  change = ->
    $('#chartArea').empty()
    clearTimeout timeout
    switch $('select').val()
      when 'splines'
        splines()
      when 'webdots'
        webdots()
      when 'versions'
        versions()

  $('select').change change

  change()
