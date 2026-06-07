class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :cover

  enum :status, { want_to_read: 0, currently_reading: 1, finished: 2 }

  validates :title, :author, presence: true

  # Store blank ISBNs as NULL so the partial unique index (isbn per user) treats
  # "no ISBN" as exempt rather than colliding empty strings.
  normalizes :isbn, with: ->(value) { value.strip.presence }

  scope :recent, -> { order(created_at: :desc) }

  before_save :stamp_status_timestamps, if: :status_changed?

  def status_label
    case status
    when "want_to_read" then "Want to read"
    when "currently_reading" then "Currently reading"
    when "finished" then "Finished"
    end
  end

  # Downloads the cover from cover_url and attaches it so the book owns its
  # image. Best effort: a missing or slow remote cover just leaves cover_url
  # in place, which the _cover partial still renders.
  def attach_cover_from_url
    return if cover.attached?
    return if cover_url.blank?

    require "open-uri"
    io = URI.parse(cover_url).open(open_timeout: 3, read_timeout: 5)
    cover.attach(io: io, filename: "cover.jpg", content_type: io.content_type || "image/jpeg")
  rescue => e
    Rails.logger.warn("Cover download failed for book #{id}: #{e.class} #{e.message}")
  end

  # Records reading progress and promotes a want-to-read book to currently
  # reading the first time a page is logged.
  def log_progress(page)
    page = page.to_i
    page = [ page, pages ].min if pages
    self.current_page = [ page, 0 ].max
    self.status = :currently_reading if want_to_read? && current_page.positive?
    save
  end

  private

  # Keeps started_at / finished_at consistent whenever the shelf changes, so
  # timestamps never depend on the calling code.
  def stamp_status_timestamps
    case status
    when "currently_reading"
      self.started_at ||= Time.current
      self.finished_at = nil
    when "finished"
      self.finished_at ||= Time.current
    when "want_to_read"
      self.started_at = nil
      self.finished_at = nil
    end
  end
end
