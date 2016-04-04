module Concerns::Ability::Mentor
  def student_abilities
    can :read, :student
  end
end
