class User < ApplicationRecord
  has_many :stamps, dependent: :destroy
  has_many :stamped_breweries, through: :stamps, source: :brewery
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_breweries, through: :bookmarks, source: :brewery

  before_destroy :revoke_apple_token

  validates :apple_uid, uniqueness: true, allow_nil: true

  def self.from_omniauth(auth)
    user = find_by(apple_uid: auth.uid) || new(
      apple_uid: auth.uid,
      email: auth.info.email,
      name: auth.info.name
    )
    user.apple_refresh_token = auth.credentials.refresh_token if auth.credentials&.refresh_token
    user.save!
    user
  end

  private

  def revoke_apple_token
    return if apple_refresh_token.blank?

    credentials = Rails.application.credentials.dig(:omniauth, :apple)
    client_secret = AppleClientSecret.generate(credentials)

    Net::HTTP.post_form(
      URI("https://appleid.apple.com/auth/revoke"),
      token: apple_refresh_token,
      token_type_hint: "refresh_token",
      client_id: credentials[:client_id],
      client_secret: client_secret
    )
  rescue StandardError => e
    Rails.logger.error("Failed to revoke Apple token for user #{id}: #{e.message}")
  end
end
