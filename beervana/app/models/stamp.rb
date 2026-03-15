class Stamp < ApplicationRecord
  belongs_to :user
  belongs_to :brewery

  validates :brewery_id, uniqueness: { scope: :user_id }

  before_validation -> { self.stamped_at ||= Time.current }, on: :create
end
