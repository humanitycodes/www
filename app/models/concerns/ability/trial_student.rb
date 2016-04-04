module Concerns::Ability::TrialStudent

  def subscription_abilities
    if @user.subscribed?
      can [:update, :destroy], Subscription
    else
      can :create, Subscription
    end
  end

  def lesson_abilities
    can :show, Lesson do |lesson|
      lesson.project['status'] == 'approved' ||
        @user.lesson_statuses.values.select do |status|
          status == 'approved'
        end.count <= 3
    end
  end

end
