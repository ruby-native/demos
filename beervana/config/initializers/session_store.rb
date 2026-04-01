# Apple Sign in uses form_post (cross-origin POST callback).
# SameSite=Lax cookies are dropped on cross-origin POSTs, breaking OmniAuth state verification.
# SameSite=None requires Secure, which only works over HTTPS (tunnel or production).
# In development, use Lax so cookies work over plain HTTP.
if Rails.env.production?
  Rails.application.config.session_store :cookie_store, same_site: :none, secure: true
else
  Rails.application.config.session_store :cookie_store
end
