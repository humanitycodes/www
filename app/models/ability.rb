class Ability
  include CanCan::Ability

  ROLES = [
    :anonymous,     # never signed up through GitHub
    :trial_student, # signed up through GitHub, but no subscription
    :student,       # has a subscription
    :mentor,        # Mentor role in config/codelab_staff.yml
    :leader,        # Leader role in config/codelab_staff.yml
    :developer      # Developer role in config/codelab_staff.yml
  ]

  attr_accessor :user

  def initialize user
    @user = user
    if user
      return developer_abilities if is_staff_with_role user, :developer
      return leader_abilities    if is_staff_with_role user, :leader
      return mentor_abilities    if is_staff_with_role user, :mentor
      student_abilities
      # return student_abilities   if user.subscribed?
      # trial_student_abilities
    else
      anonymous_abilities
    end
  end

private

  ROLES.each_with_index do |role, index|
    last_role = index > 0 ? ROLES[index - 1] : nil
    define_method "#{role}_abilities" do
      send("#{last_role}_abilities") if last_role
      abilities_for role
    end
  end

protected

  def abilities_for role
    abilities_module = "Concerns::Ability::#{role.to_s.titleize.gsub(/\s/,'')}".constantize
    abilities_module.
      public_instance_methods.
      each do |ability_method|
        abilities_module.public_instance_method(ability_method).bind(self).call
      end
  end

  def is_staff_with_role user, role
    StaffMember.
      send(role.to_s.pluralize).
      map(&:username).
      include? user.username
  end

end
