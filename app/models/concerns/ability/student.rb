module Concerns::Ability::Student

  def user_abilities
    can :update, User do |current_user|
      current_user == user
    end
  end

  def lesson_abilities
    can :show, Lesson
  end

end
