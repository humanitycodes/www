const Project = require './factories/project.ls'

describe 'LessonNextStepStarted' (_) !->

  before-each !->
    @LessonNextStepStarted = require '../lesson-next-step-started.ls'

  describe 'when passed valid data' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@LessonNextStepStarted) do
          repo-URL: 'https://github.com/chrisvfritz/codelab-something'
          project: Project.build!
          categories: <[ something ]>

      @rendered-component = TestUtils.find-rendered-component-with-type(component, @LessonNextStepStarted)

    it 'renders' !->
      expect @rendered-component .to-be-defined!
