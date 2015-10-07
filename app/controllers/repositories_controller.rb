class RepositoriesController < ApplicationController
  def create
    Github.new(
      user: current_user.username,
      oauth_token: current_user.github_token
    ).repos.create(name: "codelab-#{params[:key]}")
    redirect_to request.referer + '#project'
  end

  def submit
    Github.new(
      user: current_user.username,
      oauth_token: current_user.github_token
    ).issues.create(
      user: current_user.username,
      repo: "codelab-#{params[:key]}",
      title: 'Code Lab Feedback',
      body: "Can you take a look at this @chrisvfritz?"
    )
    redirect_to :back
  end
end
