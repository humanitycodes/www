describe 'LessonNextStepSubmitted' (_) !->

  before-each !->
    @LessonNextStepSubmitted = require '../lesson-next-step-submitted.ls'

  describe 'when passed valid data' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@LessonNextStepSubmitted) do
          repo-URL: 'https://github.com/chrisvfritz/codelab-whatever'
          categories: <[ wip js ]>

      @rendered-component = TestUtils.find-rendered-component-with-type(component, @LessonNextStepSubmitted)

    it 'renders' !->
      expect @rendered-component .to-be-defined!
