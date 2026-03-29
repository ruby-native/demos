class Subscription < ApplicationRecord
  belongs_to :user

  scope :active, -> { where(status: "active") }

  def active?
    status == "active"
  end
end
