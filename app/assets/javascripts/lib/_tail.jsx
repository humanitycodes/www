(() => {
  const isReactComponent = property => {
    return typeof property === 'function' && property.prototype.render !== undefined
  }

  Object.keys(CodeLab).forEach(key => {
    if ( isReactComponent(CodeLab[key]) ) {
      CodeLab[key].displayName = key
    }
  })
})()
