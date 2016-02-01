module Concerns::Ability::Anonymous

  def user_abilities
    can :read, User
  end

end
