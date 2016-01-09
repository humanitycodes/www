class UsersController < ApplicationController

  def report
    user = User.find_by(username: params[:username])
    @presenter = {
      lessons: Lesson.all(user, force_refresh: params[:force]),
      user: user
    }
  end

end
