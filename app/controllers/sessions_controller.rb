class SessionsController < ApplicationController

  def create
    redirect_url = case request.referer
    when nil, 'https://github.com/' then lessons_path
    else                                 request.referer
    end

    user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to redirect_url, notice: 'Signed in!'
  rescue
    redirect_to redirect_url, alert: 'Authentication error!'
  end

  def destroy
    session[:user_id] = nil
    redirect_to :back, notice: 'Signed out!'
  end

  def failure
    redirect_to root_url, alert: 'Authentication error'
  end

end
