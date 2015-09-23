(() => {
  // http://stackoverflow.com/questions/29093396/how-do-you-check-the-difference-between-an-ecmascript-6-class-and-function#answer-29094209
  const isClass = property => {
    property === 'function' && /^class\s/.test( Function.prototype.toString.call(property) )
  }

  Object.keys(CodeLab).forEach(key => {
    if (isClass(CodeLab[key]) && CodeLab[key].prototype.render) {
      CodeLab[key].prototype.displayName = key
    }
  })
})()
