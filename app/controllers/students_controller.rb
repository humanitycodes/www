class StudentsController < ApplicationController
  load_and_authorize_resource :student, class: false, only: [:index]

  def index
    @presenter = @presenter.merge({
      userLessons: User.subscribed.map do |user|
        {
          user: user,
          lessons: Lesson.all(user)
        }
      end
    })
  end

  def projects
    authorize! :read, :student
    subscribed_or_active_users = [
      *User.subscribed.to_a,
      *User.active.to_a
    ].uniq.select do |user|
      ! %w(chrisvfritz BioodMage).include? user.username
    end
    @presenter = @presenter.merge({
      'lessons' => subscribed_or_active_users.map do |user|
        Lesson.all(user).select do |lesson|
          lesson.project['status'] == 'submitted'
        end.map do |lesson|
          lesson.instance_values.merge({
            'user' => user.attributes
          })
        end
      end.flatten.sort_by do |lesson|
        lesson['project']['submittedAt']
      end.reverse
    })
  end
end
