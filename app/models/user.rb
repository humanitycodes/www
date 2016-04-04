class User < ActiveRecord::Base
  include Concerns::User::Authentication
  include Concerns::User::Validations

  has_one :customer_identity

  serialize :github_omniauth_hash, Hash

  acts_as_voter

  scope :subscribed, -> {
    where(
      id: CustomerIdentity.where(
        id: Subscription.pluck(:customer_identity_id)
      ).pluck(:user_id)
    )
  }

  def to_param
    username
  end

  def portfolio_url
    "https://github.com/search?q=user%3A#{username}+codelab&type=Repositories"
  end

  def subscribed?
    !!try(:customer_identity).try(:subscription)
  end
end
