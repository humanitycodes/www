class LessonsController < ApplicationController

  def search
    @pages = Lesson.search params[:query], current_user
  end

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

  def project
    @lesson = Lesson.find(
      params[:key],
      current_user
    )

    all_user_lessons = User.all.map do |user|
      OpenStruct.new({
        lesson: Lesson.find(params[:key], user),
        user: user
      })
    end

    @approved_user_lessons = all_user_lessons.select do |user_lesson|
      user_lesson.lesson.project['status'] == 'approved'
    end.sort_by do |user_lesson|
      user_lesson.lesson.project['approvedAt']
    end.reverse

    @ongoing_user_lessons = all_user_lessons.select do |user_lesson|
      %w(started submitted).include?(user_lesson.lesson.project['status']) &&
        user_lesson.user.subscribed?
    end.sort_by do |user_lesson|
      user_lesson.lesson.project['submittedAt']
    end.reverse

    ready_user_lessons = all_user_lessons.select do |user_lesson|
      user_lesson.lesson.prereqs.map do |prereq_key|
        Lesson.find(prereq_key, user_lesson.user)
      end.all? { |lesson| lesson.project['status'] == 'approved' }
    end

    submitted_user_lessons = ready_user_lessons.select do |user_lessons|
      status = user_lessons.lesson.project['status']
      status && status != 'started'
    end
    @popularity_score = (
      submitted_user_lessons.size.to_f /
      ready_user_lessons.size *
      100
    ).round
  end

end
