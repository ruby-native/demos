# Apple Sign in uses form_post (cross-origin POST callback).
# SameSite=Lax cookies are dropped on cross-origin POSTs, breaking OmniAuth state verification.
# SameSite=None requires Secure, which only works over HTTPS (tunnel or production).
# Use Lax for plain HTTP development to avoid CSRF issues.
if Rails.env.production? || ENV["RAILS_SERVE_HTTPS"].present?
  Rails.application.config.session_store :cookie_store, same_site: :none, secure: true
end
