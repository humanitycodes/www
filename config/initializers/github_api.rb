Github.configure do |config|
  config.client_id     = Rails.application.secrets[:omniauth][:github][:id]
  config.client_secret = Rails.application.secrets[:omniauth][:github][:secret]
  config.ssl           = { verify: false }
end
