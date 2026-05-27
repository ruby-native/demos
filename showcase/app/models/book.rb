class Book < ApplicationRecord
  belongs_to :user
  has_many :notes, dependent: :destroy
  has_one_attached :cover

  enum :status, { want_to_read: 0, currently_reading: 1, finished: 2 }

  validates :title, :author, presence: true

  scope :recent, -> { order(created_at: :desc) }

  def status_label
    case status
    when "want_to_read" then "Want to read"
    when "currently_reading" then "Currently reading"
    when "finished" then "Finished"
    end
  end
end
