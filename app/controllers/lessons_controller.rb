class LessonsController < ApplicationController
  LESSONS_WATCHER = LessonsWatcher.new

  def index
    @presenter = @presenter.merge({
      lessons: Lesson.all(current_user),
    })
  end

  def show
    lesson = Lesson.find(params[:key], current_user)
    unless lesson
      flash[:alert] = "There isn't a lesson with the key: #{params[:key]}"
      render and return
    end
    @presenter = @presenter.merge({
      lesson: lesson,
      page: params[:page].to_i || 1,
    })
  end

end
