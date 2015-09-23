module Concerns::User::Validations
  extend ActiveSupport::Concern

  included do
    validates_presence_of :provider, :uid, :username, :name, :email, :image_url, :github_url
  end
end
