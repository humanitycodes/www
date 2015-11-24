describe 'LessonProjectSubmissionInstructions' (_) !->

  before-each !->
    @LessonProjectSubmissionInstructions = require '../lesson-project-submission-instructions.ls'

  describe 'when passed a static lesson with undefined submission-instructions' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@LessonProjectSubmissionInstructions) do
          project-folder-name: 'codelab-blah-folder'
          categories: <[ html ]>

      @rendered-component = TestUtils.find-rendered-component-with-type(component, @LessonProjectSubmissionInstructions)

    it 'renders an ordered list of items' !->
      node = ReactDOM.find-DOM-node @rendered-component
      expect node.tag-name .to-equal 'OL'

    describe 'the ordered list' (_) !->

      before-each !->
        @node = ReactDOM.find-DOM-node @rendered-component

      it 'lists the appropriate default first item' !->
        expect(
          @node
            |> (.get-elements-by-tag-name 'li')
            |> first
            |> (.inner-HTML)
        ).to-equal """<code data-reactid=".1.0.0">cd</code><span data-reactid=".1.0.1"> into your </span><code data-reactid=".1.0.2">codelab-blah-folder</code><span data-reactid=".1.0.3"> directory (unless you're already there)</span>"""

      it 'mentions surge in the last item' !->
        expect(
          @node
            |> (.get-elements-by-tag-name 'li')
            |> last
            |> (.inner-HTML)
        ).to-contain 'surge'

  describe 'when passed a dynamic lesson with undefined submission instructions' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@LessonProjectSubmissionInstructions) do
          project-folder-name: 'codelab-blah-folder'
          categories: <[ html ruby css ]>

      @rendered-component = TestUtils.find-rendered-component-with-type(component, @LessonProjectSubmissionInstructions)

    it 'renders an ordered list of items' !->
      node = ReactDOM.find-DOM-node @rendered-component
      expect node.tag-name .to-equal 'OL'

    describe 'the ordered list' (_) !->

      before-each !->
        @node = ReactDOM.find-DOM-node @rendered-component

      it 'mentions heroku in the last item' !->
        expect(
          @node
            |> (.get-elements-by-tag-name 'li')
            |> last
            |> (.inner-HTML)
        ).to-contain 'heroku'

  describe 'when passed a static lesson with custom submission-instructions' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@LessonProjectSubmissionInstructions) do
          submission-instructions:
            * 'this is the __first__ instruction'
            * 'this is the __last__ instruction'
          project-folder-name: 'codelab-blah-folder'
          categories: <[ html ]>

      @rendered-component = TestUtils.find-rendered-component-with-type(component, @LessonProjectSubmissionInstructions)

    it 'renders an ordered list of items' !->
      node = ReactDOM.find-DOM-node @rendered-component
      expect node.tag-name .to-equal 'OL'

    describe 'the ordered list' (_) !->

      before-each !->
        @node = ReactDOM.find-DOM-node @rendered-component

      it 'lists the first item as unwrapped markdown' !->
        expect(
          @node
            |> (.get-elements-by-tag-name 'li')
            |> first
            |> (.inner-HTML)
        ).to-equal "this is the &lt;strong&gt;first&lt;/strong&gt; instruction\n"
