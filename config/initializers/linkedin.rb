LinkedIn.configure do |config|
  config.token  = Rails.application.secrets.omniauth_provider_key
  config.secret = Rails.application.secrets.omniauth_provider_secret
end
