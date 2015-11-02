root = global || window

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
if document?
  require 'jquery-ujs'
  # require 'bootstrap/js/dropdown'
  require 'bootstrap/js/tooltip'
  require 'bootstrap/js/popover'

  jQuery(document).ready !->
    jQuery('[data-toggle="popover"]').popover do
      container: 'body'
      placement: 'bottom'
      animation: false
      trigger: 'hover'
