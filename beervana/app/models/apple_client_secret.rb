class AppleClientSecret
  def self.generate(credentials)
    key = OpenSSL::PKey::EC.new(credentials[:private_key])

    headers = { kid: credentials[:key_id] }
    claims = {
      iss: credentials[:team_id],
      iat: Time.now.to_i,
      exp: 5.minutes.from_now.to_i,
      aud: "https://appleid.apple.com",
      sub: credentials[:client_id]
    }

    JWT.encode(claims, key, "ES256", headers)
  end
end
