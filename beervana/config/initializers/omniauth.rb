Rails.application.config.middleware.use OmniAuth::Builder do
  provider :apple,
    Rails.application.credentials.dig(:omniauth, :apple, :client_id),
    "",
    scope: "email name",
    team_id: Rails.application.credentials.dig(:omniauth, :apple, :team_id),
    key_id: Rails.application.credentials.dig(:omniauth, :apple, :key_id),
    pem: Rails.application.credentials.dig(:omniauth, :apple, :private_key)

end
