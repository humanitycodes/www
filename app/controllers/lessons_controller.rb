class LessonsController < ApplicationController
  LESSONS_WATCHER = LessonsWatcher.new

  def index
    @presenter = @presenter.merge({
      lessons: Lesson.all(current_user),
      userSignedIn: user_signed_in?
    })
  end

  def show
    @presenter = @presenter.merge({
      lesson: Lesson.find(params[:key], current_user),
      page: params[:page].to_i || 1,
      userSignedIn: user_signed_in?
    })
  end

end
