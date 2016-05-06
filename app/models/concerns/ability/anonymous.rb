module Concerns::Ability::Anonymous

  def user_abilities
    can :read, ::User
  end

  def lesson_abilities
    can :read, ::Lesson
  end

end
