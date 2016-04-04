class StudentsController < ApplicationController
  load_and_authorize_resource :student, class: false

  def index
    @presenter = @presenter.merge({
      userLessons: User.subscribed.map do |user|
        {
          user: user,
          lessons: Lesson.all(user)
        }
      end
    })
  end
end
