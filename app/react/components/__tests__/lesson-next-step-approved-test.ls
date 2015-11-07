describe 'LessonNextStepApproved' (_) !->

  before-each !->
    LessonNextStepApproved = require '../lesson-next-step-approved.ls'
    component = TestUtils.render-into-document do
      $(LessonNextStepApproved)!
    @rendered-component = TestUtils.find-rendered-component-with-type(component, LessonNextStepApproved)

    it 'renders' !->
      expect @rendered-component .to-be-defined!
