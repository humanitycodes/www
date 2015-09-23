OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
    Rails.application.secrets[:omniauth][:github][:id],
    Rails.application.secrets[:omniauth][:github][:secret],
    scope: 'user:email,notifications,public_repo'
end
