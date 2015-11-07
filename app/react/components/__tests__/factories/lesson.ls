const { Factory } = require 'rosie'
const Project = require './project.ls'

module.exports = new Factory()
  .sequence 'key'
  .attr 'project', ['project'], (project) ->
    Project.attributes(project)
  .attr 'categories', ['categories'], (categories) ->
    categories or= [
      Math.random!.to-string!
    ]
