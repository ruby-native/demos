Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
    Rails.application.credentials.dig(:omniauth, :google, :client_id),
    Rails.application.credentials.dig(:omniauth, :google, :client_secret)

  provider :apple,
    Rails.application.credentials.dig(:omniauth, :apple, :client_id),
    "",
    scope: "email name",
    team_id: Rails.application.credentials.dig(:omniauth, :apple, :team_id),
    key_id: Rails.application.credentials.dig(:omniauth, :apple, :key_id),
    pem: Rails.application.credentials.dig(:omniauth, :apple, :private_key)
end
