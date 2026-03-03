class User < ApplicationRecord
  has_secure_password

  has_many :orders, dependent: :destroy
  has_many :reward_activities, dependent: :destroy
  has_many :push_devices, class_name: "ApplicationPushDevice", as: :owner, dependent: :destroy

  validates :email, presence: true, uniqueness: true

  normalizes :email, with: -> { _1.strip.downcase }

  def self.from_omniauth(auth)
    uid_column = case auth.provider
    when "google_oauth2" then "google_uid"
    when "apple" then "apple_uid"
    end

    find_by(uid_column => auth.uid) || find_by(email: auth.info.email)&.tap { _1.update!(uid_column => auth.uid) } || create!(
      uid_column => auth.uid,
      email: auth.info.email,
      name: auth.info.name,
      password: SecureRandom.hex
    )
  end
end
