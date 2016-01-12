class MentorsController < ApplicationController

  def feedback
    user = User.find_by(username: params[:username])

    unless user
      redirect_to root_url, alert: 'No user exists with that username.' and return
    end

    events = (1..3).to_a.map do |page|
      Github.new(
        user: user.username,
        oauth_token: user.github_token
      ).activity.events.performed(
        user.username,
        public: true,
        per_page: 100,
        page: page
      )
    end.flatten

    @comments = events.select do |event|
      event.payload.comment &&
        event.payload.comment.issue_url =~ /codelab-/
    end.map do |event|
      event.payload.comment
    end.map do |comment|
      OpenStruct.new(
        student: comment.issue_url.match(%r{/repos/(.+)/codelab-})[1],
        url: comment.html_url,
        body: comment.body,
        created_at: Date.parse(comment.created_at.split('T')[0])
      )
    end

    @min_date = params[:min_date].present? ?
      Date.parse(params[:min_date]) :
      @comments.map { |comment| comment.created_at }.min
  end

end
