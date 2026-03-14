class Brewery < ApplicationRecord
  belongs_to :neighborhood, optional: true

  has_one_attached :photo
  has_one_attached :map_light
  has_one_attached :map_dark
  has_one_attached :map_mobile_light
  has_one_attached :map_mobile_dark

  has_many :stamps, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  scope :ordered, -> { order(:name) }
  scope :visible, -> { where.not(neighborhood_id: nil) }

  def formatted_phone
    return if phone.blank?
    phone.gsub(/(\d{3})(\d{3})(\d{4})/, '(\1) \2-\3')
  end
end
