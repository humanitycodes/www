class RepositoriesController < ApplicationController

  def create
    Github.new(
      user: current_user.username,
      oauth_token: current_user.github_token
    ).repos.create(name: "codelab-#{params[:key]}")
    redirect_to request.referer + '#project'
  # Will occur in rare cases where a repo creation
  # is triggered twice in a row.
  rescue Github::Error::UnprocessableEntity
    redirect_to request.referer + '#project'
  end

end
