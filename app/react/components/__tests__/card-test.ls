describe 'Card' (_) !->

  before-each !->
    Card = require '../card.ls'
    component = TestUtils.render-into-document do
      $(Card) style: { background-color: 'orange' }, 'blarg'
    @rendered-component = TestUtils.find-rendered-component-with-type(component, Card)

  it 'renders' !->
    expect @rendered-component .to-be-defined!

  it 'receives children' !->
    node = ReactDOM.find-DOM-node @rendered-component
    expect node.text-content .to-equal "blarg"

  it 'receives styles' !->
    node = ReactDOM.find-DOM-node @rendered-component
    expect node.get-attribute('style') .to-equal "background-color:orange;"
