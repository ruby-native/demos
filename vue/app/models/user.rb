class User < ApplicationRecord
  has_secure_password

  has_many :habits, -> { order(:position) }, dependent: :destroy
  has_many :push_devices, class_name: "ApplicationPushDevice", as: :owner, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end
