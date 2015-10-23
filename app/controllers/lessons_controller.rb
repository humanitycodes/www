class LessonsController < ApplicationController

  def index
    lessons = Lesson.all(
      current_user,
      force_refresh: request.format.symbol == :json || params[:force]
    )
    @presenter = @presenter.merge({
      lessons: lessons,
    })
    respond_to do |format|
      format.html
      format.json { render json: @presenter.to_json }
    end
  end

  def show
    lesson = Lesson.find(
      params[:key],
      current_user,
      force_refresh: request.format.symbol == :json || params[:force]
    )
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
