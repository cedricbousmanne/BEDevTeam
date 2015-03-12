Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret
end