class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :brewery

  validates :brewery_id, uniqueness: {scope: :user_id}
end
