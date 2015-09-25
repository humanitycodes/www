class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to :back, notice: 'Signed in!'
  rescue
    redirect_to :back, alert: 'Authentication error!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, alert: 'Authentication error'
  end

end
