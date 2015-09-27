class LessonsController < ApplicationController
  LESSONS_WATCHER = LessonsWatcher.new

  def index
    lessons = Lesson.all(request.format.symbol == :json && current_user)
    @presenter = @presenter.merge({
      lessons: lessons,
    })
    respond_to do |format|
      format.html
      format.json { render json: @presenter.to_json }
    end
  end

  def show
    lesson = Lesson.find(params[:key], request.format.symbol == :json && current_user)
    unless lesson
      flash.now[:alert] = "There isn't a lesson with the key: #{params[:key]}"
      render and return
    end
    @presenter = @presenter.merge({
      lesson: lesson,
      page: params[:page].to_i || 1,
    })
    respond_to do |format|
      format.html
      format.json { render json: @presenter.to_json }
    end
  end

end
