module Concerns::Ability::TrialStudent

  def subscription_abilities
    if @user.subscribed?
      can [:update, :destroy], Subscription
    else
      can :create, Subscription
    end
  end

end
