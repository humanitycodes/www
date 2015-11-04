describe 'ContactMethod' (_) !->

  before-each !->
    @ContactMethod = require '../contact-method.ls'

  describe 'when passed a GitHub contact method for chrisvfritz without a URL' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@ContactMethod) do
          method:
            type: 'GitHub'
            body: 'chrisvfritz'
      @rendered-component = TestUtils.find-rendered-component-with-type(component, @ContactMethod)

    it 'renders an anchor tag' !->
      node = ReactDOM.find-DOM-node @rendered-component
      expect node.tag-name .to-equal 'A'

    describe 'the anchor tag' (_) !->

      before-each !->
        @node = ReactDOM.find-DOM-node @rendered-component

      it 'has the correct href set' !->
        expect @node.get-attribute('href') .to-equal 'https://github.com/chrisvfritz'

      it 'has the correct href set' !->
        expect @node.get-attribute('href') .to-equal 'https://github.com/chrisvfritz'

      it 'contains an icon' !->
        expect @rendered-component.refs.icon .to-be-defined!

      describe 'the icon element' (_) !->

        before-each !->
          @icon-node = ReactDOM.find-DOM-node @rendered-component.refs.icon

        it 'uses the icon element type' !->
          expect @icon-node.tag-name .to-equal 'I'

        it 'has the correct classes for font-awesome' !->
          expect @icon-node.class-name .to-equal 'fa fa-github'

      it 'uses the displays the method type as the content' !->
        content-node = ReactDOM.find-DOM-node @rendered-component.refs.content
        expect content-node.inner-HTML .to-equal 'GitHub'

  describe 'when passed a GitHub contact method for chrisvfritz without a URL' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@ContactMethod) do
          method:
            type: 'GitHub'
            body: 'chrisvfritz'
            url: 'blarst'
      @rendered-component = TestUtils.find-rendered-component-with-type(component, @ContactMethod)

    it 'renders anchor tag with the correct URL' (_) !->
      node = ReactDOM.find-DOM-node @rendered-component
      expect node.get-attribute('href') .to-equal 'blarst'
