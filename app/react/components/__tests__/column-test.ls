describe 'Card' (_) !->

  before-each !->
    Column = require '../column.ls'
    component = TestUtils.render-into-document do
      $(Column) do
        md: 1
        sm: 2
        md-offset: 3
        sm-offset: 4
        'blarg'
    @rendered-component = TestUtils.find-rendered-component-with-type(component, Column)

  it 'renders' !->
    expect @rendered-component .to-be-defined!

  it 'receives children' !->
    node = ReactDOM.find-DOM-node @rendered-component
    expect node.text-content .to-equal "blarg"

  it 'receives column sizing props and converts to classes' !->
    node = ReactDOM.find-DOM-node @rendered-component
    classes = Array.prototype.slice.call node.class-list, 0
    expect classes .to-contain 'col-md-1'
    expect classes .to-contain 'col-sm-2'

  it 'receives column offset props and converts to classes' !->
    node = ReactDOM.find-DOM-node @rendered-component
    classes = Array.prototype.slice.call node.class-list, 0
    expect classes .to-contain 'col-md-offset-3'
    expect classes .to-contain 'col-sm-offset-4'
