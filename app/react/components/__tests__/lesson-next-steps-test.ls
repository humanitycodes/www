const Lesson = require './factories/lesson.ls'
const User = require './factories/user.ls'

describe 'LessonNextSteps' (_) !->

  before-each !->
    @LessonNextSteps = require '../lesson-next-steps.ls'

  describe 'when passed valid data' (_) !->

    before-each !->
      component = TestUtils.render-into-document do
        $(@LessonNextSteps) do
          lesson: Lesson.build!
          user: User.build!

      @rendered-component = TestUtils.find-rendered-component-with-type(component, @LessonNextSteps)

    it 'renders' !->
      expect @rendered-component .to-be-defined!
