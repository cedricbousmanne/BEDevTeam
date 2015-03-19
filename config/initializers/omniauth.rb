Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, Rails.application.secrets.linkedin_provider_key, Rails.application.secrets.linkedin_provider_secret, :scope => 'r_fullprofile r_emailaddress'
  provider :github, Rails.application.secrets.github_provider_key, Rails.application.secrets.github_provider_secret
end
