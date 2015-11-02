var livescript = require('livescript')

module.exports = {
	process: function(source, filename) {
		// Ignore all files within node_modules
		// if (filename.indexOf('node_modules') !== -1) {
		// 	return ''
		// }
		// Don't compile non-LiveScript files
		if (filename.indexOf('.ls') === -1) {
			return source
		}
		return livescript.compile(source, {
      bare: true,
      sourceMap: false
    })
	}
}
