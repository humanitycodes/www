var config = require('./dev.config');

var lsLoader = config.module.loaders.filter(function(loader) { return loader.key === 'ls' })[0]
lsLoader.loaders.unshift('react-hot');

config.output.publicPath = 'http://localhost:8080/assets/'

config.entry.main.push(
  'webpack/hot/only-dev-server',
  'webpack-dev-server/client?http://localhost:8080'
)

module.exports = config;
