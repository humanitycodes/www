class RepositoriesController < ApplicationController

  def create
    Github.new(
      user: current_user.username,
      oauth_token: current_user.github_token
    ).repos.create(name: "codelab-#{params[:key]}")
    redirect_to request.referer + '#project'
  end

end
