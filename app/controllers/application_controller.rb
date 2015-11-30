class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :prepare_presenter

private

  def prepare_presenter
    @presenter = {
      user: current_user,
      authenticityToken: form_authenticity_token
    }
  end

  # --------------
  # AUTHENTICATION
  # --------------

  def current_user
    @current_user ||= User.last #User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end
  helper_method :current_user

  def user_signed_in?
    @user_signed_in ||= !!current_user
  end
  helper_method :user_signed_in?

end
