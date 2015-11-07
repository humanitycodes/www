const { Factory } = require 'rosie'

module.exports = new Factory()
  .sequence 'title'
  .attr 'criteria', ['criteria'], (criteria) ->
    criteria or= [
      Math.random!.to-string!
    ]
