describe 'LessonNextStepUnstarted' (_) !->

  before-each !->
    @LessonNextStepUnstarted = require '../lesson-next-step-unstarted.ls'

  describe 'when passed valid data' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@LessonNextStepUnstarted) do
          lesson-key: 'static-laptop-setup'

      @rendered-component = TestUtils.find-rendered-component-with-type(component, @LessonNextStepUnstarted)

    it 'renders' !->
      expect @rendered-component .to-be-defined!
