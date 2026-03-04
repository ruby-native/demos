class Habit < ApplicationRecord
  belongs_to :user
  has_many :completions, dependent: :destroy

  validates :name, presence: true

  def completed_on?(date)
    completions.exists?(completed_on: date)
  end

  def completions_this_week
    completions.where(completed_on: Date.current.beginning_of_week..Date.current.end_of_week).count
  end
end
