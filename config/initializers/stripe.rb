Rails.configuration.stripe = {
  :publishable_key => Rails.application.secrets[:stripe][:key][:publishable],
  :secret_key      => Rails.application.secrets[:stripe][:key][:secret]
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
