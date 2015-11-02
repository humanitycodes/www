module.exports = {
  entry: {
    main: ['./app/react/index.ls']
  },
  output: {
    path: __dirname + '/app/assets/javascripts',
    filename: 'react_bundle.js'
  },
  module: {
    loaders: [
      {
        key: 'ls',
        test: /\.ls$/,
        loaders: ['livescript']
      }, {
        key: 'yml',
        test: /\.ya?ml$/,
        loaders: ['json', 'yaml']
      }
    ],
    noParse: [/autoit.js/]
  },
  resolve: {
    extensions: ['', '.js', '.ls'],
    alias: {
      'dagre': __dirname + '/node_modules/dagre'
    }
  },
  plugins: []
}
