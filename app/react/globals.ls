root = global or window

# POLYFILLS
SVGElement?prototype.getTransformToElement ?= (toElement) ->
  toElement.getScreenCTM!.inverse!.multiply @getScreenCTM!

# VENDOR ASSIGN
root import
  jQuery:   require 'jquery'
  React:    require 'react'
  ReactDOM: require 'react-dom'
  Radium:   require 'radium'
  $:        require 'arch-dom'

# STANDARD LIBRARY
root import require 'prelude-ls'

# CONFIG
root import
  CONFIG:
    mentors: require './config/mentors.ls'

# HELPERS
for key of $
  root["$#{key}"] = $[key]
root import require './helpers.ls'

# VENDOR RUN
if window?
  require 'bootstrap/js/tooltip'
  require 'bootstrap/js/popover'
