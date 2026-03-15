# Fix OpenSSL 3.0 compatibility with action_push_native.
# OpenSSL::PKey::EC.new(pem) was removed in OpenSSL 3.0.
# See https://github.com/ruby/openssl/issues/395
Rails.application.config.after_initialize do
  ActionPushNative::Service::Apns::TokenProvider.prepend(Module.new do
    private

    def generate
      payload = { iss: config.fetch(:team_id), iat: Time.now.utc.to_i }
      header  = { kid: config.fetch(:key_id) }
      private_key = OpenSSL::PKey.read(config.fetch(:encryption_key))
      JWT.encode(payload, private_key, "ES256", header)
    end
  end)
end
