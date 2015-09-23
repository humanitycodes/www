class User < ActiveRecord::Base
  include Concerns::User::Authentication
  include Concerns::User::Validations

  serialize :github_omniauth_hash, Hash

  acts_as_voter

  def portfolio_url
    "https://github.com/search?q=user%3A#{username}+codelab&type=Repositories"
  end
end
