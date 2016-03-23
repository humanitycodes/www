class UsersController < ApplicationController
  before_action :get_user, only: [:show, :edit]
  load_and_authorize_resource

  def show
    event_times = Rails.cache.fetch("Public GitHub events for #{@user.username}", expires_in: 1.day) do
      (1..3).to_a.map do |page|
        Github.new(
          user: @user.username,
          oauth_token: @user.github_token
        ).activity.events.performed(
          @user.username,
          public: true,
          per_page: 100,
          page: page
        ).body
      end.flatten.map(&:created_at)
    end

    @presenter = @presenter.merge({
      lessons: Lesson.all(@user, force_refresh: params[:force]),
      eventTimes: event_times,
      presentedUser: @user
    })
  end

  def edit
  end

private

  def get_user
    @user = User.find_by(username: params[:id])
  end

end
