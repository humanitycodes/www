module Concerns::User::Authentication
  extend ActiveSupport::Concern

  module ClassMethods

    def from_omniauth auth
      user = find_or_initialize_by provider: auth.provider, uid: auth.uid

      user.update_attributes(
        github_omniauth_hash: auth,
        username: auth.info.nickname,
        name: auth.info.name,
        email: auth.info.email,
        image_url: auth.info.image,
        github_url: auth.info.urls.GitHub,
        github_token: auth.credentials.token
      )

      user
    end

  end

end
